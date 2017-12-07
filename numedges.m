function m = numedges(adj)

sl=selfloops(adj); % counting the number of self-loops

if issymmetric(adj) & sl==0    % undirected simple graph
    m=sum(sum(adj))/2; 
    return
elseif issymmetric(adj) & sl>0
    sl=selfloops(adj);
    m=(sum(sum(adj))-sl)/2+sl; % counting the self-loops only once
    return
elseif not(issymmetric(adj))   % directed graph (not necessarily simple)
    m=sum(sum(adj));
    return
end

