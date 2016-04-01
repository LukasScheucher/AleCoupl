function Nd =derivsval(distype,xi)
%first derivatives of shape functions

Nd=[];

switch lower(distype)
    case 'quad4'
      r=xi(1);
      s=xi(2);
      Nd=[...
          -(1-s) -(1-r)
           (1-s) -(1+r)
           (1+s)  (1+r)
          -(1+s)  (1-r)]*0.25;
    otherwise
        error('unsupported distype');
end