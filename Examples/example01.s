# Output to the UART,
# do a simple addition
# and a jump
#
hello: nop
        mov a, 'H' ; out a
        mov a, 'e' ; out a
        mov a, 'l' ; out a
        mov a, 'l' ; out a
        mov a, 'o' ; out a
        mov a, ' ' ; out a
        mov a, 'w' ; out a
        mov a, 'o' ; out a
        mov a, 'r' ; out a
        mov a, 'l' ; out a
        mov a, 'd' ; out a

# Now add two values to get ASCII '!'
	clc
	mov a, $10  ; mov b, $11
	add a, b    ; out a
        mov a, '\n' ; out a

end:    jmp $FFFF
