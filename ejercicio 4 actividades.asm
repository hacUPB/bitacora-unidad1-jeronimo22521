@16384
D=A
@pant
M=D

@1
D=A
@cont
M=D

(LOOP)
@pant
A=M
M=-1

@pant
M=M+1

@cont
MD=M-1

@LOOP
D;JGT

(END)
@END
0;JMP