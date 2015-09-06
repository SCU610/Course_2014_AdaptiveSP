function [TransSequence,PN0Seq,PN1Seq]=PnEncode(Message,PN0,PN1,RptTimes,BitsPerTime)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
MesgLength=size(Message,1);
BitLength=size(Message,2);
Count=1;
TimeCode=1;
SequenceBuffer=zeros(BitsPerTime*BitLength*MesgLength*RptTimes,1);
PN0Seq=zeros(BitsPerTime*BitLength*MesgLength*RptTimes,1);
PN1Seq=zeros(BitsPerTime*BitLength*MesgLength*RptTimes,1);
while Count<=RptTimes
    MesgCount=1;
    while MesgCount<=MesgLength
	BitCount=1;
        while BitCount<=BitLength
            PN0Seq(TimeCode:TimeCode+BitsPerTime-1,1)=generate(PN0);
            PN1Seq(TimeCode:TimeCode+BitsPerTime-1,1)=generate(PN1);
            if Message(MesgCount,BitCount)==0
                SequenceBuffer(TimeCode:TimeCode+BitsPerTime-1,1)=PN0Seq(TimeCode:TimeCode+BitsPerTime-1,1);
            elseif Message(MesgCount,BitCount)==1
                SequenceBuffer(TimeCode:TimeCode+BitsPerTime-1,1)=PN1Seq(TimeCode:TimeCode+BitsPerTime-1,1);
            else
                error(message('Error! Invaild Index'));
            end
            BitCount=BitCount+1;
            TimeCode=TimeCode+BitsPerTime;
        end
            MesgCount=MesgCount+1;
    end
    Count=Count+1;
end
TransSequence=SequenceBuffer;
end


