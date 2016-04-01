function [stiff,RHS]=ApplyDirich(stiff1,rhs1,dirichdof)
%simple function that applies the dirichlet condotions, specified in
%dirichdof to the stiffness matrix an the rhs

stiff1(dirichdof(:,1),:)=0.0;


for i=1:length(dirichdof(:,1))
  stiff1(dirichdof(i,1),dirichdof(i,1))=1.0;
  rhs1(dirichdof(i,1))=dirichdof(i,2);
end

stiff=stiff1;
RHS=rhs1;

end