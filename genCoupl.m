function [D,M]=genCoupl(geo,ele,nodes)

TOL=1e-8;

[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);

D=zeros(geo.syssize,geo.syssize);
M=zeros(geo.syssize,geo.syssize);

%loop over all lagrange elements
for j=geo.ilagele'
  cursele=ele.sbody(j,:);
  cursnodes=nodes.sbody(cursele,:);
  
  curlele=ele.sbody(j,:);
  curlnodes=nodes.sbody(curlele,:);
  
  lcurdofs=dofs(cursele,0);
  scurdofs=dofs(cursele,0);
  
  De=zeros(8,8);
  allmele=find(geo.mnode2sele(:,2)==j);
  for icurmele=allmele' %% loop over all corresponding master elements
    
    curmele=ele.mbody(icurmele,:);
    curmnodes=nodes.mbody(curmele,:);
    mcurdofs=dofs(curmele,0);
  
    for igp=1:numgp
      
      ximaster  =gpxi(igp,:);
      Xglob=LocalToGlobal( ximaster,curmnodes(:,1:2) );
      [xilag,converged]=GlobalToLocal( Xglob,curlnodes(:,1:2) );
      
      if converged==0
        error('unconverged should not happen here');
      end
      
      
      Nl =sval('quad4',xilag);
      Ns =sval('quad4',xilag);
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
      jacl=Jacobian(curlnodes(:,1:2),xilag);
      jacm=Jacobian(curmnodes(:,1:2),ximaster);
      De=De+Nlmat'*Nsmat*gpw(igp)*det(jacm)*1.33;  %%should be little big bigger
    end%end gausspoint loop
  end%end loop over master elements
  
  %Assemble to total systemmatrix
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
  
  allmele=find(geo.mnode2sele(:,2)==j);

  for icurmele=allmele' %% loop over all corresponding master elements
    
    curmele=ele.mbody(icurmele,:);
    curmnodes=nodes.mbody(curmele,:);
    mcurdofs=dofs(curmele,0);
  

  
    Me=zeros(8,8);
    for igp=1:numgp
      
      ximaster  =gpxi(igp,:);
      Xglob=LocalToGlobal( ximaster,curmnodes(:,1:2) );
      xilag=GlobalToLocal( Xglob,curlnodes(:,1:2) );
      
      if CheckMapping('quad4',xilag)==0
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
      Nm =sval('quad4',ximaster);
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
      jacl=Jacobian(curlnodes(:,1:2),xilag);
      jacm=Jacobian(curmnodes(:,1:2),ximaster);
      jacseg=jacl*inv(jacm)
      Me=Me+Nlmat'*Nmmat*gpw(igp)*det(jacm);  
    end%end loop over gausspoints
    M(lcurdofs,mcurdofs)=M(lcurdofs,mcurdofs)+Me;
  end%end loop over corresponding master elements
end%end loop over lagrange elements

M=M.*(M>TOL);

%this is valid, since all master nodes are part of the coupling zone
M=M(dofs(geo.ilagnodes,0),1:geo.master.numnodetot*2)


end