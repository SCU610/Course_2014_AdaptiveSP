clear;
%PN0seq=[1,1,1,0,1,0,0,0]';
%PN1seq=[0,0,0,1,0,1,1,1]';
GeneratePoly0=[1,0,0,0,0,1,1];
GeneratePoly1=[1,1,0,0,0,0,1];
P0OutMask=[1,1,0,1,0,1];
P1OutMask=[0,0,1,0,1,0];
BitsPerTime=16;
P0Trans=commsrc.pn('GenPloy',GeneratePoly0,'Mask',P0OutMask,'NumBitsOut',BitsPerTime);
P1Trans=commsrc.pn('GenPloy',GeneratePoly1,'Mask',P1OutMask,'NumBitsOut',BitsPerTime);
P0Rec=P0Trans;
P1Rec=P1Trans;

Sword=[0,1,0,1,0,0,1,1];
iword=[0,1,1,0,1,0,0,1];
gword=[0,1,1,0,0,1,1,1];
nword=[0,1,1,0,1,1,1,0];
aword=[0,1,1,0,0,0,0,1];
lword=[0,1,1,0,1,1,0,0];
Message=[zeros(1,size(Sword,2));Sword;iword;gword;nword;aword;lword;zeros(1,size(Sword,2))];
MesgLength=size(Message,1);
Periods=150;
[TransK,PN0Seq,PN1Seq]=PnEncode(Message,P0Trans,P1Trans,Periods,BitsPerTime);

MultiPathVector=[1,-0.5,0.25,0,0,0,0,0.4,-0.2,0.12,0,0]';
Dk=MultiPathFIR(TransK,MultiPathVector)+wgn(size(TransK,1)+size(MultiPathVector,1)-1,1,-20);
Winit=zeros(size(MultiPathVector,1),1);
IterationCount=0;
MesgColumn=0;
MesgRow=0;
MesgCount=0;
W(:,IterationCount+1)=Winit;
StepLength=0.01;

while IterationCount<64*Periods
    Yk=MultiPathFIR(PN1Seq+PN0Seq,W(:,IterationCount+1));
    YkReal(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1)=Yk(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1);
    YkPN0=MultiPathFIR(PN0Seq,W(:,IterationCount+1));
    YkPN0Real(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1)=YkPN0(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1);
    YkPN1=MultiPathFIR(PN1Seq,W(:,IterationCount+1));
    YkPN1Real(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1)=YkPN1(IterationCount*BitsPerTime+1:(IterationCount+1)*BitsPerTime,1);
    Ek=Dk-Yk;
    SeqDecoded(IterationCount+1,1)=PnDecode(Dk,YkPN0,YkPN1,BitsPerTime,IterationCount);
    KesiOffline(IterationCount+1)=mse(Ek);
    Xkvect=XVout(PN1Seq+PN0Seq,W(:,IterationCount+1),IterationCount);
    W(:,IterationCount+1+1)=W(:,IterationCount+1)+2*StepLength*Ek(IterationCount+1,1)*Xkvect';
    if IterationCount~=0&&mod(IterationCount+1,8)==0
        if MesgColumn<size(Message,1)
            Mesg(MesgRow+1,MesgColumn+1)=MesgDecode(SeqDecoded,MesgCount);
            MesgColumn=MesgColumn+1;
            MesgCount=MesgCount+1;
        else
            MesgRow=MesgRow+1;
            MesgColumn=0;
            Mesg(MesgRow+1,MesgColumn+1)=MesgDecode(SeqDecoded,MesgCount);
            MesgColumn=MesgColumn+1;
            MesgCount=MesgCount+1;
        end
    end
    IterationCount=IterationCount+1;
end

