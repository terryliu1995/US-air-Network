function [diameter] = getDia(G)
%GETDIA 此处显示有关此函数的摘要
%   get the diameter of the network
diamatrix = distances(G,'Method','unweighted');
[diasize1, ~] = size(diamatrix);
diameter = sum(diamatrix(:))/(diasize1^2 - diasize1);
end

