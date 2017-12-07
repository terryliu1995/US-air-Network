function [acc, c] = avgClusteringCoefficient(graph)
%Computes the Average Clustering Coefficient for the undirected, unweighted
%INPUT:The adjacency matrix representation of a graph.
%
%OUTPUT:acc -> Average clustering coefficient of the input graph.
%       c -> Local clustering coefficient of each of the graph's nodes
%
%Example usage:
%
%   [acc, c] = avgClusteringCoefficient(my_net);
%   acc = avgClusteringCoefficient(my_net);
%   [~, c] = avgClusteringCoefficient(my_net);
%

%% Input parsing and validation
ip = inputParser;

%Function handle to make sure the matrix is symmetric
issymmetric = @(x) all(all(x == x.'));

addRequired(ip, 'graph', @(x) isnumeric(x) && issymmetric(x));

parse(ip, graph);

%Validated parameter values
graph = ip.Results.graph;


%% Clustering coefficient computation

%Make sure the graph unweighted!!!
graph(graph ~= 0) = 1; 

deg = sum(graph, 2); %Determine node degrees
cn = diag(graph*triu(graph)*graph); %Number of triangles for each node

%The local clustering coefficient of each node
c = zeros(size(deg));
c(deg > 1) = 2 * cn(deg > 1) ./ (deg(deg > 1).*(deg(deg > 1) - 1)); 

%Average clustering coefficient of the graph
acc = mean(c(deg > 1)); 
