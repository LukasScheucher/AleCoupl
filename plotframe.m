function p=plotframe(f,params,elements,nodes,color,plotindices)
%plots the configuration in undeformed state

figure(f);
axis off
hold on

for iele=1:size(elements,1)
    curnodes=nodes(elements(iele,:),:);

    plotQUAD4(f,curnodes,20,color,'-',4);
    if plotindices==1
      plotQUAD4indices(f,curnodes,elements(iele,:),iele);
    end
      
   
end


end