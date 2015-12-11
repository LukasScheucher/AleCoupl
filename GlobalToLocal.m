function [ xi ] = GlobalToLocal( X,nodes )


counter=0;
maxcount=60;


xi=[0.0;0.0]; %Startwert der Iteration


res=X-LocalToGlobal( xi,nodes );

while norm(res)>1e-6
derivs=derivsval('quad4',xi);
R1r=transpose(derivs(:,1))*nodes(:,1);
R1s=transpose(derivs(:,2))*nodes(:,1);
R2r=transpose(derivs(:,1))*nodes(:,2);
R2s=transpose(derivs(:,2))*nodes(:,2);


jac=[...
  R1r R1s
  R2r R2s];

deltaz=inv(jac)*res;

xi=xi+deltaz;
res=X-LocalToGlobal( xi,nodes );

counter=counter+1;
if counter>maxcount
  error('Newton unconverged in 10 iterations');
end


end




end
