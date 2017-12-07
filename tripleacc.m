function [C1,C2,C] = tripleacc(adj)
%getr local clustering coefficient, global clustering coefficient and avg coefficient
n = length(adj);
adj = adj>0;  % no multiple edges
[deg,~,~] = degrees(adj);
C=zeros(n,1); % initialize clustering coefficient

% multiplication change in the clust coeff formula
coeff = 2;
if isdirected(adj); coeff=1; end

for i=1:n
  
  if deg(i)==1 | deg(i)==0; C(i)=0; continue; end

  neigh=kneighbors(adj,i,1);
  edges_s=numedges(subgraph(adj,neigh));
%compute local clustering coefficent
  C(i)=coeff*edges_s/deg(i)/(deg(i)-1);

end

C1=loops3(adj)/num_conn_triples(adj);
C2=sum(C)/n;
