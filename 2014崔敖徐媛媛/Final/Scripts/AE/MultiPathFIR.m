function OutputK= MultiPathFIR(InputWindow,TransferPoly)
% FileName:      MultiPathFIR.m
% Type:          Function
% Description:   Calculate current output of a FIR filter based on
%                the previous and current input and the transfer polynomial
%                where InputWindow and TransferPoly are both column vectors
%                and their length should equal to each other.
% Composed by:   CuiAo
% Date:          Jan. 9, 2015
if size(InputWindow,1)~=size(TransferPoly,1)    % Check
    error(message('Error in fuction: "MultiPathFIR.m" ! Invaild length of InputWindow or TransferPoly'));
else
    OutputK=InputWindow'*TransferPoly;  % Calculate output value
end
end

