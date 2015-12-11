clear
close all
clc


setup3


%%
% f=figure()
% plotconf(f,params,elements,nodes,disp)

%%
stiff = AssembleStiff(params,elements,nodes);
[D,M]=gencouplingmatrices2(params,elements,nodes);
%%error('temporary exit');


LHS=stiff+(M-D+M'-D')*1000;
RHS=zeros(size(LHS,1),1) ;
%%
imagesc(LHS==0)
[LHS,RHS]=ApplyDirich(LHS,RHS,dirichdof);
%RHS=ApplyNeumann(RHS,neumanndof);
%%

sol=LHS\RHS;

disp=[sol(1:2:numnodes*2),sol(2:2:numnodes*2)];
    


f=figure();
axis equal
%disp=zeros(21,2)
plotframe(f,params,elements,nodes)

hold on

plotdisp(f,params,elements,nodes,disp)

%%
f=figure()
plotframe(f,params,elements,nodes)

hold on
for iele=7:length(elements)
    
 plotsf(f,elements,nodes,iele,params)
 
    
end