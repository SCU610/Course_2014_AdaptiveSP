% FileName:     Main.m
% Type:         Script
% Description:  Main codes of adaptive modeling of multipath channel and a 
%               biref DS communication by using LMS algorithm and parallel
%               APs.
% Composed by:  CuiAo
% Date:         Jan. 13, 2015
clear;
%% Initial PN Sequence Parameters and Object
GeneratePoly=[1,0,0,0,0,1,1];       %Set Generating Polynomial
OutMask=[1,1,0,1,0,1];              %Set Mask Polynomial
BitsPerTime=16;                     %Set output bits each genarating

%Creat both PN Objects: PnTransObj as transmitter's reference and PnRecObj as receiver's
PnTransObj=commsrc.pn('GenPloy',GeneratePoly,'Mask',OutMask,'NumBitsOut',BitsPerTime);
PnRecObj=copy(PnTransObj);

%% Set Message Sequence
TransMsg='THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG. the quick brown fox jumps over the lazy dog. 1234567890'; %Set Message

%% Set Multipath Parameters
MultiPathPoly=0.8+0.5*randn([15,1]);%[1,-1.5,1.25,0,0,0,0,1.4,-1.2,1.12,0,0]';%[1,-0.5,0.25,0,0,0,0,0.4,-0.2,0.12,0,0]';	%Set Multipath Polynomial
SNR=20;                             %Set SNR

