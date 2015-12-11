function [overlap_slave,overlap_master] = DetectOverlap(ele,nodes,geo)

geo.slave.numeletot

overlap_slave=zeros(geo.slave.numeletot,2);
overlap_slave(:,1)=1:geo.slave.numeletot;

overlap_master=zeros(geo.master.numeletot,2);
overlap_master(:,1)=1:geo.master.numeletot;


%% determine the overlap for master elements
for j=1:geo.master.numeletot
  curele=ele.mbody(j,:)
  curnodes=nodes.mbody(curele,:)
  center=sum(curnodes)*0.25
  
  %loop over all slave elements and determine whether the point is inside the element
  for k=1:geo.slave.numeletot
     counterele=ele.sbody(k,:)
     counternodes=nodes.sbody(counterele,:)
     xi= GlobalToLocal( center',counternodes );
     if CheckMapping('quad4',xi)==true
       overlap_master(j,2)=k;
     end
  end
  
end


%% determine the overlap for slave elements
for j=1:geo.slave.numeletot
  curele=ele.sbody(j,:)
  curnodes=nodes.sbody(curele,:)
  center=sum(curnodes)*0.25;
  
  %loop over all master elements and determine whether the point is inside the element
  for k=1:geo.master.numeletot
     counterele=ele.mbody(k,:);
     counternodes=nodes.mbody(counterele,:)
     xi= GlobalToLocal( center',counternodes );
     if CheckMapping('quad4',xi)==true
       overlap_slave(j,2)=k;
     end
  end
  
end

end