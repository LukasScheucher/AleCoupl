function p = plotOverlap(f,ele,nodes,geo)
%description follows

figure(f)
hold on

for j=1:geo.master.numeletot
  curele  =ele.mbody(j,:);
  curnodes=nodes.mbody(curele,:)
  curcenter=sum(curnodes)*0.25;

  counterele =ele.sbody(geo.mnode2sele(j,2),:);
  counternodes=nodes.sbody(counterele,:)
  countercenter=sum(counternodes)*0.25
  
  plot3([curcenter(1) countercenter(1)],[curcenter(2) countercenter(2)], [curcenter(3) countercenter(3)]);
  
end


end