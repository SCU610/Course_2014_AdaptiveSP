%Two-weight IIR adaptive structure implementation using SER algorithm
%***************************************************************************
%****       Two-weight IIR adaptive structure using SER algorithm       ****
%****               Created & Composed By CUI AO                        ****
%****                                                                   ****
%****                Last Modified: Oct. 1, 2014                        ****
%****                                                                   ****
%***************************************************************************
clear;
%Given Initialization Parameters
SquenceLength=1024;%Set Input/Output squence length
NosiePower=1;%Set White Gussian-Noise Power

IterationCount=0;%Loop Counter
ExtraCount=0;
WeightInit=[0,0,0]';%Initialization Weight Vector

%Generate Input white noise
Xk=wgn(SquenceLength,1,10*log10(NosiePower));
Dk=IIRout(Xk,1,1.2,-0.6);%zero-state 
Yk(:,IterationCount+1)=zeros(size(Xk,1),1);
Ek(:,IterationCount+1)=zeros(size(Xk,1),1);


Alpha=2.^(-1/10);
q0=1;
Qinvkinit=q0.*[1,0,0;0,1,0;0,0,1];
W(:,IterationCount+1)=WeightInit;
Qinvk(:,:,IterationCount+1)=zeros(3);
LamdaAV=mse(Xk);
M=diag([0.5,0.1,0.05]);


while IterationCount<=1000
    Yk(:,IterationCount+1)=IIRout(Xk,W(1,IterationCount+1),W(2,IterationCount+1),W(3,IterationCount+1));
    Ek(:,IterationCount+1)=Dk-Yk(:,IterationCount+1);
    Kesi(IterationCount+1)=mse(Ek(:,IterationCount+1));
    if IterationCount==0
       alpha(IterationCount+1)=Xk(IterationCount+1,:);
       beta1(IterationCount+1)=0;
       beta2(IterationCount+1)=0;
       S=Qinvkinit*[Xk(IterationCount+1,:),0,0]';
       Gama=Alpha+[Xk(IterationCount+1,:),0,0]*S;
       Qinvk(:,:,IterationCount+1)=(Qinvkinit-S*S'/Gama)/Alpha;
    elseif IterationCount==1
       alpha(IterationCount+1)=Xk(IterationCount+1,:)+W(2,IterationCount+1)*alpha(IterationCount);
       beta1(IterationCount+1)=Yk(IterationCount,IterationCount)+W(2,IterationCount+1)*beta1(IterationCount);
       beta2(IterationCount+1)=W(2,IterationCount+1)*beta2(IterationCount);
       S=Qinvk(:,:,IterationCount)*[Xk(IterationCount+1,:),Yk(IterationCount,IterationCount),0]';
       Gama=Alpha+[Xk(IterationCount+1,:),Yk(IterationCount,IterationCount),0]*S;
       Qinvk(:,:,IterationCount+1)=(Qinvk(:,:,IterationCount)-S*S'/Gama)/Alpha;
    elseif IterationCount>=2&&IterationCount<=size(Xk,1)
       alpha(IterationCount+1)=Xk(IterationCount+1,:)+W(2,IterationCount+1)*alpha(IterationCount)+W(3,IterationCount+1)*alpha(IterationCount-1);
       beta1(IterationCount+1)=Yk(IterationCount,IterationCount)+W(2,IterationCount+1)*beta1(IterationCount)+W(3,IterationCount+1)*beta1(IterationCount-1);
       beta2(IterationCount+1)=Yk(IterationCount-1,IterationCount-1)+W(2,IterationCount+1)*beta2(IterationCount)+W(3,IterationCount+1)*beta2(IterationCount-1);
       S=Qinvk(:,:,IterationCount)*[Xk(IterationCount+1,:),Yk(IterationCount,IterationCount),Yk(IterationCount-1,IterationCount-1)]';
       Gama=Alpha+[Xk(IterationCount+1,:),Yk(IterationCount,IterationCount),Yk(IterationCount-1,IterationCount-1)]*S;
       Qinvk(:,:,IterationCount+1)=(Qinvk(:,:,IterationCount)-S*S'/Gama)/Alpha;
    elseif IterationCount>size(Xk,1)
       alpha(IterationCount+1)=W(2,IterationCount+1)*alpha(IterationCount)+W(3,IterationCount+1)*alpha(IterationCount-1);
       beta1(IterationCount+1)=Yk(IterationCount,IterationCount)+W(2,IterationCount+1)*beta1(IterationCount)+W(3,IterationCount+1)*beta1(IterationCount-1);
       beta2(IterationCount+1)=Yk(IterationCount-1,IterationCount-1)+W(2,IterationCount+1)*beta2(IterationCount)+W(3,IterationCount+1)*beta2(IterationCount-1);
       S=Qinvk(:,:,IterationCount)*[0,Yk(IterationCount,IterationCount),Yk(IterationCount-1,IterationCount-1)]';
       Gama=Alpha+[0,Yk(IterationCount,IterationCount),Yk(IterationCount-1,IterationCount-1)]*S;
       Qinvk(:,:,IterationCount+1)=(Qinvk(:,:,IterationCount)-S*S'/Gama)/Alpha;
    else
       error(message('Error! Invaild Count'));
    end
    Grad(:,IterationCount+1)=-2*Ek(IterationCount+1,IterationCount+1)*[alpha(IterationCount+1),beta1(IterationCount+1),beta2(IterationCount+1)]';    
    W(:,IterationCount+1+1)=W(:,IterationCount+1)-LamdaAV*(1-Alpha^(IterationCount+1))*M*Qinvk(:,:,IterationCount+1)*Grad(:,IterationCount+1)/(1-Alpha);
    IterationCount=IterationCount+1;
end
