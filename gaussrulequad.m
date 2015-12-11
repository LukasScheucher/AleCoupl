function [gpxi,gpw] =gaussrulequad()


gpxi=[];
gpw=[];
[gpxil,gpwl]=gaussruleline(4);

for i=1:4
gpxi=[gpxi,;
      gpxil,[gpxil(i) gpxil(i) gpxil(i) gpxil(i)]'];
gpw=[gpw,;
      gpwl.*[gpwl(i) gpwl(i) gpwl(i) gpwl(i)]'];
end


if abs(sum(gpw)-4.0)>1e-5
    sum(gpw)
    error('please check the gaussrule')
end


end