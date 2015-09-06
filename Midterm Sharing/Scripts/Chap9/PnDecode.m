function SeqDecoded= PnDecode(Dk,YkPN0,YkPN1,BitsPerTime,Count)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
acc0=sum(Dk(Count*BitsPerTime+1:(Count+1)*BitsPerTime,:).*YkPN0(Count*BitsPerTime+1:(Count+1)*BitsPerTime,:));
acc1=sum(Dk(Count*BitsPerTime+1:(Count+1)*BitsPerTime,:).*YkPN1(Count*BitsPerTime+1:(Count+1)*BitsPerTime,:));
%mean0=mean0/BitsPerTime;
%mean1=mean1/BitsPerTime;
if acc0>acc1
    SeqDecoded=0;
elseif acc0<acc1
    SeqDecoded=1;
else
    SeqDecoded=-1;
end
end

