% Weighted clustering coefficient 
% Source: Barrat, The architecture of complex weighted networks
% INPUTS: weighted adjacency matrix
% OUTPUTs: vector of node weighted clustering coefficients
% Other routines used: degrees.m, kneighbors.m

function wC=weighted_clust_coeff(adj)

[deg,~,~]=degrees(adj);
n=size(adj,1); % number of nodes
wC=zeros(n,1); % initialize weighted clust coeff

for i=1:n % across all nodes
    neigh=kneighbors(adj,i,1);
    if length(neigh)<2; continue; end
    
    s=0;
    for ii=1:length(neigh)
        for jj=1:length(neigh)
          
            if adj(neigh(ii),neigh(jj))>0; s=s+(adj(i,neigh(ii))+adj(i,neigh(jj)))/2; end
        
        end
    end
   
    wC(i)=s/(deg(i)*(length(neigh)-1));
end
