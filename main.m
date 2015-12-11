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

plotframe(f_frame,1,ele.mbody,nodes.mbody,0)
plotframe(f_frame,1,ele.sbody,nodes.sbody,1)

%% Determine the overlap
[geo.soverlap,geo.moverlap]=DetectOverlap(ele,nodes,geo)
plotOverlap(f_frame,ele,nodes,geo)



[D,M]=genCoupl(geo,ele,nodes);

