function [D,M]=genCoupl(geo,ele,nodes)


[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);

%loop over all slave elements

for j=1:geo.slave.numeletot
  cursele=ele.sbody(j,:);
  cursnodes=nodes.sbody(cursele,:);
  
  jac=det(Jacobian(nodeslag,xilag));
  
  Dmat=zeros(8,8);
  for igp=1:numgp
    
  end
  
end






end