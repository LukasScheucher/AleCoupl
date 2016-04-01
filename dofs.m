function curdofs=dofs(curnodes,offset)
%return the dof indices that are associated with the nodes indices provided
%in curnodes
%offest is used for all slave dofs

curdofs=[];

for i=1:length(curnodes)   
    curdofs=[curdofs;curnodes(i)*2-1;curnodes(i)*2];    
end
curdofs=curdofs+offset;

end