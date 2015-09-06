time=1;
for i=1:150*8
    if mod(time-1,8)==0&&time~=1
        time=1;
    end
    MessageSent((i-1)*8+1:i*8,1)=Message(time,:)';
    time=time+1;
end
errorcode=xor(MessageSent(:,1),SeqDecoded(:,1));
errorcode=double(errorcode);
errorcodetotal=sum(errorcode(:,1));