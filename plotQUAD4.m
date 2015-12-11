function []=plotQUAD4(f,elenodes,numpoints,color,linestyle,linewidth,offset)




% 
% 
%     o_______________(3)_______________o
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%    (4)                               (2)
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     |                                 |
%     o_______________(1)_______________|
% 
% 
% 









r=[];
s=[];

%Kante1;
r=[r;linspace(-1,1,numpoints)];
s=[s;linspace(-1,-1,numpoints)];

%Kante2
r=[r;linspace(1,1,numpoints)];
s=[s;linspace(-1,1,numpoints)];

%Kante3
r=[r;linspace(-1,1,numpoints)];
s=[s;linspace(1,1,numpoints)];

%Kante4
r=[r;linspace(-1,-1,numpoints)];
s=[s;linspace(-1,1,numpoints)];

   

for k=1:4 %% 4 Kanten  
 for i=1:numpoints
 
     N=sval('quad4',[r(k,i),s(k,i)]);
     x(i)=N'*elenodes(:,1);
     y(i)=N'*elenodes(:,2);
 end
 
 z=x*0+offset;
 p=plot3(x,y,z);
 set(p,'Color',color,'LineStyle',linestyle,'LineWidth',4);
 clear x y;
 hold on;
 grid on;
end

% for i=1:size(ele.nodes,1)
%   p=plot(ele.nodes(i,1),ele.nodes(i,2),'ko','MarkerSize',10,'LineWidth',2)
%   if(ele.mod(i)==1)
%     set(p,'Color',[1 0 0])
%   end
%    hold on
% end




end