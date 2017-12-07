function [degree] = getdegree(A)
%GETDEGREE Summary of this function goes here
%   Detailed explanation goes here
[n, ~] = size(A);
dt = zeros(1,n)
for j = 1:n
   dt(j) = sum(A(j,:));
end
degree = dt;
end

