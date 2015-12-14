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
geo.master.ymin=-1.0;
geo.master.ymax= 1.0;

geo.slave.numelex=4;
geo.slave.numeley=3;
geo.master.numelex=6;
geo.master.numeley=4;

geo.slave.numeletot=geo.slave.numelex*geo.slave.numeley;
geo.master.numeletot=geo.master.numelex*geo.master.numeley;

geo.slave.numnodetot=(geo.slave.numelex+1)*(geo.slave.numeley+1);
geo.master.numnodetot=(geo.master.numelex+1)*(geo.master.numeley+1);


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
           geo.master.xmin+(k-1)*geo.master.sizex   geo.master.ymin+(j-1)*geo.master.sizey 1]        
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
           geo.slave.xmin+(k-1)*geo.slave.sizex   geo.slave.ymin+(j-1)*geo.slave.sizey 0]        
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






