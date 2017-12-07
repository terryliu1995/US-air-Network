function [adjacencyMatrix, name] = constructAdj(origin,dest,weights)
%   inpute origin, destination, and flights number
%   output adjacency matrix
s = origin;
t = dest;
w = weights;
G_unuse = digraph(s,t,w);
[s2, t2] = findedge(G_unuse);
num_n = numnodes(G_unuse);
A_unsym = sparse(s2, t2, G_unuse.Edges.Weight, num_n, num_n);
A_sym = (A_unsym + A_unsym')/2;
adjacencyMatrix = A_sym;
name = G_unuse.Nodes.Name;
end

