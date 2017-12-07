function [C1, C2] = val_global_weighted_cc(A, G)
n = length(A);
A = A>0;  % no multiple edges
deg = degree(G);
C=zeros(n,1); % initialize clustering coefficient

% multiplication change in the clust coeff formula
coeff = 2;

for i=1:n
  
  if deg(i)==1 || deg(i)==0; C(i)=0; continue; end

  neigh=kneighbors(A,i,1);
  edges_s=numedges(subgraph(A,neigh));
  
  C(i)=coeff*edges_s/(deg(i)*(deg(i)-1));

end

C1=val_closed_triples(A)/val_conn_triples(A);
C2=sum(C)/n;
end

