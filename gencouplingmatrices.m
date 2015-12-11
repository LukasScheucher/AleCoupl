function [D,M]=gencouplingmatrices(params,elements,nodes)


modm=true
modd=true

imele=[find(params.ifaceele==2)]; %indices of all master elements
isele=[find(params.ifaceele==1)]; %indices of all slave elements

ilele=[find(params.ifaceele==1)]; %indices of all lagrange elements

imnode=[find(params.ifacenode==2)]; %indices of all master nodes
isnode=[find(params.ifacenode==1)]; %indices of all slave elements
ilnode=[find(params.ifacenode==1)];
%isnode=[find(params.ifacenode==1),find(params.ifacenode==3)];

numnodes   =length(nodes);
numdof     =numnodes*2;

numlagnodes=length(ilnode);
numlagdof  =numlagnodes*2;


numslavenodes=length(isnode);
numslavedof  =numslavenodes*2;

nummasternodes=length(imnode);
nummasterdof  =nummasternodes*2;


nummodnodes=length(params.modnodes);
nummoddof=2*nummodnodes;



ibmele=find(params.bodyele==2); %indices of all master elements
ibsele=find(params.bodyele==1); %indices of all slave elements




%pause(100)



[gpxi,gpw] =gaussrulequad();
numgp=length(gpw);



D=zeros(numdof+numlagdof,...
        numdof+numlagdof);
M=zeros(numdof+numlagdof,...
        numdof+numlagdof);
      

% at first, the coupling matrices are made bigger, to simplify the assembly
% process
D=zeros(numdof+2*length([find(params.ifacenode==1),find(params.ifacenode==3)]),...
        numdof+2*length([find(params.ifacenode==1),find(params.ifacenode==3)]) );
M=zeros(numdof+2*length([find(params.ifacenode==1),find(params.ifacenode==3)]),...
        numdof+2*length([find(params.ifacenode==1),find(params.ifacenode==3)]) );


%M matrix
for il=ilele
    
    nodeslag=nodes(elements(il,:),:);
    dofslag=dofs(elements(il,:))+params.dofshift;
    curlagele=elements(il,:);
    
    
    
    for im=imele
        curmasterele=elements(im,:);
        dofsmaster=dofs(curmasterele);
        nodemaster=nodes(elements(im,:),:);
        
%         'now coupling'
%         [il im]
%         pause(2);
        
        Me=zeros(8,8);
        for igp=1:numgp
            xilag=gpxi(igp,:);
            Xglob=LocalToGlobal( xilag,nodeslag );
            ximaster=GlobalToLocal( Xglob,nodemaster );
            if CheckMapping('quad4',ximaster)==1
                Nl =sval('quad4',xilag);
                

                if sum(params.modele==il)>0 %% this element uses modified 
                    Nl=svalmod(elements(il,:),params,xilag);
                    error('You should not be here in the current version of the code');
                end
                
                Nm =sval('quad4',ximaster);

                Nlmat=[...
                      Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
                      0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
                Nmmat=[...
                      Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4) 0
                      0     Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4)];
                    
                jac=det(Jacobian(nodeslag,xilag));
                Me=Me+Nlmat'*Nmmat*gpw(igp)*inv(jac); %only valid because I am using matching interfaces
            end
        end
        [m,n]=size(M)
        M(dofslag,dofsmaster)=M(dofslag,dofsmaster)+Me;
    end
    
end






%D matrix
for il=ilele
    
    nodelag=nodes(elements(il,:),:);
    dofslag=dofs(elements(il,:))+params.dofshift;
    curlagele=elements(il,:);
    
    
    
    for is=isele
        curslave=elements(is,:);
        dofsslave=dofs(curslave);
        nodeslave=nodes(elements(is,:),:);
        
        
%         'now coupling'
%         [il is]
%         pause(2);
        
        De=zeros(8,8);
        for igp=1:numgp
            xilag=gpxi(igp,:);
            Xglob=LocalToGlobal( xilag,nodelag );
            xislave=GlobalToLocal( Xglob,nodeslave );
            if CheckMapping('quad4',xislave)==1
                Nl =sval('quad4',xilag);
                T=[4 -2  1 -2
                  -2  4 -2  1
                   1 -2  4 -2
                  -2  1 -2  4];
                %Nl=T*Nl;
                
                if sum(params.modele==il)>0 %% this element uses modified 
                    Nl=svalmod(elements(il,:),params,xilag);
                    error('You should not be here in the current version of the code');
                end
                
                Ns =sval('quad4',xislave);

                Nlmat=[...
                      Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
                      0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
                Nsmat=[...
                      Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4) 0
                      0     Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4)];
                jac=det(Jacobian(nodeslag,xilag));
                De=De+Nlmat'*Nsmat*gpw(igp)*inv(jac); %only valid because I am using matching interfaces
            end
        end
        D(dofslag,dofsslave)=D(dofslag,dofsslave)+De;
    end
    
end





% error('temporary exit');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% now perform the extra coupling of additional M

if modm==true


