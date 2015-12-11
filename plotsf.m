function p=plotsf(f,elements,nodes,iele,params)

res=20;

r=linspace(-1,1,res);
s=linspace(-1,1,res);


curnodes=nodes(elements(iele,:),:)


[R,S]=meshgrid(r,s);

X=zeros(10,10);
Y=zeros(10,10);

for ir=1:res
    for is=1:res
        
        N        = sval('quad4',[r(ir) s(is)]);
        

        X(ir,is) = N'*curnodes(:,1);
        Y(ir,is) = N'*curnodes(:,2);
        
        if sum(params.modele==iele)>0 %% this element uses modified 
          N=svalmod(elements(iele,:),params,[r(ir) s(is)]);
%           N
%           pause(5);
        end
        
        
        N1(ir,is)= N(1);
        N2(ir,is)= N(2);
        N3(ir,is)= N(3);
        N4(ir,is)= N(4);
    end
end

figure(f);
hold on;
surf(X,Y,N1);
surf(X,Y,N2);
surf(X,Y,N3);
p=surf(X,Y,N4);
get(p);

end