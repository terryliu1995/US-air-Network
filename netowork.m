%us network 
s_us = total_src;
t_us = total_des;
w_us = total_flights;
[A_us, name_us] = constructAdj(s_us, t_us, w_us);
G_us = graph(A_us,name_us,'OmitSelfLoops');
%AA airline company
s_aa = AA_src;
t_aa = AA_des;
w_aa = AA_flights;

[A_aa, name_aa] = constructAdj(s_aa, t_aa, w_aa);
%undirected weighted
G_aa = graph(A_aa,name_aa,'OmitSelfLoops');
%UA airline company
s_ua = UA_src;
t_ua = UA_des;
w_ua = UA_flights;

[A_ya, name_ua] = constructAdj(s_ua, t_ya, w_ua);
G_ua = graph(A_ua,name_ua,'OmitSelfLoops');
%DL airline company
s_dl = DL_src;
t_dl = DL_des;
w_dl = DL_flights;%./DL_distance;
G_dl = digraph(s_dl,t_dl,w_dl);

nn_dl = numnodes(G_dl);
[s_dl, t_dl] = findedge(G_dl);
A_dl = sparse(s_dl, t_dl, G_dl.Edges.Weight, nn_dl, nn_dl);
%undirected weighted
G_dl2 = graph(A_dl,G_dl.Nodes.Name,'upper','OmitSelfLoops');
A_dl2 = getAdj(G_dl2);
%jetblue airline company
s_jet = Jet_src;
t_jet = Jet_des;
w_jet = Jet_flights;%./Jet_distance;
G_jet = digraph(s_jet,t_jet,w_jet);

nn_jet = numnodes(G_jet);
[s_jet, t_jet] = findedge(G_jet);
A_jet = sparse(s_jet, t_jet, G_jet.Edges.Weight, nn_jet, nn_jet);
%undirected weighted
G_jet2 = graph(A_jet,G_jet.Nodes.Name,'upper','OmitSelfLoops');
A_jet2 = getAdj(G_jet2);
%WN airline company
s_wn = WN_src;
t_wn = WN_des;
w_wn = WN_flights;%./WN_distance;
G_wn = digraph(s_wn,t_wn,w_wn);

nn_wn = numnodes(G_wn);
[s_wn, t_wn] = findedge(G_wn);
A_wn = sparse(s_wn, t_wn, G_wn.Edges.Weight, nn_wn, nn_wn);
%undirected weighted
G_wn2 = graph(A_wn,G_wn.Nodes.Name,'upper','OmitSelfLoops');
A_wn2 = getAdj(G_wn2);
%HW airline company
s_hw = HW_src;
t_hw = HW_des;
w_hw = HW_flights;%./HW_distance;
G_hw = digraph(s_hw,t_hw,w_hw);

nn_hw = numnodes(G_hw);
[s_hw, t_hw] = findedge(G_hw);
A_hw = sparse(s_hw, t_hw, G_hw.Edges.Weight, nn_hw, nn_hw);
%undirected weighted
G_hw2 = graph(A_hw,G_hw.Nodes.Name,'upper','OmitSelfLoops');
A_hw2 = getAdj(G_hw2);
%Alska airline company
s_ak = AK_src;
t_ak = AK_des;
w_ak = AK_flights;%./AK_distance;
G_ak = digraph(s_ak,t_ak,w_ak);

nn_ak = numnodes(G_ak);
[s_ak, t_ak] = findedge(G_ak);
A_ak = sparse(s_ak, t_ak, G_ak.Edges.Weight, nn_ak, nn_ak);
%undirected weighted
G_ak2 = graph(A_ak,G_ak.Nodes.Name,'upper','OmitSelfLoops');
A_ak2 = getAdj(G_ak2);
%SW airline company
s_sw = SW_src;
t_sw = SW_des;
w_sw = SW_flights;%./SW_distance;
G_sw = digraph(s_sw,t_sw,w_sw);

nn_sw = numnodes(G_sw);
[s_sw, t_sw] = findedge(G_sw);
A_sw = sparse(s_sw, t_sw, G_sw.Edges.Weight, nn_sw, nn_sw);
%undirected weighted
G_sw2 = graph(A_sw,G_sw.Nodes.Name,'upper','OmitSelfLoops');
A_sw2 = getAdj(G_sw2);
% EX airline company
s_ex = EX_src;
t_ex = EX_des;
w_ex = EX_flights;%./EX_distance;

