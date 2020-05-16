# Copy between registers
	mov a, $65
	mov b, a
	mov b, $41
	mov a, $41; out a
	mov a, '\n'; out a
end:	jmp $FFFF
