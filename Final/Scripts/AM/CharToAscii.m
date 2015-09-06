function BinVect = CharToAscii( CharElement )
% FileName:      CharToAscii.m
% Type:          Function
% Description:   Convert a char to an 8-bits ASCII binary sequence(Column)
% Composed by:   CuiAo
% Date:          Jan. 9, 2015
switch (CharElement)
    case ' '
        BinVectTemp=[0,0,1,0,0,0,0,0]';
    case '!'
        BinVectTemp=[0,0,1,0,0,0,0,1]';
    case ','
        BinVectTemp=[0,0,1,0,1,1,0,0]';
    case '.'
        BinVectTemp=[0,0,1,0,1,1,1,0]';
    case '0'
        BinVectTemp=[0,0,1,1,0,0,0,0]';
    case '1'
        BinVectTemp=[0,0,1,1,0,0,0,1]';    
    case '2'
        BinVectTemp=[0,0,1,1,0,0,1,0]';
    case '3'
        BinVectTemp=[0,0,1,1,0,0,1,1]';
    case '4'
        BinVectTemp=[0,0,1,1,0,1,0,0]';
    case '5'
        BinVectTemp=[0,0,1,1,0,1,0,1]';     
    case '6'
        BinVectTemp=[0,0,1,1,0,1,1,0]';
    case '7'
        BinVectTemp=[0,0,1,1,0,1,1,1]';
    case '8'
        BinVectTemp=[0,0,1,1,1,0,0,0]';
    case '9'
        BinVectTemp=[0,0,1,1,1,0,0,1]';
    case 'A'
        BinVectTemp=[0,1,0,0,0,0,0,1]';
    case 'B'
        BinVectTemp=[0,1,0,0,0,0,1,0]';
    case 'C'
        BinVectTemp=[0,1,0,0,0,0,1,1]';
    case 'D'
        BinVectTemp=[0,1,0,0,0,1,0,0]';    
    case 'E'
        BinVectTemp=[0,1,0,0,0,1,0,1]';
    case 'F'
        BinVectTemp=[0,1,0,0,0,1,1,0]';
    case 'G'
        BinVectTemp=[0,1,0,0,0,1,1,1]';
    case 'H'
        BinVectTemp=[0,1,0,0,1,0,0,0]';     
    case 'I'
        BinVectTemp=[0,1,0,0,1,0,0,1]';
    case 'J'
        BinVectTemp=[0,1,0,0,1,0,1,0]';
    case 'K'
        BinVectTemp=[0,1,0,0,1,0,1,1]';
    case 'L'
        BinVectTemp=[0,1,0,0,1,1,0,0]';
    case 'M'
        BinVectTemp=[0,1,0,0,1,1,0,1]';
    case 'N'
        BinVectTemp=[0,1,0,0,1,1,1,0]';
    case 'O'
        BinVectTemp=[0,1,0,0,1,1,1,1]';
    case 'P'
        BinVectTemp=[0,1,0,1,0,0,0,0]';     
    case 'Q'
        BinVectTemp=[0,1,0,1,0,0,0,1]';
    case 'R'
        BinVectTemp=[0,1,0,1,0,0,1,0]';
    case 'S'
        BinVectTemp=[0,1,0,1,0,0,1,1]';
    case 'T'
        BinVectTemp=[0,1,0,1,0,1,0,0]';    
    case 'U'
        BinVectTemp=[0,1,0,1,0,1,0,1]';
    case 'V'
        BinVectTemp=[0,1,0,1,0,1,1,0]';
    case 'W'
        BinVectTemp=[0,1,0,1,0,1,1,1]';
    case 'X'
        BinVectTemp=[0,1,0,1,1,0,0,0]';     
    case 'Y'
        BinVectTemp=[0,1,0,1,1,0,0,1]';
    case 'Z'
        BinVectTemp=[0,1,0,1,1,0,1,0]';
    case 'a'
        BinVectTemp=[0,1,1,0,0,0,0,1]';
    case 'b'
        BinVectTemp=[0,1,1,0,0,0,1,0]';    
    case 'c'
        BinVectTemp=[0,1,1,0,0,0,1,1]';
    case 'd'
        BinVectTemp=[0,1,1,0,0,1,0,0]';    
    case 'e'
        BinVectTemp=[0,1,1,0,0,1,0,1]';
    case 'f'
        BinVectTemp=[0,1,1,0,0,1,1,0]';    
    case 'g'
        BinVectTemp=[0,1,1,0,0,1,1,1]';
    case 'h'
        BinVectTemp=[0,1,1,0,1,0,0,0]';    
    case 'i'
        BinVectTemp=[0,1,1,0,1,0,0,1]';
    case 'j'
        BinVectTemp=[0,1,1,0,1,0,1,0]';
    case 'k'
        BinVectTemp=[0,1,1,0,1,0,1,1]';
    case 'l'
        BinVectTemp=[0,1,1,0,1,1,0,0]';
    case 'm'
        BinVectTemp=[0,1,1,0,1,1,0,1]';
    case 'n'
        BinVectTemp=[0,1,1,0,1,1,1,0]';    
    case 'o'
        BinVectTemp=[0,1,1,0,1,1,1,1]';
    case 'p'
        BinVectTemp=[0,1,1,1,0,0,0,0]';    
    case 'q'
        BinVectTemp=[0,1,1,1,0,0,0,1]';    
    case 'r'
        BinVectTemp=[0,1,1,1,0,0,1,0]';    
    case 's'
        BinVectTemp=[0,1,1,1,0,0,1,1]';   
    case 't'
        BinVectTemp=[0,1,1,1,0,1,0,0]';    
    case 'u'
        BinVectTemp=[0,1,1,1,0,1,0,1]';
    case 'v';
        BinVectTemp=[0,1,1,1,0,1,1,0]';    
    case 'w'
        BinVectTemp=[0,1,1,1,0,1,1,1]';    
    case 'x'
        BinVectTemp=[0,1,1,1,1,0,0,0]';    
    case 'y'
        BinVectTemp=[0,1,1,1,1,0,0,1]';      
    case 'z'
        BinVectTemp=[0,1,1,1,1,0,1,0]'; 
    case '~'
        BinVectTemp=[1,1,1,1,1,1,1,1]';
    otherwise
        error(message('Error! Convert Failed'));
end
BinVect=BinVectTemp;
end

