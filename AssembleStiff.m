function stiff = AssembleStiff(params,elements,nodes)
%iteratively calculates element stiffness matrices and assembles them to
%the global stiffness matrix

[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);
numnodes=length(nodes);
numdof=numnodes*2;

isnode=find(params.ifacenode==1);
numlagnodes=length(isnode);
numlagdof  =numlagnodes*2;

stiff=zeros(numdof+numlagdof,numdof+numlagdof);

E=params.E;
v=params.v;

if params.stresstype=='planestress'
    C=E/(1-v^2)*[...
                  1  v  0
                  v  1  0
                  0  0 (1-v)/2];
elseif params.stresstype=='planestrain'
    C=E/((1+v)*(1-2*v))*[...
                  1-v  v  0
                  v  1-v  0
                  0  0 (1-2*v)/2];
end


for iele=1:length(elements)
    curele=elements(iele,:);
    curnodes=nodes(curele,:);
    curdofs=dofs(curele);
    
    %reset element stiffness matrix befor gausspoint loop
    elestiff=zeros(8,8);
    
    %loop over gausspoints
    for igp=1:numgp
      N =sval('quad4',gpxi(igp,:));
      Nd=derivsval('quad4',gpxi(igp,:));
      
      NMat=[...
            Nd(1,1) 0         Nd(2,1) 0         Nd(3,1) 0         Nd(4,1) 0         
            0       Nd(1,2)   0       Nd(2,2)   0       Nd(3,2)   0       Nd(4,2)   
            Nd(1,2) Nd(1,1)   Nd(2,2) Nd(2,1)   Nd(3,2) Nd(3,1)   Nd(4,2) Nd(4,1)];
        
      Xglob=LocalToGlobal( gpxi(igp,:),curnodes );
      
      alphagp=-1;%purposely initializing invalid alpha value
      
      %check whether the current element is part of the master-, the slave-
      %or of no interface at all
      if params.ifaceele(iele)==2
          alphagp=params.alpha(Xglob(2));
      elseif params.ifaceele(iele)==1
          alphagp=1-params.alpha(Xglob(2));
      else
           alphagp=1.0;
      end
      
      if abs(alphagp)>1
          error('invalid alpha value detected');
      end
      
      %assemble elementstiffness matrix gausspoint wise
      elestiff=elestiff+NMat'*C*NMat*gpw(igp);
       
    end%end gausspoint loop
    
    stiff(curdofs,curdofs)=stiff(curdofs,curdofs)+elestiff;    
end%end loop over elements

end
