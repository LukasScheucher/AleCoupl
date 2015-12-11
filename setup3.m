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
% (4)-----(5)-----(6)         %% (o)----(o)-----(o)
%  |       |       |          %%  |       |      |
%  |  [3]  |  [4]  |          %%  |  [X]  | [X]  |
%  |       |       |          %%  |       |      |
% (7)-----(8)-----(9)         %% (o)----(o)-----(o)
%  |       |       |          %%  |       |      |
%  |  [5]  |  [6]  |          %%  |  [X]  | [X]  |
%  |       |       |          %%  |       |      |
% (10)-----(11)-----(12)-->x  %% (o)----(o)-----(o)----->x
%
% 
% Create master and slave body completely independent of one another and start
% an algorithm to determine the overlap situation
% 
% 
% the flag is master
% the ale is slave

geo.ale.xmin=-3;
geo.ale.xmax= 3;
geo.ale.ymin=-2;
geo.ale.ymax= 2;

geo.flag.xmin=-2;
geo.flag.xmax= 2;
geo.flag.ymin=-0.3;
geo.flag.ymax= 0.3;

geo.ale.numelex=4;
geo.ale.numeley=3;

geo.flag.numelex=12;
geo.flag.numeley=2;



geo.flag.sizex=(geo.flag.xmax-geo.flag.xmin)/geo.flag.numelex;
geo.flag.sizey=(geo.flag.ymax-geo.flag.ymin)/geo.flag.numeley;

geo.ale.sizex=(geo.ale.xmax-geo.ale.xmin)/geo.ale.numelex;
geo.ale.sizey=(geo.ale.ymax-geo.ale.ymin)/geo.ale.numeley;

%% create the flag geometry
nodes.mbody=[];
for j=1:geo.flag.numeley+1
  for k=1:geo.flag.numelex+1
    nodes.mbody=[...
           nodes.mbody
           geo.flag.xmin+(k-1)*geo.flag.sizex   geo.flag.ymin+(j-1)*geo.flag.sizey]        
  end
end

ele.mbody=[];

for j=1:geo.flag.numeley
  for k=1:geo.flag.numelex
    ele.mbody=[...
      ele.mbody
      (geo.flag.numelex+1)*(j-1)+k (geo.flag.numelex+1)*(j-1)+k+1 (geo.flag.numelex+1)*j+k+1 (geo.flag.numelex+1)*j+k];
  end
end


%% create ale geometry
nodes.sbody=[];
for j=1:geo.ale.numeley+1
  for k=1:geo.ale.numelex+1
    nodes.sbody=[...
           nodes.sbody
           geo.ale.xmin+(k-1)*geo.ale.sizex   geo.ale.ymin+(j-1)*geo.ale.sizey]        
  end
end

ele.sbody=[];

for j=1:geo.ale.numeley
  for k=1:geo.ale.numelex
    ele.sbody=[...
      ele.sbody
      (geo.ale.numelex+1)*(j-1)+k (geo.ale.numelex+1)*(j-1)+k+1 (geo.ale.numelex+1)*j+k+1 (geo.ale.numelex+1)*j+k];
  end
end






f=figure()
plotframe(f,1,ele.mbody,nodes.mbody)
hold on
plotframe(f,1,ele.sbody,nodes.sbody)

axis equal
% 
% 
% sizefac=3; %determines, how many times smaller the slave elements are
% 
% nodes=[...
% 0 2 4 0  2 4 0 2  4 0 2 4
% 6 6 6 4  4 4 2 2  2 0 0 0]';
% 
% elements=[...
%     4  5  2  1
%     5  6  3  2
%     7  8  5  4
%     8  9  6  5
%     10 11 8  7
%     11 12 9  8];
% 
% 
% numslaveele=sizefac*sizefac*4;
% 
% 
% 
% % o----------->i
% % |
% % |
% % |
% % \/
% % j
% 
% 
% %% creating nodes
% for j=1:2*sizefac+1
%   for i=1:2*sizefac+1
%      nodes=[...
%             nodes
%             (i-1)*2/sizefac, 4-(j-1)*2/sizefac ];
%      
%   end
% end
% 
% 
% 
% %% creating elements
% temp=sizefac*2+1;
% for j=1:2*sizefac
%   for i=1:2*sizefac
%     elements=[...
%       elements
%       [j*temp+1*i j*temp+i+1 (j-1)*temp+i+1 (j-1)*temp+i]+12 ];
%   end
% end
% 
% 
% numnodes=length(nodes);
% numele=length(elements);
% 
% % params.bodyele  =[0 0 2 2 2 2 1 1 1 1];
% % params.ifaceele =[0 0 2 2 2 2 1 1 1 1];
% % params.bodynode =[2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1];
% % params.ifacenode=[0 0 0 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1];
% 
% params.bodyele  =[ones(1,6)*2 ones(1,sizefac*sizefac*4)];
% params.ifaceele =[zeros(1,2) 2*ones(1,4) ones(1,sizefac*sizefac*4)];
% 
% params.bodynode = [2*ones(1,12) ones(1,numnodes-12)];
% params.ifacenode= [zeros(1,3) 2*ones(1,9) ones(1,numnodes-12)];
% 
% params.dofshift=(2*sizefac+1)^2*2;
% params.stresstype='planestress',
% params.E=1000,
% params.v=0.0,
% 
% params.alpha=@(y) y./4; %auf master bezogen
% params.dirichfun=@(x,y)x^2*0.035*4;
% 
% 
% 
% dirichdof=[...
%            dofs(find(nodes(:,2)==6)) [dofs(find(nodes(:,2)==6))*0]
%            dofs(numnodes-sizefac*2:numnodes) 0.4*ones(length(dofs(numnodes-sizefac*2:numnodes)),1)];
% 
% dirichdof=[dofs(find(nodes(:,2)==6)) [dofs(find(nodes(:,2)==6))*0]   ]
%   
% 
% bottomnodes=numnodes-sizefac*2:numnodes
% 
% for curnode=bottomnodes
%   curdofs=dofs(curnode)
%   dirichdof=[...
%              dirichdof
%              curdofs(1) 0.0
%              curdofs(2) params.dirichfun(nodes(curnode,1),nodes(curnode,2))]
%   
% end     
%          
%          
%          
%        
% %% modification
% 
% % No modification
% % params.modnodes=[]
% % params.modele =[]
% % params.ifacenode(params.modnodes)=3
% % params.dofshift=params.dofshift
% 
% 
% 
% params.modnodes=numnodes-sizefac*2:numnodes
% params.modele =numele-sizefac*2+1:numele
% params.ifacenode(params.modnodes)=3
% params.ifaceele(params.modele)=3;
% 
%          
% % disp=zeros(length(nodes),2);
% % f=figure();
% % plotdisp(f,params,elements,nodes,disp)
%        
 