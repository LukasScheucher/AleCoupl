function [mbodynodes,sbodynodes]=ApplyDisp(nodes,geo,mdisp,sdisp)

sbodynodes=nodes.sbody; %create a local copy
mbodynodes=nodes.mbody; %create a local copy

% reshape(sdisp,2,geo.numlagnodes)';
% geo.ilagnodes
% nodes.sbody(geo.ilagnodes,1:2);
% geo.ilagnodes
sbodynodes(geo.ilagnodes,1:2)=sbodynodes(geo.ilagnodes,1:2)+reshape(sdisp,2,geo.numlagnodes)';
mbodynodes(:,1:2)=mbodynodes(:,1:2)+reshape(mdisp,2,length(nodes.mbody))';
end