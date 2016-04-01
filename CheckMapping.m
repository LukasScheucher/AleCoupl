function inside=CheckMapping(distype,xi)
%check whether the reference coordinates xi refer to a point
%that is inside the element
tol=1e-5;

if distype=='quad4'
    if xi(1)<1.0+tol && xi(1)>-1.0-tol && xi(2)<1.0+tol && xi(2)>-1.0-tol
        inside=1;
    else
        inside=0;
    end
else
    error('unsupported distype');
end

end