%% SETUP 1
%       
%
%  ^y
%  |     Master
%  |
% (1)-----(2)-----(3)         
%  |       |       |          %%  ^y                             ^y
%  |  [1]  |  [2]  |          %%  |     Slave                    |     Master
%  |       |       |          %%  |                              |
% (4)-----(5)-----(6)         %% (13)----(14)----(15)         a (22)----(23)----(24) 
%  |       |       |          %%  |       |       |           a  |       |       |  
%  |  [3]  |  [4]  |          %%  |  [7]  |  [8]  |           a  |  [11] |  [12] |   
%  |       |       |          %%  |       |       |           a  |       |       | 
% (7)-----(8)-----(9)         %% (16)----(17)----(18)         a (25)----(26)----(27) 
%  |       |       |          %%  |       |       |           a  |       |       |  
%  |  [5]  |  [6]  |          %%  |  [9]  | [10]  |           a  |  [13] | [14]  | 
%  |       |       |          %%  |       |       |           a  |       |       |      
% (10)-----(11)-----(12)-->x  %% (19)----(20)----(21)----->x  a (28)----(29)----(30)----->x 



nodes=[...
0 2 4 0  2 4 0 2  4 0 2 4  0 2 4 0  2 4 0 2  4    0  2 4 0 2  4 0 2 4
6 6 6 4  4 4 2 2  2 0 0 0  4 4 4 2  2 2 0 0  0    4  4 4 2 2  2 0 0 0]';

numnodes=length(nodes);


elements=[...
    4  5  2  1
    5  6  3  2
    7  8  5  4
    8  9  6  5
    10 11 8  7
    11 12 9  8%%
    16 17 14 13
    17 18 15 14
    19 20 17 16
    20 21 18 17%%
    25 26 23 22
    26 27 24 23
    28 29 26 25
    29 30 27 26];

numele=length(elements);

params.bodyele  =[2 2 2 2 2 2 1 1 1 1 2 2 2 2];
params.ifaceele =[0 0 2 2 2 2 1 1 1 1 2 2 2 2];
params.bodynode =[2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1  2 2 2 2 2 2 2 2 2];
params.ifacenode=[0 0 0 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1  2 2 2 2 2 2 2 2 2];

params.dofshift=36;
params.stresstype='planestress';
params.E=1000;
params.v=0.3;

params.alpha=@(y) 0.5;%y./4; %auf master bezogen

dirichdof=[...
           dofs(1) [0 0]'
           dofs(2) [0 0]'
           dofs(3) [0 0]'
           dofs(28) [0.2 0.2]'
           dofs(29) [0.2 0.2]'
           dofs(30) [0.2 0.2]'];
         
         
%% modification

% no modification
params.modnodes=[];
params.modele =[];

params.ifacenode(params.modnodes)=3;
params.ifaceele(params.modele)=3;


       
 