G_ex = digraph(s_ex,t_ex,w_ex);

nn_ex = numnodes(G_ex);
[s_ex, t_ex] = findedge(G_ex);
A_ex = sparse(s_ex, t_ex, G_ex.Edges.Weight, nn_ex, nn_ex);
%undirected weighted
G_ex2 = graph(A_ex,G_ex.Nodes.Name,'lower','OmitSelfLoops');
A_ex2 = getAdj(G_ex2);
% draw the network
figure(1);
LWidths_aa = 10*G_aa2.Edges.Weight/max(G_aa2.Edges.Weight);
plot(G_aa2,'LineWidth',LWidths_aa);
title("AA");
figure(2);
LWidths_ua = 10*G_ua2.Edges.Weight/max(G_ua2.Edges.Weight);
plot(G_ua2,'LineWidth',LWidths_ua);
title("UA");
figure(3);
LWidths_dl = 10*G_dl2.Edges.Weight/max(G_dl2.Edges.Weight);
plot(G_dl2,'layout','force','NodeLabel',G_dl.Nodes.Name,'LineWidth',LWidths_dl);
title("Delta");
figure(4);
LWidths_jet = 10*G_jet2.Edges.Weight/max(G_jet2.Edges.Weight);
plot(G_jet2,'LineWidth',LWidths_jet);
title("Jetblue");
figure(5);
LWidths_wn = 10*G_wn2.Edges.Weight/max(G_wn2.Edges.Weight);
plot(G_wn2,'LineWidth',LWidths_wn);
title("SouthWest");
figure(6);
LWidths_hw = 10*G_hw2.Edges.Weight/max(G_hw2.Edges.Weight);
plot(G_hw2,'LineWidth',LWidths_hw);
title("HW");
figure(7);
LWidths_ak = 10*G_ak2.Edges.Weight/max(G_ak2.Edges.Weight);
plot(G_ak2,'LineWidth',LWidths_ak);
title("Alaska");
figure(8);
LWidths_sw = 10*G_sw2.Edges.Weight/max(G_sw2.Edges.Weight);
plot(G_sw2,'layout','force','NodeLabel',G_sw.Nodes.Name,'LineWidth',LWidths_sw);
title("SkyWest");
figure(9);
LWidths_ex = 10*G_ex2.Edges.Weight/max(G_ex2.Edges.Weight);
plot(G_ex2,'layout','force','NodeLabel',G_ex.Nodes.Name,'LineWidth',LWidths_ex);
title("Express");

%adjacency matrix:A_aa2, A_ua2, A_dl2, A_jet2, A_wn2, A_hw2, A_ak2, A_sw2,
%A_ex2

%Laplacian:d_aa d_ua...
L_aa = getLap(A_aa2);
d_aa = eigs(L_aa,10,'sm');

L_ua = getLap(A_ua2);
d_ua = eigs(L_ua,10,'sm');

L_dl = getLap(A_dl2);
d_dl = eigs(L_dl,10,'sm');

L_jet = getLap(A_jet2);
d_jet = eigs(L_jet,10,'sm');

L_wn = getLap(A_wn2);
d_wn = eigs(L_wn,10,'sm');

L_hw = getLap(A_hw2);
d_hw = eigs(L_hw,10,'sm');

L_ak = getLap(A_ak2);
d_ak = eigs(L_ak,10,'sm');

L_sw = getLap(A_sw2);
d_sw = eigs(L_sw,10,'sm');

L_ex = getLap(A_ex2);
d_ex = eigs(L_ex,10,'sm');

%total US Airline Network
s_total = total_src;
t_total = total_des;
w_total = total_flights;
G_total = digraph(s_total,t_total,w_total);

A_total = getAdj(G_total);
G_total2 = graph(A_total,G_total.Nodes.Name,'upper','OmitSelfLoops')
A_total2 = getAdj(G_total2);

LWidths_total = G_total2.Edges.Weight/100;
plot(G_total2,'layout','force','NodeLabel',G_total2.Nodes.Name,'LineWidth',LWidths_total);

%perato distribution fitting
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
