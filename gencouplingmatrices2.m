function [D,M]=gencouplingmatrices2(params,elements,nodes)

isele_nomod=find(params.ifaceele==1);
imele_nomod=find(params.ifaceele==2);
isele_mod=find(params.ifaceele==3);


syssize=   length(nodes)*2+2*sum(params.ifacenode==1);

D=zeros(syssize,syssize);
M=zeros(syssize,syssize);

%% standard, nonmodified shit
for il=isele_nomod
  for is=isele_nomod
    D=D+gencouplingmat(params,nodes,elements(il,:),elements(is,:),'nomod','nomod','dualno',1,1);
  end
end


for il=isele_nomod
  for im=imele_nomod
    M=M+gencouplingmat(params,nodes,elements(il,:),elements(im,:),'nomod','nomod','dualno',1,1);
  end
end


%% modified shit
for il=isele_mod
  for is=isele_mod
    D=D+gencouplingmat(params,nodes,elements(il,:),elements(is,:),'mod','nomod','dualno',1,1);
  end
end


for il=isele_mod
  for im=imele_nomod
    M=M+gencouplingmat(params,nodes,elements(il,:),elements(im,:),'mod','nomod','dualno',1,1);
  end
end


end