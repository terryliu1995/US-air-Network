function [alpha, xmin, L]=cdf(x, varargin)
vec     = [];
sample  = [];
xminx   = [];
limit   = [];
finite  = false;
nosmall = false;
nowarn  = false;

% parse command-line parameters; trap for bad input
i=1; 
while i<=length(varargin), 
  argok = 1; 
  if ischar(varargin{i}), 
    switch varargin{i},
        case 'range',        vec     = varargin{i+1}; i = i + 1;
        case 'sample',       sample  = varargin{i+1}; i = i + 1;
        case 'limit',        limit   = varargin{i+1}; i = i + 1;
        case 'xmin',         xminx   = varargin{i+1}; i = i + 1;
        case 'finite',       finite  = true;
        case 'nowarn',       nowarn  = true;
        case 'nosmall',      nosmall = true;
        otherwise, argok=0; 
    end
  end
  if ~argok, 
    disp(['(PLFIT) Ignoring invalid argument #' num2str(i+1)]); 
  end
  i = i+1; 
end
if ~isempty(vec) && (~isvector(vec) || min(vec)<=1),
	fprintf('(PLFIT) Error: ''range'' argument must contain a vector; using default.\n');
    vec = [];
end;
if ~isempty(sample) && (~isscalar(sample) || sample<2),
	fprintf('(PLFIT) Error: ''sample'' argument must be a positive integer > 1; using default.\n');
    sample = [];
end;
if ~isempty(limit) && (~isscalar(limit) || limit<min(x)),
	fprintf('(PLFIT) Error: ''limit'' argument must be a positive value >= 1; using default.\n');
    limit = [];
end;
if ~isempty(xminx) && (~isscalar(xminx) || xminx>=max(x)),
	fprintf('(PLFIT) Error: ''xmin'' argument must be a positive value < max(x); using default behavior.\n');
    xminx = [];
end;

% reshape input vector
x = reshape(x,numel(x),1);

% select method (discrete or continuous) for fitting
if     isempty(setdiff(x,floor(x))), f_dattype = 'INTS';
elseif isreal(x),    f_dattype = 'REAL';
else                 f_dattype = 'UNKN';
end;
if strcmp(f_dattype,'INTS') && min(x) > 1000 && length(x)>100,
    f_dattype = 'REAL';
end;

% estimate xmin and alpha, accordingly
switch f_dattype,
    
    case 'REAL',
        xmins = unique(x);
        xmins = xmins(1:end-1);
        if ~isempty(xminx),
            xmins = xmins(find(xmins>=xminx,1,'first'));
        end;
        if ~isempty(limit),
            xmins(xmins>limit) = [];
        end;
        if ~isempty(sample),
            xmins = xmins(unique(round(linspace(1,length(xmins),sample))));
        end;
        dat   = zeros(size(xmins));
        z     = sort(x);
        for xm=1:length(xmins)
            xmin = xmins(xm);
            z    = z(z>=xmin); 
            n    = length(z);
            % estimate alpha using direct MLE
            a    = n ./ sum( log(z./xmin) );
            if nosmall,
                if (a-1)/sqrt(n) > 0.1
                    dat(xm:end) = [];
                    xm = length(xmins)+1;
                    break;
                end;
            end;
            % compute KS statistic
            cx   = (0:n-1)'./n;
            cf   = 1-(xmin./z).^a;
            dat(xm) = max( abs(cf-cx) );
        end;
        D     = min(dat);
        xmin  = xmins(find(dat<=D,1,'first'));
        z     = x(x>=xmin);
        n     = length(z); 
        alpha = 1 + n ./ sum( log(z./xmin) );
        if finite, alpha = alpha*(n-1)/n+1/n; end; % finite-size correction
        if n < 50 && ~finite && ~nowarn,
            fprintf('(PLFIT) Warning: finite-size bias may be present.\n');
        end;
        L = n*log((alpha-1)/xmin) - alpha.*sum(log(z./xmin));

    case 'INTS',
        
        if isempty(vec),
            vec  = (1.50:0.01:3.50);    % covers range of most practical 
        end;                            % scaling parameters
        zvec = zeta(vec);

        xmins = unique(x);
        xmins = xmins(1:end-1);
        if ~isempty(xminx),
            xmins = xmins(find(xmins>=xminx,1,'first'));
        end;
        if ~isempty(limit),
            limit = round(limit);
            xmins(xmins>limit) = [];
        end;
        if ~isempty(sample),
            xmins = xmins(unique(round(linspace(1,length(xmins),sample))));
        end;
        if isempty(xmins)
            fprintf('(PLFIT) Error: x must contain at least two unique values.\n');
            alpha = NaN; xmin = x(1); D = NaN;
            return;
        end;
        xmax   = max(x);
        dat    = zeros(length(xmins),2);
        z      = x;
        fcatch = 0;

        for xm=1:length(xmins)
            xmin = xmins(xm);
            z    = z(z>=xmin);
            n    = length(z);
            % estimate alpha via direct maximization of likelihood function
            if fcatch==0
                try
                    % vectorized version of numerical calculation
                    zdiff = sum( repmat((1:xmin-1)',1,length(vec)).^-repmat(vec,xmin-1,1) ,1);
                    L = -vec.*sum(log(z)) - n.*log(zvec - zdiff);
                catch
                    % catch: force loop to default to iterative version for
                    % remainder of the search
                    fcatch = 1;
                end;
            end;
            if fcatch==1
                % force iterative calculation (more memory efficient, but 
                % can be slower)
                L       = -Inf*ones(size(vec));
                slogz   = sum(log(z));
                xminvec = (1:xmin-1);
                for k=1:length(vec)
                    L(k) = -vec(k)*slogz - n*log(zvec(k) - sum(xminvec.^-vec(k)));
                end
            end;
            [Y,I] = max(L);
            % compute KS statistic
            fit = cumsum((((xmin:xmax).^-vec(I)))./ (zvec(I) - sum((1:xmin-1).^-vec(I))));
            cdi = cumsum(hist(z,xmin:xmax)./n);
            dat(xm,:) = [max(abs( fit - cdi )) vec(I)];
        end
        % select the index for the minimum value of D
        [D,I] = min(dat(:,1));
        xmin  = xmins(I);
        z     = x(x>=xmin);
        n     = length(z);
        alpha = dat(I,2);
        if finite, alpha = alpha*(n-1)/n+1/n; end; % finite-size correction
        if n < 50 && ~finite && ~nowarn,
            fprintf('(PLFIT) Warning: finite-size bias may be present.\n');
        end;
        L     = -alpha*sum(log(z)) - n*log(zvec(find(vec<=alpha,1,'last')) - sum((1:xmin-1).^-alpha));

    otherwise,
        fprintf('(PLFIT) Error: x must contain only reals or only integers.\n');
        alpha = [];
        xmin  = [];
        L     = [];
        return;
end;

