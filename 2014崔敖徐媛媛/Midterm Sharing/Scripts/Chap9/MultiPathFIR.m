function Y = MultiPathFIR( X,CoeffVect)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%CoeffVect=[a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11]';
Length=size(X,1);
LengthCV=size(CoeffVect,1);
LengthY=Length+LengthCV-1;
XARRAY=zeros(LengthY,LengthCV);
for i=1:LengthCV
    XARRAY(i:i+Length-1,i)=X;
end
Y=XARRAY*CoeffVect;
end

