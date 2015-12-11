function curdofs=dofs(curnodes,offset)


curdofs=[];

%offest is used for all slave dofs


for i=1:length(curnodes)
   
    curdofs=[curdofs;curnodes(i)*2-1;curnodes(i)*2];
    
end



end