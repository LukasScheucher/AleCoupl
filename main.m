close all
clear
clc


%% create geometry
setup

%plot geometry
f_frame=figure()
hold on
axis equal
axis off

plotframe(f_frame,1,ele.sbody,nodes.sbody,[0 0 0],1)
plotframe(f_frame,1,ele.mbody,nodes.mbody,[1 0 0],1)

f_disp=figure()
hold on
axis equal
axis off
plotframe(f_disp,1,ele.mbody,nodes.mbody,[0 0 0],0);
plotframe(f_disp,1,ele.sbody,nodes.sbody,[0 0 0],0);

%% Determine the overlap

[geo.snode2mele,geo.mnode2sele,geo.ilagele,geo.ilagnodes,]=DetectOverlap(ele,nodes,geo)


plotOverlap(f_frame,ele,nodes,geo)


geo.nummdof=geo.master.numnodetot*2;
geo.numsdof=geo.slave. numnodetot*2;
geo.numldof=length(geo.ilagnodes)*2;
geo.numlagnodes=length(geo.ilagnodes);

geo.syssize=geo.nummdof+geo.numsdof+geo.numldof;


[D,M]=genCoupl(geo,ele,nodes);


P=inv(D)*M

%% TODO Apply the displacement here

% geo.master.disp =ones(geo.nummdof,1)*0.2
% geo.slave.disp=P*geo.master.disp

[geo.master.disp]=GenDisp(ele,nodes,geo);
geo.slave.disp  =P*geo.master.disp

[nodes.mbody,nodes.sbody]=ApplyDisp(nodes,geo,geo.master.disp,geo.slave.disp);

plotframe(f_disp,1,ele.mbody,nodes.mbody,[0 0.3 0.7],0);
plotframe(f_disp,1,ele.sbody,nodes.sbody,[0 0.1 0.7],0);




