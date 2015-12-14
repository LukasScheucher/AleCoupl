function [overlap_slave,overlap_master,ilagele,ilagnodes] = DetectOverlap(ele,nodes,geo)
%IMPORTANT the whole algorithm is built upon the assumption, that the
%master elements are very small and complety enclosed in slave elements

geo.slave.numeletot

overlap_slave=zeros(geo.slave.numeletot,2);
overlap_slave(:,1)=1:geo.slave.numeletot;

overlap_master=zeros(geo.master.numeletot,2);
overlap_master(:,1)=1:geo.master.numeletot;
lagnodes=[];


%% determine the overlap for master nodes
for j=1:geo.master.numeletot
  curele=ele.mbody(j,:)
  curnodes=nodes.mbody(curele,:)
  center=sum(curnodes)*0.25
  
  %loop over all slave elements and determine whether the point is inside the element
  for k=1:geo.slave.numeletot
     counterele=ele.sbody(k,:)
     counternodes=nodes.sbody(counterele,:)
     counternodes(:,1:2)
     [xi,converged]= GlobalToLocal( center(1:2)',counternodes(:,1:2) );
     if CheckMapping('quad4',xi)==true
       overlap_master(j,2)=k;
     end
  end
  
end


%% determine the overlap for slave nodes
% INPORTANT this only gives slave nodes mapping directly into a sele
for j=1:geo.slave.numeletot
  curele=ele.sbody(j,:)
  curnodes=nodes.sbody(curele,:)
  center=sum(curnodes)*0.25;
  
  %loop over all master elements and determine whether the point is inside the element
  for k=1:geo.master.numeletot
     counterele=ele.mbody(k,:);
     counternodes=nodes.mbody(counterele,:)
     xi= GlobalToLocal( center(1:2)',counternodes(:,1:2) );
     if CheckMapping('quad4',xi)==true
       overlap_slave(j,2)=k;
     end
  end
end

ilagele=unique(overlap_master(:,2));
ilagnodes=unique(ele.sbody(ilagele,:));
lagnodes=nodes.sbody(ilagnodes,:);

end