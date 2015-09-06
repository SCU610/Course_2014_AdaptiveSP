%Two-weight FIR adaptive structure implementation using SER algorithm
%***************************************************************************
%****       Two-weight FIR adaptive structure using SER algorithm       ****
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

StepLength=0.05;%SER iteration step
IterationCount=0;%Loop Counter
ExtraCount=0;
WeightInit=[4,-10]';%Initialization Weight Vector

SinGenerator=@(k) sin(2*pi*k/N);%Sin function
CosGenerator=@(k) cos(2*pi*k/N);%Cos function

%Generate Input/Desire signal squence and add white noise
SinSquence=SinGenerator(-SignalBoundary:SignalStep:SignalBoundary)';
SinSignalPower=sum(abs(SinSquence(:)).^2)/length(SinSquence(:));
SNR=10.*log10(SinSignalPower/NosiePower);
InputSquence=awgn(SinSquence,SNR,'measured');
InputPower=sum(abs(InputSquence(:)).^2)/length(InputSquence(:));
DesireSquence=2.*CosGenerator(-SignalBoundary:SignalStep:SignalBoundary)';


Xk0=InputSquence(Index:Index+SquenceLength-1,:);
Xk1=InputSquence(Index-1:Index+SquenceLength-1-1,:);
XkArray=[Xk0,Xk1];
Dk=DesireSquence(Index:Index+SquenceLength-1,:);

%SER
Alpha=2.^(-1/N);
q0=10;
Qinvkinit=q0.*[1,0;0,1];
W(:,IterationCount+1)=WeightInit;
Qinvk(:,:,IterationCount+1)=Qinvkinit;
LamdaAV=mse(Xk0);

while IterationCount<800
    Yk(:,IterationCount+1)=XkArray*W(:,IterationCount+1);
    Ek(:,IterationCount+1)=Dk-Yk(:,IterationCount+1);
    MeanSquareError(:,IterationCount+1)=mse(Ek(:,IterationCount+1));
    if(IterationCount==0)
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*Ek(IterationCount+1,IterationCount+1).*StepLength.*LamdaAV.*Qinvk(:,:,IterationCount+1)*XkArray(IterationCount+1,:)';
    elseif(IterationCount>=1)
        S=Qinvk(:,:,IterationCount)*XkArray(IterationCount+1,:)';
        Gama=Alpha+XkArray(IterationCount+1,:)*S;
        Qinvk(:,:,IterationCount+1)=(Qinvk(:,:,IterationCount)-S*S'/Gama)/Alpha;
        W(:,IterationCount+1+1)=W(:,IterationCount+1)+2.*Ek(IterationCount+1,IterationCount+1).*StepLength.*LamdaAV.*(1-Alpha.^(IterationCount+1))/(1-Alpha)*Qinvk(:,:,IterationCount+1)*XkArray(IterationCount+1,:)';
    else
        error(message('Error!'));
    end
    IterationCount=IterationCount+1;
end

Q1final(1:IterationCount)=Qinvk(1,1,1:IterationCount);
Q2final(1:IterationCount)=abs(Qinvk(1,2,1:IterationCount));
R=[mean(Xk0(:).*Xk0(:)),mean(Xk0(:).*Xk1(:));mean(Xk1(:).*Xk0(:)),mean(Xk1(:).*Xk1(:))];
Rinv=inv(R);
Qinvinf=(1-Alpha).*Rinv;