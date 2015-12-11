function p = plotOverlap(f,ele,nodes,geo)

figure(f)
hold on

for j=1:geo.master.numeletot
  curele  =ele.mbody(j,:);
  curnodes=nodes.mbody(curele,:)
  curcenter=sum(curnodes)*0.25;

  counterele =ele.sbody(geo.moverlap(j,2),:);
  counternodes=nodes.sbody(counterele,:)
  countercenter=sum(counternodes)*0.25
  
  plot3([curcenter(1) countercenter(1)],[curcenter(2) countercenter(2)], [0 1]);
  
end


end