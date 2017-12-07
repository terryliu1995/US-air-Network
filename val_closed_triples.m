function c1=val_closed_triples(adj)
cl=0;  % initialize
cs=0;
c1=0;
for i=1:length(adj)
    neigh=kneighbors(adj,i,1);
    if length(neigh)<2; continue; end  % handle leaves, no triple here
    ca = nchoosek(neigh,2); %conbination_array
    for j = 1:size(ca,1)
       if adj(ca(j,1), ca(j,2)) ~= 0  
         cs = cs + sqrt(adj(ca(j,1), i)*adj(ca(j,2), i));
       end
    end
    cl=cl+cs;
end
c1 = cl;

