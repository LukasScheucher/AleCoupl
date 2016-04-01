function RHS=ApplyNeumann(RHS1,neumanndof)
%appling Neumann boundary conditions

RHS1(neumanndof(:,1))=neumanndof(:,2);
RHS=RHS1;

end