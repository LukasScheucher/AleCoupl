function [D,M]=genCoupl(geo,ele,nodes)


[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);

%loop over all slave elements
for j=1:geo.slave.numeletot
  cursele=ele.sbody(j,:);
  cursnodes=nodes.sbody(cursele,:);
  lcurdofs=dofs(cursnodes,0); %%TODO offest is missing here
  scurdofs=dofs(cursnodes,0); %%TODO offest is missing here
  
  De=zeros(8,8);
  for igp=1:numgp
    xilag  =gpxi(igp,:);
    xislave=gpxi(igp,:);
    Nl =sval('quad4',xilag);
    Ns =sval('quad4',xislave);
    T=[4 -2  1 -2
      -2  4 -2  1
       1 -2  4 -2
      -2  1 -2  4];
    Nl=T*Nl;
    
    Nlmat=[...
           Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
           0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
    Nsmat=[...
           Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4) 0
           0     Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4)];
    jac=det(Jacobian(cursnodes(:,1:2),xilag));
    De=De+Nlmat'*Nsmat*gpw(igp)*inv(jac);
    
  end
  
end






%loop over all slave elements
for j=1:geo.slave.numeletot
  
  curlele=ele.sbody(j,:);
  curlnodes=nodes.sbody(cursele,:);
  lcurdofs=dofs(curlnodes,0); %%TODO offest is missing here
  
  j
  icurmele=find(geo.moverlap(:,2)==j)
  curmele=ele.mbody(icurmele,:)
  curmnodes=nodes.mbody(curmele,:)
  mcurdofs=dofs(cursnodes,0) %%TODO offest is missing here
 
  for k=icurmele %% loop over all corresponding master elements
  
  xilag=gpxi(igp,:);
  Xglob=LocalToGlobal( xilag,curlnodes(:,1:2) );
  curmnodes
  xicounter=GlobalToLocal( Xglob,curmnodes(:,1:2) );
  
  
  Me=zeros(8,8);
  for igp=1:numgp
    xilag  =gpxi(igp,:);
    xislave=gpxi(igp,:);
    Nl =sval('quad4',xilag);
    Ns =sval('quad4',xislave);
    T=[4 -2  1 -2
      -2  4 -2  1
       1 -2  4 -2
      -2  1 -2  4];
    Nl=T*Nl;
    

    
    Nlmat=[...
           Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
           0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
    Nmmat=[...
           Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4) 0
           0     Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4)];
    jac=det(Jacobian(cursnodes(:,1:2),xilag));
    Me=Me+Nlmat'*Nmmat*gpw(igp)*inv(jac);
    
  end
  
  end

end



end