%M matrix
for il=params.modele
    
    nodeslag=nodes(elements(il,:),:);
    dofslag=dofs(elements(il,:))+params.dofshift;
    
    
    elements(il,:)
    numdof
    numslavedof
    
    %pause(100)
    
    curlagele=elements(il,:);
    
    
    
    for im=[params.modele 5 6]
        curmasterele=elements(im,:);
        dofsmaster=dofs(curmasterele);
        nodemaster=nodes(elements(im,:),:);
        
%         'now coupling'
%         [il im]
%         pause(2);
        
        curmasterele
        curmod=[0 0 0 0]
        for testnode=params.modnodes
          curmod=curmod+[curmasterele==testnode]
        end
        
        
        %corrector is ma matrix of only ones and zeros
        % its sole purpose is to delete all
        corrector=ones(8,8);
        for i=1:4
          if curmod(i)==0
            %corrector(i*2,:)=0;
            corrector(:,i*2)=0;
            %corrector(i*2-1,:)=0;
            corrector(:,i*2-1)=0;
          end
        end
        
        
        if sum(params.modele==im)==0;
         corrector=ones(8,8)
        end
        
        [il im]
        corrector
        %pause(10);
        
        Me=zeros(8,8);
        for igp=1:numgp
            xilag=gpxi(igp,:);
            Xglob=LocalToGlobal( xilag,nodeslag );
            ximaster=GlobalToLocal( Xglob,nodemaster );
            if CheckMapping('quad4',ximaster)==1
                Nl =sval('quad4',xilag);
                

                if sum(params.modele==il)>0 %% this element uses modified 
                    Nl=svalmod(elements(il,:),params,xilag);
                end
                 
                Nm =sval('quad4',ximaster);

                Nlmat=[...
                      Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
                      0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
                Nmmat=[...
                      Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4) 0
                      0     Nm(1) 0     Nm(2) 0     Nm(3) 0     Nm(4)];
                    
                jac=det(Jacobian(nodeslag,xilag));
                Me=Me+Nlmat'*Nmmat*gpw(igp)*inv(jac); %only valid because I am using matching interfaces
                
                
            end
        end
        Me=Me.*corrector;
        [m,n]=size(M)
        dofslag
        dofsmaster
        %pause(5)
        M(dofslag,dofsmaster)=M(dofslag,dofsmaster)+Me;
    end
    
end


end %if modm
%% done additional part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% now perform the extra coupling of additional D
%D matrix

if modd==true


for il=params.modele
    
    nodelag=nodes(elements(il,:),:);
    dofslag=dofs(elements(il,:))+params.dofshift;
    curlagele=elements(il,:);
    
    
    for is=params.modele
        curslave=elements(is,:);
        dofsslave=dofs(curslave);
        nodeslave=nodes(elements(is,:),:);
        
        
%         'now coupling'
%         [il is]
%         pause(2);
        
        
        
        curslave
        curmod=[0 0 0 0]
        for testnode=params.modnodes
          curmod=curmod+[curslave==testnode]
        end
        
        
        %corrector is ma matrix of only ones and zeros
        % its sole purpose is to delete all
        corrector=ones(8,8);
        for i=1:4
          if curmod(i)==1
            %corrector(i*2,:)=0;
            corrector(:,i*2)=0;
            %corrector(i*2-1,:)=0;
            corrector(:,i*2-1)=0;
          end
        end
        
        corrector
        
        
        %pause(100)
        
        
        
        
        
        
        De=zeros(8,8);
        for igp=1:numgp
            xilag=gpxi(igp,:);
            Xglob=LocalToGlobal( xilag,nodelag );
            xislave=GlobalToLocal( Xglob,nodeslave );
            if CheckMapping('quad4',xislave)==1
                Nl =sval('quad4',xilag);
                T=[4 -2  1 -2
                  -2  4 -2  1
                   1 -2  4 -2
                  -2  1 -2  4];
                %Nl=T*Nl;
                
                if sum(params.modele==il)>0 %% this element uses modified 
                    Nl=svalmod(elements(il,:),params,xilag);
                end
                
                Ns =sval('quad4',xislave);

                Nlmat=[...
                      Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4) 0
                      0     Nl(1) 0     Nl(2) 0     Nl(3) 0     Nl(4)];
                Nsmat=[...
                      Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4) 0
                      0     Ns(1) 0     Ns(2) 0     Ns(3) 0     Ns(4)];
                jac=det(Jacobian(nodeslag,xilag));
                De=De+Nlmat'*Nsmat*gpw(igp)*inv(jac); %only valid because I am using matching interfaces
            end
        end
        
        De=De.*corrector;
        D(dofslag,dofsslave)=D(dofslag,dofsslave)+De;
    end
    
end



end %% if modd
%% done additional D part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% Die zusaetyliochen Nullzeilen wurde nur eingefuehrt, um den einfachen
% Assemblierungsprozess beibehalten zu koennen. es sollten nur Nullzeilen
% assembliert worden sein.

if sum(sum(D(numdof+numlagdof:end,numdof+numlagdof:end)+...
           M(numdof+numlagdof:end,numdof+numlagdof:end)))>0
         error('auxilary lines of D and M are not empty');
end
    
D=D(1:numdof+numlagdof,1:numdof+numlagdof);
M=M(1:numdof+numlagdof,1:numdof+numlagdof);



end