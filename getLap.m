function [lap] = getLap(A)
%  Get Laplacian matrix of adjacency matrix A;
[n, ~] = size(A);
for j = 1:n
   dx(1,j) = sum(A(j,:));
end
dg = diag(dx);
lap = dg - A;
end

