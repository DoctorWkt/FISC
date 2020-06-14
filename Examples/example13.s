# Test the Stack Pointer with some direct operations on it

# Set SP to a known value, write a value there and get it back
	mov a, 'H'
	mov sp, $FFFF
	mov sp, a
	mov a, $00
	mov a, sp
	out a

# Now decrement the SP, save something there
	mov a, 'i'; dec sp; dec sp; dec sp; mov sp, a

# Increment and get back the 'H'
	inc sp; inc sp; inc sp; mov a, sp; out a

# Decrement and get back the 'i'
	dec sp; dec sp; dec sp; mov a, sp; out a
	out '\n'; jmp $FFFF
