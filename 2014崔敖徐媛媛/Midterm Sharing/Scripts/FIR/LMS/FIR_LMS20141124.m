%Two-weight FIR adaptive structure implementation using LMS algorithm
%***************************************************************************
%****     Two-weight FIR adaptive structure using LMS algorithm         ****
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

StepLength=0.05;%LMS iteration step
IterationCount=0;%Loop Counter
ExtraCount=0;
WeightInit=[4,-10]';%Initial Weight Vector

SinGenerator=@(k) sin(2*pi*k/N);%Sin function
CosGenerator=@(k) cos(2*pi*k/N);%Cos function

%Generate Input/Desire signal squence
SinSquence=SinGenerator(-SignalBoundary:SignalStep:SignalBoundary)';
SinSignalPower=sum(abs(SinSquence(:)).^2)/length(SinSquence(:));
SNR=10.*log10(SinSignalPower/NosiePower);
InputSquence=SinSquence+wgn(size(SinSquence,1),1,10*log10(NosiePower));
InputPower=sum(abs(InputSquence(:)).^2)/length(InputSquence(:));
DesireSquence=2.*CosGenerator(-SignalBoundary:SignalStep:SignalBoundary)';
NoiseP=InputPower-SinSignalPower;


Xk0=InputSquence(Index:Index+SquenceLength-1,:);
Xk1=InputSquence(Index-1:Index+SquenceLength-1-1,:);
XkArray=[Xk0,Xk1];
Dk=DesireSquence(Index:Index+SquenceLength-1,:);

%LMS
W(:,IterationCount+1)=WeightInit;

while IterationCount<800     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Yk(:,IterationCount+1)=XkArray*W(:,IterationCount+1);
    Ek(:,IterationCount+1)=Dk-Yk(:,IterationCount+1);
    MeanSquareError(:,IterationCount+1)=mse(Ek(:,IterationCount+1));
    if(MeanSquareError(:,IterationCount+1)<0.01)
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*StepLength.*XkArray(IterationCount+1,:)'*Ek(IterationCount+1,IterationCount+1);
        if(ExtraCount>200)
            break;
        else
            IterationCount=IterationCount+1;
            ExtraCount=ExtraCount+1;
            continue;
        end
    else
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*StepLength.*XkArray(IterationCount+1,:)'*Ek(IterationCount+1,IterationCount+1);
        ExtraCount=0;
    end
    IterationCount=IterationCount+1;
end

for i=1:IterationCount
    Ereal(i)=Ek(i,i);
    KesiReal(i)=mse(Ereal);
    KesiTheory(i)=(0.5+NosiePower)*(W(1,i)^2+W(2,i)^2)+W(1,i)*W(2,i)*cos(2*pi/N)+2*W(2,i)*sin(2*pi/N)+2;
    Ykreal(i)=Yk(i,i);
    Dkreal(i)=Dk(i,:);
    i=i+1;
end
Wopt0=2*cos(2*pi/N)*sin(2*pi/N)/((1+2*NoiseP)^2-(cos(2*pi/N))^2);
Wopt1=-2*(1+2*NoiseP)*sin(2*pi/N)/((1+2*NoiseP)^2-(cos(2*pi/N))^2);
KesiMin=(0.5+NoiseP)*(Wopt0^2+Wopt1^2)+Wopt0*Wopt1*cos(2*pi/N)+2*Wopt1*sin(2*pi/N)+2;