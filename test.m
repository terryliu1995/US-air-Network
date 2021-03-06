%HW airline company
s_hw = HW_src;
t_hw = HW_des;
w_hw = HW_flights;
%construct adjacency matrix
[A_hw, name] = constructAdj(s_hw, t_hw, w_hw);
%I_hw = incidence(G_hw);
G_hw2 = graph(A_hw,name,'OmitSelfLoops');

%L_aa = laplacian(G_aa2);
%testeig = eigs(L_aa,93,'sm');

%A_hw2 = adjacency(G_hw2);
[n, m] = size(A_hw);
for j = 1:n
   dx(1,j) = sum(A_hw(j,:));
end
dg = diag(dx);
lap = dg - A_hw;

%total us airlines
s_us = us_src;
t_us = us_des;
w_us = us_flights;
[A_us, name_us] = constructAdj(s_us, t_us, w_us);
G_us = graph(A_us,name_us,'OmitSelfLoops');
LWidths_us = G_us.Edges.Weight/100;
[ma_us,~] = max(getdegree(A_us));
%h = histogram(degree(G_total2),'Normalization','pdf','BinLimits',[1,ma_total],'BinWidth',1);
%title('Ddegree distributions for US Airline network')
%xlabel('k');
%ylabel('P(k)');
[a, b, c] = cdf(getdegree(A_us), 'nosmall');
htest = plplot(getdegree(A_us),b,a);

figure(1);
LWidths_us = 10*G_us.Edges.Weight/max(G_us.Edges.Weight);
plot(G_us,'layout','force','NodeLabel',G_us.Nodes.Name,'LineWidth',LWidths_us);
title("US airline network");

parmhat = gpfit(getdegree(A_us));
kHat = parmhat(1);
sigmaHat = parmhat(2);
bins = 0:100:100000;

h = histogram(getdegree(A_us),'Normalization','pdf','BinLimits',[1,ma_us],'BinWidth',1);
ygrid = linspace(0,1.1*max(getdegree(A_us)),100000);
line(ygrid,gppdf(ygrid,kHat,sigmaHat),'Color','red');
xlim([0,100000]);
title('Ddegree distributions for US Airline network ')
xlabel('degree');
ylabel('Probability');

distanceset = distances(G_total2,'Method','unweighted');
[maxdistance, I] = max(distanceset(:));

diameter_total = getDia(G_total2);

pg_ranks = centrality(G_hw2,'pagerank','Importance',G_hw2.Edges.Weight);
G_hw2.Nodes.PageRank = pg_ranks;
degree_c = centrality(G_hw2,'degree','Importance',G_hw2.Edges.Weight);
G_hw2.Nodes.Degree = degree_c;
engivector = centrality(G_hw2,'eigenvector','Importance',G_hw2.Edges.Weight);
G_hw2.Nodes.eigenvector = engivector;



parmhat = gpfit(degree(G_total2));
kHat = parmhat(1);
sigmaHat = parmhat(2);
figure(10);
bins = 0:1:160;
h = histogram(degree(G_total2),'Normalization','pdf','BinWidth',1);
ygrid = linspace(0,1.1*max(degree(G_total2)),160);
line(ygrid,gppdf(ygrid,kHat,sigmaHat),'Color','red');
xlim([0,160]);
title('Ddegree distributions for US Airline network ')
xlabel('degree');

%dataset = degree(G_total2);
%tbl = tabulate(dataset);\

%pdf
figure(12);
p=polyfit(log10(degreecount(:,1)),log10(degreecount(:,3)/100),1);  
x2 = 1:1:1000;
y2 = polyval(p,x2);
h2 = maloglog(degreecount(:,1), degreecount(:,3)/100);

xlim([1,1000]);
figure(13);
x3 = 1:1:1000
h3 =loglog(x3,y2);
xlim([1,1000]);
%cdf
[a, b, c] = cdf(getdegree(A_us), 'nosmall');
htest = plplot(getdegree(A_us),b,a);


degreejet = getdegree(A_jet2);
probabilityjet = degreejet/sum(degreejet);
%fiedler vector
set(gcf,'Color',[1 1 1])
subplot(1,2,1)
plot(fwn,'k.');
xlabel('index i')
ylabel('fv(i)')
title('SW fiedler vector')
% edge_betweenness distrutution
plot(bt_dl,'k.');
xlabel('sorted nodes')
ylabel('edge betweenness centrality')
title('DL')
%remove top 5
G_aa5 = rmedge(G_aa2,'DFW','CLT');
G_wn5 = rmedge(G_wn2,'PWM','BWI');
G_ua5 = rmedge(G_ua2,'ORD','DEN');
G_dl5 = rmedge(G_dl2,'MSP','ATL');
A_aa5 = adjacency(G_aa5);
A_wn5 = adjacency(G_wn5);
A_ua5 = adjacency(G_ua5);
A_dl5 = adjacency(G_dl5);

b = algebraic_connectivity(A_ua2);