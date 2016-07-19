function ModOut= PnMod(Bit,PnTransObj)
% FileName:      PnMod.m
% Type:          Function
% Description:   Modulate a bit using PN key shifting. PN0 is the minus
%                invert of PN1
% Composed by:   CuiAo
% Date:          Jan. 9, 2015
%% Local Ref PN Sequence Generation
PN1=generate(PnTransObj);       % Generate PN1
PN0=-(ones(size(PN1,1),1)-PN1); % Generate PN0
%% Modulation & Error Check
if Bit==0
    OutTemp=PN0;
elseif Bit==1
    OutTemp=PN1;
else
    error(message('Error in fuction: "PnMod.m" ! Invaild input bit'));
end
%% Output
ModOut=OutTemp;
end

