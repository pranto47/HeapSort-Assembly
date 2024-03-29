.model small
.stack 100h
.data
A DW 8,3,9,1,8,0,'$'
.code
main proc
mov ax,@data
mov ds,ax
lea SI,A    
mov bX,6  ;ARRAY LENGTH 

MOV DI,SI
mov cx,6   ;COUNTER FOR HEAPIFY
shr cx,1

heapcall:
SUB CX,1
call heapify
ADD CX,1
loop heapcall


MOV CX,BX
MAXHEAP:
PUSH CX
DEC CX
MOV BX,CX
MOV CX,0
MOV AX,BX
CALL SWAP
CALL heapify
pop cx
loop MAXHEAP


mov cx,6
mov dx,0
addint:
add [SI],30H
ADD SI,2
LOOP ADDINT

lea dx,A
mov ah,9
int 21h    
    
mov ah,4ch
int 21h    
main endp


heapify proc
PUSH CX
H_LOOP:
PUSH CX         ;PUSHING BX MUST BE POPPED BEFORE RETURN


MOV AX,CX       ;LARGEST = DL    
MOV CX,CX
SHL CX,1
MOV DX,CX
ADD DX,2
ADD CX,1        ; CL = I;AH = 2*I+2 = R ;AL = 2*I+1 = L

CMP CX,BX
JGE SECONDCHECK             ;PUSHING BX MUST BE POPPED
PUSH AX
PUSH CX
SHL AX,1
SHL CX,1
PUSH SI
PUSH DI
ADD SI,AX
ADD DI,CX

PUSH DX
MOV DX,[SI]
CMP [DI],DX
POP DX
POP DI
POP SI
POP CX
POP AX
JLE SECONDCHECK
MOV AX,CX



SECONDCHECK:
CMP DX,BX
JGE LASTCHECK
PUSH AX
PUSH DX
SHL AX,1
SHL DX,1
PUSH SI
PUSH DI
ADD SI,AX
ADD DI,DX

PUSH DX
MOV DX,[SI]
CMP [DI],DX
POP DX
POP DI
POP SI
POP DX
POP AX
JLE LASTCHECK
MOV AX,DX


LASTCHECK:
POP CX            ; POPPING CX
CMP CX,AX         ;COMPARE I AND LARGEST 
JE BREAK
CALL SWAP
MOV CX,AX
JMP H_LOOP

BREAK:
POP CX
ret    
heapify endp


SWAP PROC

PUSH AX
PUSH CX
SHL AX,1
SHL CX,1
PUSH SI
PUSH DI
ADD SI,AX
ADD DI,CX
MOV AX,[SI]
XCHG AX,[DI]
MOV [SI],AX
POP DI
POP SI
POP CX
POP AX
RET

SWAP ENDP