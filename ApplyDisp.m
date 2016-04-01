function [mbodynodes,sbodynodes]=ApplyDisp(nodes,geo,mdisp,sdisp)
% apply the calcuated displacments to the nodes for the next step

%create local copies
sbodynodes=nodes.sbody;
mbodynodes=nodes.mbody;

%apply local copies
sbodynodes(geo.ilagnodes,1:2)=sbodynodes(geo.ilagnodes,1:2)+reshape(sdisp,2,geo.numlagnodes)';
mbodynodes(:,1:2)=mbodynodes(:,1:2)+reshape(mdisp,2,length(nodes.mbody))';
end