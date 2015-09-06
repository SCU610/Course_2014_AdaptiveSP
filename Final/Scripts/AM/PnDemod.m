function BitOut= PnDemod(RecSeq,LocalPN0,LocalPN1)
% FileName:      PnDemod.m
% Type:          Function
% Description:   Demodulate a bit using PN key shifting. PN0 is the minus
%                invert of PN1
% Composed by:   CuiAo
% Date:          Jan. 9, 2015
%% Error Check
if size(RecSeq,1)~=size(LocalPN0,1)||size(RecSeq,1)~=size(LocalPN1,1)
    error(message('Error in fuction: "PnDemod.m" ! Invaild input RecSeq'));
end
%% Local Ref PN Sequence Generation
PN0=LocalPN0;   % Generate PN1
PN1=LocalPN1;	% Generate PN0
%% Coherent Demodulation
Acc0=sum(RecSeq.*PN0);
Acc1=sum(RecSeq.*PN1);
if Acc0>Acc1
    BitOutTemp=0;
elseif Acc0<Acc1
    BitOutTemp=1;
else
    BitOutTemp=-1;
end
%% Output
BitOut=BitOutTemp;
end

