clear;
Hpn=comm.PNSequence('Polynomial',[3 2 0],'SamplesPerFrame',1024,'InitialConditions',[0 0 1]);
for i=1:800
    X1(:,i)=step(Hpn);
    X2(:,i)=step(Hpn);
end
