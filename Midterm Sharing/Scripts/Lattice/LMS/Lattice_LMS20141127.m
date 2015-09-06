%Two-weight Lattice adaptive structure implementation using LMS algorithm
%***************************************************************************
%****      Two-weight Lattice adaptive structure using LMS algorithm    ****
%****               Created & Composed By Cui Ao                        ****
%****                                                                   ****
%****                Last Modified: Oct. 2, 2014                        ****
%***************************************************************************
clear;
%Given Initialization Parameters
N=16;%Set SIN period
SignalStep=1;%Set Singal initialization step
SquenceLength=100.*N/SignalStep;%Set Input/Output squence length
NosiePower=0.01;%Set White Gussian-Noise Power
SignalBoundary=5000;
Index=SignalBoundary+1;

StepLength=[0.02,0.02]';%LMS iteration step
IterationCount=0;
IterationCount2=0;%Loop Counter
WeightInit=[0,0]';%Initial Weight Vector

SinGenerator=@(k) sin(2*pi*k/N);%Sin function

%Generate Input squence
SinSquence=SinGenerator(-SignalBoundary:SignalStep:SignalBoundary)';
SinSignalPower=sum(abs(SinSquence(:)).^2)/length(SinSquence(:));
InputSquence=SinSquence+wgn(size(SinSquence,1),1,10*log10(NosiePower));
InputPower=sum(abs(InputSquence(:)).^2)/length(InputSquence(:));
Xk=InputSquence(Index:Index+SquenceLength-1,:);

ErrorForw1(:,IterationCount+1)=zeros(size(Xk,1),1);
ErrorBack1(:,IterationCount+1)=zeros(size(Xk,1),1);
ErrorForwGlobal(:,IterationCount+1)=zeros(size(Xk,1),1);
ErrorBackGlobal(:,IterationCount+1)=zeros(size(Xk,1),1);
W(:,IterationCount+1)=WeightInit;

while IterationCount<1000 
    [ErrorForw1(:,IterationCount+1),ErrorBack1(:,IterationCount+1)]=LatticePredictor(Xk,Xk,W(1,IterationCount+1));
    [ErrorForwGlobal(:,IterationCount+1),ErrorBackGlobal(:,IterationCount+1)]=LatticePredictor(ErrorForw1(:,IterationCount+1),ErrorBack1(:,IterationCount+1),W(2,IterationCount+1));
    KesiForw(IterationCount+1)=mse(ErrorForwGlobal(:,IterationCount+1));
    KesiBack(IterationCount+1)=mse(ErrorBackGlobal(:,IterationCount+1));
    if IterationCount==0
        W(:,IterationCount+1+1)=W(:,IterationCount+1)-2.*diag([StepLength(1,1),StepLength(2,1)])*[0;0];
    elseif IterationCount>=1
        W(:,IterationCount+1+1)=W(:,IterationCount+1)-2.*diag([StepLength(1,1),StepLength(2,1)])*[ErrorForw1(IterationCount+1,IterationCount+1)*Xk(IterationCount,1);ErrorForwGlobal(IterationCount+1,IterationCount+1)*ErrorBack1(IterationCount,IterationCount)];
    else
        break;
    end
    IterationCount=IterationCount+1;
end