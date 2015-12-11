function [ X ] = LocalToGlobal( xi,nodes )

N=sval('quad4',xi);

X=zeros(2,1);
X(1)=transpose(N)*nodes(:,1);
X(2)=transpose(N)*nodes(:,2);


end

