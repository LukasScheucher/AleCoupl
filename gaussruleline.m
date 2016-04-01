function [gpxi,gpw] =gaussruleline(n)
%provides gauss integartion locations and weights for line elements
if n==2
    gpxi=[-1/sqrt(3) 1/sqrt(3)];
    gpw=[1 1];
elseif n==4
    gpxi=[-sqrt((15+sqrt(120))/35) -sqrt((15-sqrt(120))/35) sqrt((15-sqrt(120))/35) sqrt((15+sqrt(120))/35)]';
    gpw=[(18-sqrt(30))/36 (18+sqrt(30))/36 (18+sqrt(30))/36 (18-sqrt(30))/36]';
elseif n==15
    gpw=[...
      	0.022935322010529224963732008058970
 	   	0.063092092629978553290700663189204
 	  	0.104790010322250183839876322541518
 	   	0.140653259715525918745189590510238
 	  	0.169004726639267902826583426598550
 	   	0.190350578064785409913256402421014
 	 	0.204432940075298892414161999234649
 	  	0.209482141084727828012999174891714
 	 	0.204432940075298892414161999234649
 	  	0.190350578064785409913256402421014
 	 	0.169004726639267902826583426598550
 	  	0.140653259715525918745189590510238
 	 	0.104790010322250183839876322541518
 	  	0.063092092629978553290700663189204
 	 	0.022935322010529224963732008058970];
    gpxi=[...        
    -0.991455371120812639206854697526329
    -0.949107912342758524526189684047851 
    -0.864864423359769072789712788640926
    -0.741531185599394439863864773280788 
    -0.586087235467691130294144838258730
    -0.405845151377397166906606412076961
    -0.207784955007898467600689403773245
     0.000000000000000000000000000000000
     0.207784955007898467600689403773245
     0.405845151377397166906606412076961
     0.586087235467691130294144838258730
     0.741531185599394439863864773280788
     0.864864423359769072789712788640926
     0.949107912342758524526189684047851
     0.991455371120812639206854697526329];
 elseif n==50
    gpxi=[...
		-0.0310983383271889
		0.0310983383271889
	   -0.0931747015600861
		0.0931747015600861
		-0.1548905899981459
		0.1548905899981459
		-0.2160072368760418
		0.2160072368760418
		-0.2762881937795320
		0.2762881937795320
		-0.3355002454194373
		0.3355002454194373
		-0.3934143118975651
		0.3934143118975651
    	-0.4498063349740388
		0.4498063349740388
		-0.5044581449074642
		0.5044581449074642
		-0.5571583045146501
		0.5571583045146501
		-0.6077029271849502
		0.6077029271849502
		-0.6558964656854394
		0.6558964656854394
		-0.7015524687068222
		0.7015524687068222
		-0.7444943022260685
		0.7444943022260685
		-0.7845558329003993
		0.7845558329003993
		-0.8215820708593360
		0.8215820708593360
		-0.8554297694299461
		0.8554297694299461
		-0.8859679795236131
		0.8859679795236131
		-0.9130785566557919
		0.9130785566557919
		-0.9366566189448780
		0.9366566189448780
		-0.9566109552428079
		0.9566109552428079
		-0.9728643851066920
		0.9728643851066920
		-0.9853540840480058
		0.9853540840480058
		-0.9940319694320907
		0.9940319694320907
		-0.9988664044200710
		0.9988664044200710]

    gpw=[...
	0.0621766166553473
	0.0621766166553473
	0.0619360674206832
	0.0619360674206832
	0.0614558995903167
	0.0614558995903167
	0.0607379708417702
	0.0607379708417702
	0.0597850587042655
	0.0597850587042655
	0.0586008498132224
	0.0586008498132224
	0.0571899256477284
	0.0571899256477284
    0.0555577448062125
	0.0555577448062125
	0.0537106218889962
	0.0537106218889962
	0.0516557030695811
	0.0516557030695811
	0.0494009384494663
	0.0494009384494663
	0.0469550513039484
	0.0469550513039484
	0.0443275043388033
	0.0443275043388033
	0.0415284630901477
	0.0415284630901477
	0.0385687566125877
	0.0385687566125877
	0.0354598356151462
	0.0354598356151462
	0.0322137282235780
	0.0322137282235780
	0.0288429935805352
	0.0288429935805352
	0.0253606735700124
	0.0253606735700124
	0.0217802431701248
	0.0217802431701248
	0.0181155607134894
	0.0181155607134894
	0.0143808227614856
	0.0143808227614856
	0.0105905483836510
	0.0105905483836510
	0.0067597991957454
	0.0067597991957454
	0.0029086225531551
	0.0029086225531551]
else
    gpxi=[];
    gpw=[];
end

end