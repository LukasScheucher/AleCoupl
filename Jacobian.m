function J=Jacobian(nodes,xi)
%calculates the Jacobian of a quad4 element
Nd=derivsval('quad4',xi);
J=Nd'*nodes;

end