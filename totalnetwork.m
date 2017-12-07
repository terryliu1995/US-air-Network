function [A_2] = getAdj(G)
%GETADJ 此处显示有关此函数的摘要
%   此处显示详细说明
nn = numnodes(G);
[s_2, t_2] = findedge(G);
A_ = sparse(s_2, t_2, G.Edges.Weight, nn, nn);
A_2 = A_ + A_';
end

