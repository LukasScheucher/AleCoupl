function [ X ] = LocalToGlobal( xi,nodes )
% matches the local xicoordinate to a global X coordinate given the
% element node coordinates for a quad4 element

N=sval('quad4',xi);

X=zeros(2,1);
transpose(N)
nodes(:,1)
X(1)=transpose(N)*nodes(:,1);
X(2)=transpose(N)*nodes(:,2);

end

