clear
close all
clc


syms r s


N=[...
  (1-r)*(1-s)
  (1+r)*(1-s)
  (1+r)*(1+s)
  (1-r)*(1+s)]*0.25


  T=[4 -2  1 -2
  -2  4 -2  1
   1 -2  4 -2
  -2  1 -2  4]

Nd=simplify(T*N)

simplify(Nd(3)+Nd(4))


% Nd(1)=simplify(Nd(1)+Nd(3)/2+Nd(4)/2)
% Nd(2)=simplify(Nd(2)+Nd(3)/2+Nd(4)/2)
% Nd(3)=0
% Nd(4)=0


Nd(1)=0
Nd(2)=0
Nd(3)=1/2*(1+3*r)
Nd(4)=1/2*(1-3*r)



if double(sum(Nd))~=1
  error('shapefunctions invalid');
end

'test'



checkmat=zeros(4,4)

for i=1:4
  for j=1:4
    checkmat(i,j)=int(int(N(i)*Nd(j),r,-1,1),s,-1,1);
  end
end


checkmat