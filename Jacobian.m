function J=Jacobian(nodes,xi)

Nd=derivsval('quad4',xi);

J=Nd'*nodes;



end