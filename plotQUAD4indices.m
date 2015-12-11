function []=plotQUAD4indices(f,elenodes,nodeindices,eleindex)

figure(f);


p=text(elenodes(1,1),elenodes(1,2),elenodes(1,3),num2str(nodeindices(1)));
set(p,'Color',[1 0 0]);
set(p,'EdgeColor',[1 0 0]);
set(p,'BackgroundColor',[0 1 1]);

p=text(elenodes(2,1),elenodes(2,2),elenodes(2,3),num2str(nodeindices(2)));
set(p,'Color',[1 0 0]);
set(p,'EdgeColor',[1 0 0]);
set(p,'BackgroundColor',[0 1 1]);

p=text(elenodes(3,1),elenodes(3,2),elenodes(3,3),num2str(nodeindices(3)));
set(p,'Color',[1 0 0]);
set(p,'EdgeColor',[1 0 0]);
set(p,'BackgroundColor',[0 1 1]);

p=text(elenodes(4,1),elenodes(4,2),elenodes(4,3),num2str(nodeindices(4)));
set(p,'Color',[1 0 0]);
set(p,'EdgeColor',[1 0 0]);
set(p,'BackgroundColor',[0 1 1]);


center=sum(elenodes)*0.25;
p=text(center(1),center(2),center(3),num2str(eleindex));
set(p,'Color',[0 0 1]);
set(p,'EdgeColor',[0 0 1]);
set(p,'BackgroundColor',[1 1 0]);

plot3([elenodes(1,1) elenodes(3,1)],[elenodes(1,2) elenodes(3,2)],[elenodes(1,3) elenodes(3,3)],'Color',[0 0 1]);
plot3([elenodes(2,1) elenodes(4,1)],[elenodes(2,2) elenodes(4,2)],[elenodes(2,3) elenodes(4,3)],'Color',[0 0 1]);


end