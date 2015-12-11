%% SETUP 1
%       
%
%  ^y
%  |     Master
%  |
% (1)-----(2)-----(3)         
%  |       |       |          %%  ^y
%  |  [1]  |  [2]  |          %%  |     Slave
%  |       |       |          %%  |
% (4)-----(5)-----(6)         %% (13)----(14)----(15)
%  |       |       |          %%  |       |       |
%  |  [3]  |  [4]  |          %%  |  [7]  |  [8]  |
%  |       |       |          %%  |       |       |
% (7)-----(8)-----(9)         %% (16)----(17)----(18)
%  |       |       |          %%  |       |       |
%  |  [5]  |  [6]  |          %%  |  [9]  | [10]  |
%  |       |       |          %%  |       |       |
% (10)-----(11)-----(12)-->x  %% (19)----(20)----(21)----->x
%



nodes=[...
0 2 4 0  2 4 0 2  4 0 2 4  0 2 4 0  2 4 0 2  4 
6 6 6 4  4 4 2 2  2 0 0 0  4 4 4 2  2 2 0 0  0]';

numnodes=length(nodes);


elements=[...
    4  5  2  1
    5  6  3  2
    7  8  5  4
    8  9  6  5
    10 11 8  7
    11 12 9  8
    16 17 14 13
    17 18 15 14
    19 20 17 16
    20 21 18 17];

numele=length(elements);

params.bodyele  =[2 2 2 2 2 2 1 1 1 1];
params.ifaceele =[0 0 2 2 2 2 1 1 1 1];
params.bodynode =[2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1];
params.ifacenode=[0 0 0 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1];

params.dofshift=18;
params.stresstype='planestress';
params.E=1000;
params.v=0.3;

params.alpha=@(y) 0.5;%y./4; %auf master bezogen

params.dirichfun=@(x,y)x^2*0.025*4;

dirichdof=[...
           dofs(1) [0 0]'
           dofs(2) [0 0]'
           dofs(3) [0 0]'
           dofs(19) [0.2 0.2]'
           dofs(20) [0.2 0.2]'
           dofs(21) [0.2 0.2]'];

dirichdof=[...
           dofs(1) [0 0]'
           dofs(2) [0 0]'
           dofs(3) [0 0]'];
         
         
         
bottomnodes=[19 20 21]

for curnode=bottomnodes
  curdofs=dofs(curnode)
  dirichdof=[...
             dirichdof
             curdofs(1) 0.0
             curdofs(2) params.dirichfun(nodes(curnode,1),nodes(curnode,2))]
  
end     
     
         
         
%% modification

% no modification
% params.modnodes=[];
% params.modele  =[];
% 
% params.ifacenode(params.modnodes)=3;
% params.ifaceele(params.modele)=3;


params.modnodes=[19 20 21];
params.modele =[9 10];

params.ifacenode(params.modnodes)=3;
params.ifaceele(params.modele)=3;


% % % % params.modnodes=[19];
% % % % params.modele =[9];
% % % % 
% % % % params.ifacenode(params.modnodes)=3;
% % % % params.ifaceele(params.modele)=3;

       
 