# Conditional jumps

	nop; clc
	mov a, $10
	mov b, $10
	jeq a, b L1
	mov a, 'N'  ; out a
	mov a, 'O'  ; out a
	mov a, '\n' ; out a
	jmp end
L1:	mov a, 'O'  ; out a
	mov a, 'K'  ; out a
	mov a, '\n' ; out a

	mov a, $10
	mov b, $30
	jne a, b L2
	mov a, 'N'  ; out a
	mov a, 'O'  ; out a
	mov a, '\n' ; out a
	jmp end
L2:	mov a, 'O'  ; out a
	mov a, 'K'  ; out a
	mov a, '\n' ; out a

	mov a, $40
	mov b, $30
	jgt a, b L3
	mov a, 'N'  ; out a
	mov a, 'O'  ; out a
	mov a, '\n' ; out a
	jmp end
L3:	mov a, 'O'  ; out a
	mov a, 'K'  ; out a
	mov a, '\n' ; out a

	mov a, $30
	mov b, $40
	jlt a, b L4
	mov a, 'N'  ; out a
	mov a, 'O'  ; out a
	mov a, '\n' ; out a
	jmp end
L4:	mov a, 'O'  ; out a
	mov a, 'K'  ; out a
	mov a, '\n' ; out a

end:	jmp $FFFF
