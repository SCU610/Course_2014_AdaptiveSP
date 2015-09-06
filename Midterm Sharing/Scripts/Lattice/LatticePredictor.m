function [ErrorForw,ErrorBack] = LatticePredictor(UpperInput,LowwerInput,k)
%LatticePredictor Generate forward/ backward prediction from input sequence
%X(CurrentIndex) and caculation parameter k
%
if size(UpperInput,1)~=size(LowwerInput,1)
    error(message('Error! Invaild Vector Length'));
else
    counter=0;
    while counter<=size(UpperInput,1)-1
        if counter==0
            ErrorForw(counter+1,:)=UpperInput(counter+1,:);
            ErrorBack(counter+1,:)=k*UpperInput(counter+1,:);
        elseif counter>0&&counter<=size(UpperInput,1)-1
            ErrorForw(counter+1,:)=UpperInput(counter+1,:)+k*LowwerInput(counter,:);
            ErrorBack(counter+1,:)=LowwerInput(counter,:)+k*UpperInput(counter+1,:);
        else
            break;
        end
        counter=counter+1;
    end
    
end

end

