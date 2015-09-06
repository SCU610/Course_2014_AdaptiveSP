clear;
SquenceLength=1024;%Set Input/Output squence length
NosiePower=1;%Set White Gussian-Noise Power

IterationCount=0;%Loop Counter
ExtraCount=0;
WeightInit=[1,0,0]';%Initialization Weight Vector

%Generate Input white noise
Xk=wgn(SquenceLength,1,10*log10(NosiePower));
Dk=IIRout(Xk,1,1.2,-0.6);%zero-state 
Yk(:,IterationCount+1)=zeros(size(Xk,1),1);
Ek(:,IterationCount+1)=zeros(size(Xk,1),1);
Col=1;
Row=1;
IterationCount=0;
for b1=-2:0.02:2
    for b2=1:-0.02:-1
        Yk(:,IterationCount+1)=IIRout(Xk,1,b1,b2);
        Ek(:,IterationCount+1)=Dk-Yk(:,IterationCount+1);
        Kesi(Row,Col)=mse(Ek(:,IterationCount+1));
        Row=Row+1;
        IterationCount=IterationCount+1;
    end
    Row=1;
    Col=Col+1;
end