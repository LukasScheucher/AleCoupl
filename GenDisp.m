function [masterdisp]=GenDisp(ele,nodes,geo)


dispmax=0.75;

f=@(x) 0.25*(0.25*x^2+x+1)+x*0.2;

masterdisp=[];



%loop over all master nodes

for j=1:size(nodes.mbody,1)
  curx=nodes.mbody(j,1);
  masterdisp=[masterdisp;dispmax*0.5;dispmax*f(curx)];
end





end