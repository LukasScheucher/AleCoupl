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
% the master is master
% the slave is slave

geo.slave.xmin=-4;
geo.slave.xmax= 4;
geo.slave.ymin=-3;
geo.slave.ymax= 3;

geo.master.xmin=-2;
geo.master.xmax= 2;
geo.master.ymin=-0.3;
geo.master.ymax= 0.3;

geo.slave.numelex=4;
geo.slave.numeley=3;
geo.master.numelex=12;
geo.master.numeley=2;

geo.slave.numeletot=geo.slave.numelex*geo.slave.numeley;
geo.master.numeletot=geo.master.numelex*geo.master.numeley;



geo.master.sizex=(geo.master.xmax-geo.master.xmin)/geo.master.numelex;
geo.master.sizey=(geo.master.ymax-geo.master.ymin)/geo.master.numeley;

geo.slave.sizex=(geo.slave.xmax-geo.slave.xmin)/geo.slave.numelex;
geo.slave.sizey=(geo.slave.ymax-geo.slave.ymin)/geo.slave.numeley;

%% create the master geometry
nodes.mbody=[];
for j=1:geo.master.numeley+1
  for k=1:geo.master.numelex+1
    nodes.mbody=[...
           nodes.mbody
           geo.master.xmin+(k-1)*geo.master.sizex   geo.master.ymin+(j-1)*geo.master.sizey]        
  end
end

ele.mbody=[];

for j=1:geo.master.numeley
  for k=1:geo.master.numelex
    ele.mbody=[...
      ele.mbody
      (geo.master.numelex+1)*(j-1)+k (geo.master.numelex+1)*(j-1)+k+1 (geo.master.numelex+1)*j+k+1 (geo.master.numelex+1)*j+k];
  end
end


%% create slave geometry
nodes.sbody=[];
for j=1:geo.slave.numeley+1
  for k=1:geo.slave.numelex+1
    nodes.sbody=[...
           nodes.sbody
           geo.slave.xmin+(k-1)*geo.slave.sizex   geo.slave.ymin+(j-1)*geo.slave.sizey]        
  end
end

ele.sbody=[];

for j=1:geo.slave.numeley
  for k=1:geo.slave.numelex
    ele.sbody=[...
      ele.sbody
      (geo.slave.numelex+1)*(j-1)+k (geo.slave.numelex+1)*(j-1)+k+1 (geo.slave.numelex+1)*j+k+1 (geo.slave.numelex+1)*j+k];
  end
end






f_frame=figure()
plotframe(f_frame,1,ele.mbody,nodes.mbody,0)
hold on
plotframe(f_frame,1,ele.sbody,nodes.sbody,1)

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
 