%% Set LMS algorithm and AP parameters
WeightInit=zeros(size(MultiPathPoly,1),1);      %Set initial Weight with zeros which has the same demention with Multipath Polynomial
LastOptWeight=WeightInit;                       %Initial a variable to record the optimal* weight of each 16-Sample adaptive iterations
StepLength0=0.05;  StepLength1=0.05;            %Set step length for each AP
SeqTransWindow=zeros(size(MultiPathPoly,1),1);  %Set Sequence Window, which is participating in calculating the multipath channel output, initial values
SeqRecWindow0=zeros(size(MultiPathPoly,1),1);   %Set Sequence Window, which is participating in AP0, initial values
SeqRecWindow1=zeros(size(MultiPathPoly,1),1);   %Set Sequence Window, which is participating in AP1, initial values
%% Set LOOP Parameters
MsgRptTimes=20;         %Set message repeat times
MsgRptCounter=1;        %Set message repeat counter initial value, also represents the row number of received message
TotalBit=1;             %Set total iteration counter initial value
%% Transmitting and Receiving Loops
while MsgRptCounter<=MsgRptTimes
    %% Message Transmittion and Receiving Loop (Information Source)
    CharCounter=1;      %Set the counter as an index of the chars in transmitted message
    while CharCounter<=size(TransMsg,2)
        %% Char Encoding and Decoding Loop (Baseband)
        TransCharAscii=CharToAscii(TransMsg(CharCounter));  %Convert current char to ASCII
        BitCounter=1;       %Set the counter as an index of the ASCII binary bit of each char
        while BitCounter<=size(TransCharAscii,1)
            %% ASCII Bit Modulating and Transmitting
            TransSeq=PnMod(TransCharAscii(BitCounter,1),PnTransObj);    %Modulating the current ASCII binary bit by PN sequence
            TransSampleCounter=1;       %Set the counter as an index of each sample of sent sequence and signal in channel
            while TransSampleCounter<=BitsPerTime
                %% Channel Transferring Loop
                SeqTransWindow(1,1)=TransSeq(TransSampleCounter,1);     %SeqTransWindow is a 12-length shifting window (or queue) in which the samples are FIFO (First in first out)
                SeqTransWindow(2:size(SeqTransWindow,1),1)=SeqTransWindow(1:size(SeqTransWindow,1)-1,1);
                SignalTrans(TransSampleCounter,1)=MultiPathFIR(SeqTransWindow,MultiPathPoly);   %Calculate the multipath channel output 
                TransSampleCounter=TransSampleCounter+1;
            end
            %% Add White Noise and Save the Signal
            SignalRec=awgn(SignalTrans,SNR,'measured');     %Add white noise
            %% The Preparation of Signal Recieving, APs Loop and Demodulation
            RecSampleCounter=1;             %Set the counter as an index of the samples of received signal
            LocalPN1=generate(PnRecObj);    %Generate local reference PN1 sequence
            LocalPN0=-(ones(size(LocalPN1,1),1)-LocalPN1);  %Generate local reference PN0 sequence
            Weight0(:,RecSampleCounter)=LastOptWeight;  %Set the optimal weight of last AP loop as the initial for following AP loops 
            Weight1(:,RecSampleCounter)=LastOptWeight;
            while RecSampleCounter<=BitsPerTime
                %% APs Loop (LMS Algorithm)
                RecSeq(RecSampleCounter,1)=SignalRec(RecSampleCounter,1);   %Save current received signal sample for following coherent demodulation
                SeqRecWindow0(1,1)=LocalPN0(RecSampleCounter,1);            %Push the current local ref PN0 sample into 0 ref window
                SeqRecWindow0(2:size(SeqRecWindow0,1),1)=SeqRecWindow0(1:size(SeqRecWindow0,1)-1,1);
                SeqRecWindow1(1,1)=LocalPN1(RecSampleCounter,1);            %Push the current local ref PN1 sample into 1 ref window
                SeqRecWindow1(2:size(SeqRecWindow1,1),1)=SeqRecWindow1(1:size(SeqRecWindow1,1)-1,1);
                AdpLocalPN0(RecSampleCounter,1)=MultiPathFIR(SeqRecWindow0,Weight0(:,RecSampleCounter));    %Calculate the current AP0's output
                Ek0(RecSampleCounter,1)=SignalRec(RecSampleCounter,1)-AdpLocalPN0(RecSampleCounter,1);      %Calculate the current AP0's error
                Weight0(:,RecSampleCounter+1)=Weight0(:,RecSampleCounter)+2.*StepLength0.*Ek0(RecSampleCounter,1)*SeqRecWindow0;    %Using lms to calculate AP0's weight
                AdpLocalPN1(RecSampleCounter,1)=MultiPathFIR(SeqRecWindow1,Weight1(:,RecSampleCounter));    %Calculate the current AP1's output
                Ek1(RecSampleCounter,1)=SignalRec(RecSampleCounter,1)-AdpLocalPN1(RecSampleCounter,1);      %Calculate the current AP1's error
                Weight1(:,RecSampleCounter+1)=Weight1(:,RecSampleCounter)+2.*StepLength1.*Ek1(RecSampleCounter,1)*SeqRecWindow1;    %Using lms to calculate AP1's weight
                RecSampleCounter=RecSampleCounter+1;
            end
            %% Demodulation using SDM-MSE determination
            KesiPerBit0=mse(Ek0);   %Calculate the mean square error of AP0 in last AP loop  
            KesiPerBit1=mse(Ek1);   %Calculate the mean square error of AP1 in last AP loop
            RecCharAscii(BitCounter,1)=PnDemod(RecSeq,LocalPN0,LocalPN1); %Coherent demodulation (as compare)
            if KesiPerBit0<KesiPerBit1
                LastOptWeight=Weight0(:,RecSampleCounter);
                Weight(:,(TotalBit-1)*(size(Weight0,2)-1)+1:(TotalBit)*(size(Weight0,2)-1))=Weight0(:,1:RecSampleCounter-1);
                SeqRecWindow1=SeqRecWindow0;
                AdpRecCharAscii(BitCounter,1)=0;
                KesiLoc(TotalBit)=KesiPerBit0;
            elseif KesiPerBit1<KesiPerBit0
                LastOptWeight=Weight1(:,RecSampleCounter);
                Weight(:,(TotalBit-1)*(size(Weight1,2)-1)+1:(TotalBit)*(size(Weight1,2)-1))=Weight1(:,1:RecSampleCounter-1);
                SeqRecWindow0=SeqRecWindow1;
                AdpRecCharAscii(BitCounter,1)=1;
                KesiLoc(TotalBit)=KesiPerBit1;
            else
                SeqRecWindow0=zeros(size(SeqRecWindow0,1),1);
                SeqRecWindow1=zeros(size(SeqRecWindow1,1),1);
                AdpRecCharAscii(BitCounter,1)=-1;
                KesiLoc(TotalBit)=KesiPerBit0;
            end
            AdpErrorBits(TotalBit)=xor(TransCharAscii(BitCounter,1),AdpRecCharAscii(BitCounter,1));
            CoheErrorBits(TotalBit)=xor(TransCharAscii(BitCounter,1),RecCharAscii(BitCounter,1));            
            BitCounter=BitCounter+1;
            TotalBit=TotalBit+1;
        end
        AdpRecMsg(MsgRptCounter,CharCounter)=AsciiToChar(AdpRecCharAscii);
        RecMsg(MsgRptCounter,CharCounter)=AsciiToChar(RecCharAscii);
        CharCounter=CharCounter+1;
    end
    MsgRptCounter=MsgRptCounter+1;
end
AdpErrorBitsSum=sum(AdpErrorBits);
CoheErrorBitsSum=sum(CoheErrorBits);
