function [D,M]=genCoupl(geo,ele,nodes)

TOL=1e-8;

[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);

D=zeros(geo.syssize,geo.syssize);
M=zeros(geo.syssize,geo.syssize);

%loop over all slave elements
for j=geo.ilagele'
  cursele=ele.sbody(j,:);
  cursnodes=nodes.sbody(cursele,:);
  lcurdofs=dofs(cursele,0); %%TODO offest is missing here
  scurdofs=dofs(cursele,0); %%TODO offest is missing here
  
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
  
  %% Assemble to total systemmatrix
%   lcurdofs
%   scurdofs
%   cursnodes
%   cursele
  D(lcurdofs,scurdofs)=D(lcurdofs,scurdofs)+De;

  
end


D=D.*(D>TOL);
D=D(dofs(geo.ilagnodes,0),dofs(geo.ilagnodes,0))
%D=D(dofs(geo.ilagnodes,0),1+geo.nummdof:geo.slave.numnodetot*2+geo.nummdof)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Computation of M Matrix

%loop over all lagrange elements
for j=geo.ilagele'
  
  curlele=ele.sbody(j,:);
  curlnodes=nodes.sbody(curlele,:);
  lcurdofs=dofs(curlele,0);
  
  allmele=find(geo.mnode2sele(:,2)==j)

  for icurmele=allmele' %% loop over all corresponding master elements
    
    curmele=ele.mbody(icurmele,:)
    curmnodes=nodes.mbody(curmele,:)
    mcurdofs=dofs(curmele,0)
  

  
    Me=zeros(8,8);
    for igp=1:numgp
      xilag  =gpxi(igp,:);
      Xglob=LocalToGlobal( xilag,curlnodes(:,1:2) );
      xicounter=GlobalToLocal( Xglob,curmnodes(:,1:2) );
      
      if CheckMapping('quad4',xicounter)==0
%         j
%         icurmele
%         curlele
%         curlnodes
%         xilag
%         Xglob
%         xicounter
        %pause(30)
        continue;
      end
      
      
      Nl =sval('quad4',xilag);
      Nm =sval('quad4',xicounter);
      T=[4 -2  1 -2
        -2  4 -2  1
         1 -2  4 -2
        -2  1 -2  4];
      Nl=T*Nl; %no dual shapoe function required on master



      Nlmat=[...
             Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
             0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
      Nmmat=[...
             Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4) 0
             0     Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4)];
      jac=det(Jacobian(curlnodes(:,1:2),xilag));
      Me=Me+Nlmat'*Nmmat*gpw(igp)*inv(jac);  
    end%end loop over gausspoints
    M(lcurdofs,mcurdofs)=M(lcurdofs,mcurdofs)+Me;
  end%end loop over corresponding master elements
end%end loop over lagrange elements

% M=M.*(M>TOL);

%this is valid, since all master nodes are part of the coupling zone
M=M(dofs(geo.ilagnodes,0),1:geo.master.numnodetot*2)


end