# Operations with B being placed on the data bus
#
# Output B to the UART
#
hello: nop
        mov b, 'H' ; out b
        mov b, 'e' ; out b
        mov b, 'l' ; out b
        mov b, 'l' ; out b
        mov b, 'o' ; out b
        mov b, ' ' ; out b
        mov b, 'w' ; out b
        mov b, 'o' ; out b
        mov b, 'r' ; out b

# Move B to memory and read it back
	mov b, 'l';  mov $8000, b
	mov a, $8000; out a

# Push B on the stack, get it back
	mov b, 'd'
	push b; pop a;
	out a

# Copy from B
	mov b, '\n'; mov a, b; out a

end:    jmp $FFFF
