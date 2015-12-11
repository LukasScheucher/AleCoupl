function p=plotdisp(f,params,elements,nodes,disp)

figure(f);
axis off
hold on

for iele=1:length(elements)
    curnodes=nodes(elements(iele,:),:)+disp(elements(iele,:),:);

    
%     p=plot([curnodes(1,1) curnodes(2,1)...
%           curnodes(2,1) curnodes(3,1)...
%           curnodes(3,1) curnodes(4,1)...
%           curnodes(4,1) curnodes(1,1)],...
%          [curnodes(1,2) curnodes(2,2)...
%           curnodes(2,2) curnodes(3,2)...
%           curnodes(3,2) curnodes(4,2)...
%           curnodes(4,2) curnodes(1,2)]);
    if params.bodyele(iele)==2  
     plotQUAD4(f,curnodes,20,[0.0 1.0 0.0],'-',4);
    else
     plotQUAD4(f,curnodes,20,[1.0 0.0 0],'--',2);
    end
      
%     if params.bodyele(iele)==2
%         set(p,'Color',[0 0 0],'LineStyle','-');
%     else
%         set(p,'Color',[0.8 0.2 0],'LineStyle','--');
%     end
   
end




%% plot dirichfun

x=linspace(-1,5,100);
y=linspace(0,0,100);

yd=[]

for i=1:100
  yd=[yd,params.dirichfun(x(i),y(i))];
end


plot(x,y+yd);

end