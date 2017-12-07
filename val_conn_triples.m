function c2=val_conn_triples(adj)

% initialize
cv=0;
c2=0;
for i=1:length(adj)
    neigh=kneighbors(adj,i,1);
    if length(neigh)<2; continue; end  % handle leaves, no triple here
    ca = nchoosek(neigh,2); %conbination_array
    for j = 1:size(ca,1)
        cv = cv + sqrt(adj(ca(j,1), i)*adj(ca(j,2), i));
    end
    c2=c2+cv;
end

