function Nd =derivsval(distype,xi)

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