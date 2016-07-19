%***************************************************************************
%****               3 Parameter IIR filter function                     ****
%****               Created & Composed By CUI AO                        ****
%****                                                                   ****
%****                Last Modified: Oct. 1, 2014                        ****
%****                                                                   ****
%***************************************************************************
function y=IIRout(X,a0,b1,b2)
counter=0;
while counter<=size(X,1)-1
   if counter==0
      y(counter+1,1)=a0.*X(counter+1,1);
   elseif counter==1
      y(counter+1,1)=a0.*X(counter+1,1)+b1.*y(counter,1);
   elseif counter>1&&counter<=size(X,1)-1
      y(counter+1,1)=a0.*X(counter+1,1)+b1.*y(counter,1)+b2.*y(counter-1,1);
   else
       break;
      %error(message('Error! Invaild Index'));
   end
   counter=counter+1;
end
end