function p=plotframe(f,params,elements,nodes)

figure(f);
axis off
hold on

for iele=1:length(elements)
    curnodes=nodes(elements(iele,:),:);

    plotQUAD4(f,curnodes,20,[0 0 0],'-',4);
    plotQUAD4indices(f,curnodes,elements(iele,:),iele);
      
   
end


end