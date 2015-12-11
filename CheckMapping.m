function inside=CheckMapping(distype,xi)

tol=1e-5;

if distype=='quad4'
    if xi(1)<1.0+tol && xi(1)>-1.0-tol && xi(2)<1.0+tol && xi(2)>-1.0-tol
        inside=true;
    else
        inside=false;
    end
else
    error('unsupported distype');
end


end