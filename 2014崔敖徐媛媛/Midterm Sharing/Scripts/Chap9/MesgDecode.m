function Message= MesgDecode(DecodedSeq,Count)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
WaveWord=[0,0,0,0,0,0,0,0]';
Sword=[0,1,0,1,0,0,1,1]';
iword=[0,1,1,0,1,0,0,1]';
gword=[0,1,1,0,0,1,1,1]';
nword=[0,1,1,0,1,1,1,0]';
aword=[0,1,1,0,0,0,0,1]';
lword=[0,1,1,0,1,1,0,0]';
if DecodedSeq(Count*8+1:(Count+1)*8,1)==WaveWord
    Message='~';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==Sword
    Message='S';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==iword
    Message='i';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==gword
    Message='g';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==nword
    Message='n';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==aword
    Message='a';
    return;
elseif DecodedSeq(Count*8+1:(Count+1)*8,1)==lword
    Message='l';
    return;
else
    Message='?';
end

end

