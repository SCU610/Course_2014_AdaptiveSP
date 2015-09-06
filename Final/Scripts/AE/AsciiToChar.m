function CharElement= AsciiToChar(DecodedSeq)
% FileName:      AsciiToChar.m
% Type:          Function
% Description:   Convert an 8-bits ASCII binary sequence(Column) to a char
% Composed by:   CuiAo
% Date:          Jan. 9, 2015

SpaceWord=[0,0,1,0,0,0,0,0]';
ExcMarkWord=[0,0,1,0,0,0,0,1]';
SpretMarkWord=[0,0,1,0,1,1,0,0]';
DotMarkWord=[0,0,1,0,1,1,1,0]';
Word0=[0,0,1,1,0,0,0,0]';
Word1=[0,0,1,1,0,0,0,1]';
Word2=[0,0,1,1,0,0,1,0]';
Word3=[0,0,1,1,0,0,1,1]';
Word4=[0,0,1,1,0,1,0,0]';
Word5=[0,0,1,1,0,1,0,1]';
Word6=[0,0,1,1,0,1,1,0]';
Word7=[0,0,1,1,0,1,1,1]';
Word8=[0,0,1,1,1,0,0,0]';
Word9=[0,0,1,1,1,0,0,1]';

WordA=[0,1,0,0,0,0,0,1]';
WordB=[0,1,0,0,0,0,1,0]';
WordC=[0,1,0,0,0,0,1,1]';
WordD=[0,1,0,0,0,1,0,0]'; 
WordE=[0,1,0,0,0,1,0,1]';
WordF=[0,1,0,0,0,1,1,0]';
WordG=[0,1,0,0,0,1,1,1]';
WordH=[0,1,0,0,1,0,0,0]';
WordI=[0,1,0,0,1,0,0,1]';
WordJ=[0,1,0,0,1,0,1,0]';
WordK=[0,1,0,0,1,0,1,1]';
WordL=[0,1,0,0,1,1,0,0]';
WordM=[0,1,0,0,1,1,0,1]';
WordN=[0,1,0,0,1,1,1,0]';
WordO=[0,1,0,0,1,1,1,1]';
WordP=[0,1,0,1,0,0,0,0]';
WordQ=[0,1,0,1,0,0,0,1]';
WordR=[0,1,0,1,0,0,1,0]';
WordS=[0,1,0,1,0,0,1,1]';
WordT=[0,1,0,1,0,1,0,0]';
WordU=[0,1,0,1,0,1,0,1]';
WordV=[0,1,0,1,0,1,1,0]';
WordW=[0,1,0,1,0,1,1,1]';
WordX=[0,1,0,1,1,0,0,0]';
WordY=[0,1,0,1,1,0,0,1]';
WordZ=[0,1,0,1,1,0,1,0]';

Worda=[0,1,1,0,0,0,0,1]';
Wordb=[0,1,1,0,0,0,1,0]';
Wordc=[0,1,1,0,0,0,1,1]';
Wordd=[0,1,1,0,0,1,0,0]'; 
Worde=[0,1,1,0,0,1,0,1]';
Wordf=[0,1,1,0,0,1,1,0]';
Wordg=[0,1,1,0,0,1,1,1]';
Wordh=[0,1,1,0,1,0,0,0]';
Wordi=[0,1,1,0,1,0,0,1]';
Wordj=[0,1,1,0,1,0,1,0]';
Wordk=[0,1,1,0,1,0,1,1]';
Wordl=[0,1,1,0,1,1,0,0]';
Wordm=[0,1,1,0,1,1,0,1]';
Wordn=[0,1,1,0,1,1,1,0]';
Wordo=[0,1,1,0,1,1,1,1]';
Wordp=[0,1,1,1,0,0,0,0]';
Wordq=[0,1,1,1,0,0,0,1]';
Wordr=[0,1,1,1,0,0,1,0]';
Words=[0,1,1,1,0,0,1,1]';
Wordt=[0,1,1,1,0,1,0,0]';
Wordu=[0,1,1,1,0,1,0,1]';
Wordv=[0,1,1,1,0,1,1,0]';
Wordw=[0,1,1,1,0,1,1,1]';
Wordx=[0,1,1,1,1,0,0,0]';
Wordy=[0,1,1,1,1,0,0,1]';
Wordz=[0,1,1,1,1,0,1,0]';

