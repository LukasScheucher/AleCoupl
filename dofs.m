function curdofs=dofs(curnodes)


curdofs=[];


for i=1:length(curnodes)
   
    curdofs=[curdofs;curnodes(i)*2-1;curnodes(i)*2];
    
end



end