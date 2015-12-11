function X=LocalToGlobal(elenodes,xi)

N=sval('quad4',xi)
X=elenodes'*N;

end