%Two-weight FIR adaptive structure implementation using LMS/Newton algorithm
%***************************************************************************
%****   Two-weight FIR adaptive structure using LMS/Newton algorithm    ****
%****               Created & Composed By CUI AO                        ****
%****                                                                   ****
%****                Last Modified: Oct. 1, 2014                        ****
%****                                                                   ****
%***************************************************************************
clear;
%Given Initialization Parameters
N=16;%Set SIN period
SignalStep=1;%Set Singal initialization step
SquenceLength=50.*N/SignalStep;%Set Input/Output squence length
NosiePower=0.01;%Set White Gussian-Noise Power
SignalBoundary=5000;
Index=SignalBoundary+1;

StepLength=0.05;%LMS/Newton iteration step
IterationCount=0;%Loop Counter
ExtraCount=0;
WeightInit=[4,-10]';%Initialization Weight Vector

SinGenerator=@(k) sin(2*pi*k/N);%Sin function
CosGenerator=@(k) cos(2*pi*k/N);%Cos function

%Generate Input/Desire signal squence and R/R1 matrix
SinSquence=SinGenerator(-SignalBoundary:SignalStep:SignalBoundary)';
SinSignalPower=sum(abs(SinSquence(:)).^2)/length(SinSquence(:));
SNR=10*log10(SinSignalPower)-10*log10(NosiePower);
InputSquence=awgn(SinSquence,SNR,'measured');
InputPower=sum(abs(InputSquence(:)).^2)/length(InputSquence(:));
DesireSquence=2.*CosGenerator(-SignalBoundary:SignalStep:SignalBoundary)';


Xk0=InputSquence(Index:Index+SquenceLength-1,:);
Xk1=InputSquence(Index-1:Index+SquenceLength-1-1,:);
XkArray=[Xk0,Xk1];
Dk=DesireSquence(Index:Index+SquenceLength-1,:);

R=[mse(Xk0),mean(Xk0.*Xk1);mean(Xk1.*Xk0),mse(Xk1)];
R1=inv(R);

LamdaAV=trace(R)/size(R,1);

%LMS/Newton
W(:,IterationCount+1)=WeightInit;

while IterationCount<800     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Yk(:,IterationCount+1)=XkArray*W(:,IterationCount+1);
    Ek(:,IterationCount+1)=Dk-Yk(:,IterationCount+1);
    MeanSquareError(:,IterationCount+1)=mse(Ek(:,IterationCount+1));
    if(MeanSquareError(:,IterationCount+1)<0.01)
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*StepLength.*LamdaAV.*Ek(IterationCount+1,IterationCount+1).*R1*XkArray(IterationCount+1,:)';
        if(ExtraCount>200)
            break;
        else
            IterationCount=IterationCount+1;
            ExtraCount=ExtraCount+1;
            continue;
        end
    else
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*StepLength.*LamdaAV.*Ek(IterationCount+1,IterationCount+1).*R1*XkArray(IterationCount+1,:)';
        ExtraCount=0;
    end
    IterationCount=IterationCount+1;
end