WordWave=ones(8,1);

Asc=DecodedSeq;
if size(Asc,1)~=size(SpaceWord,1)
    error(message('Error in fuction: "AsciiToChar.m" ! Invaild length of Input ASCII'));
end

if Asc==SpaceWord
    CharElement=' ';
elseif Asc==ExcMarkWord
    CharElement='!';
elseif Asc==SpretMarkWord
    CharElement=',';
elseif Asc==DotMarkWord
    CharElement='.';
elseif Asc==Word0
    CharElement='0';
elseif Asc==Word1
    CharElement='1';
elseif Asc==Word2
    CharElement='2';
elseif Asc==Word3
    CharElement='3';
elseif Asc==Word4
    CharElement='4';
elseif Asc==Word5
    CharElement='5';
elseif Asc==Word6
    CharElement='6';
elseif Asc==Word7
    CharElement='7';
elseif Asc==Word8
    CharElement='8';
elseif Asc==Word9
    CharElement='9';
    
elseif Asc==WordA
    CharElement='A';
elseif Asc==WordB
    CharElement='B';
elseif Asc==WordC
    CharElement='C';
elseif Asc==WordD
    CharElement='D';
elseif Asc==WordE
    CharElement='E';
elseif Asc==WordF
    CharElement='F';
elseif Asc==WordG
    CharElement='G';
elseif Asc==WordH
    CharElement='H';
elseif Asc==WordI
    CharElement='I';
elseif Asc==WordJ
    CharElement='J';    
elseif Asc==WordK
    CharElement='K';
elseif Asc==WordL
    CharElement='L';
elseif Asc==WordM
    CharElement='M';
elseif Asc==WordN
    CharElement='N';
elseif Asc==WordO
    CharElement='O';    
elseif Asc==WordP
    CharElement='P';
elseif Asc==WordQ
    CharElement='Q';
elseif Asc==WordR
    CharElement='R';
elseif Asc==WordS
    CharElement='S';
elseif Asc==WordT
    CharElement='T';    
elseif Asc==WordU
    CharElement='U';    
elseif Asc==WordV
    CharElement='V';
elseif Asc==WordW
    CharElement='W';
elseif Asc==WordX
    CharElement='X';
elseif Asc==WordY
    CharElement='Y';
elseif Asc==WordZ
    CharElement='Z';     
    
elseif Asc==Worda
    CharElement='a';
elseif Asc==Wordb
    CharElement='b';
elseif Asc==Wordc
    CharElement='c';
elseif Asc==Wordd
    CharElement='d';
elseif Asc==Worde
    CharElement='e';
elseif Asc==Wordf
    CharElement='f';
elseif Asc==Wordg
    CharElement='g';
elseif Asc==Wordh
    CharElement='h';
elseif Asc==Wordi
    CharElement='i';
elseif Asc==Wordj
    CharElement='j';    
elseif Asc==Wordk
    CharElement='k';
elseif Asc==Wordl
    CharElement='l';
elseif Asc==Wordm
    CharElement='m';
elseif Asc==Wordn
    CharElement='n';
elseif Asc==Wordo
    CharElement='o';    
elseif Asc==Wordp
    CharElement='p';
elseif Asc==Wordq
    CharElement='q';
elseif Asc==Wordr
    CharElement='r';
elseif Asc==Words
    CharElement='s';
elseif Asc==Wordt
    CharElement='t';    
elseif Asc==Wordu
    CharElement='u';    
elseif Asc==Wordv
    CharElement='v';
elseif Asc==Wordw
    CharElement='w';
elseif Asc==Wordx
    CharElement='x';
elseif Asc==Wordy
    CharElement='y';
elseif Asc==Wordz
    CharElement='z';    
    
elseif Asc==WordWave
    CharElement='~';
else
    CharElement='?';
end
end

