# Force the Stack Pointer to have a specific value, $FFFF

	mov b, $FF		# We compare against B
L1:	movasplo		# Get SPlo
	jeq a, b, L2		# Break out of inner loop if $FF
	dec sp			# Nope, so decrement the SP
	jmp L1
L2:	movasphi		# Get SPhi
	jeq a, b, L3		# Break out of outer loop if $FF
	dec sp			# Nope, so decrement the SP
	jmp L1
L3:	movasphi; mov $8000, a; jsr prhex
	movasplo; mov $8000, a; jsr prhex; out '\n'
L4: 	jmp $ffff

# prhex function: Print the value in A
# out as two hex digits
prhex:  mov a, $8000    # Get the value
        mov b, $04
        asr a, b
        mov b, $0f
        and a, b        # Get high nibble of A
        mov b, $09
        jgt a, b, P1    # Skip if in range A to F
        mov b, $30      # Otherwise add '0'
        jmp P2          # and print it
P1:     mov b, $37      # Add 55 to get it in 'A' to 'F'
P2:     clc
        add a,b
        out a

        mov a, $8000    # Get value back again
        mov b, $0f      # Get the low nibble of A
        and a, b
        mov b, $09
        jgt a, b, P3    # Skip if in range A to F
        mov b, $30      # Otherwise add '0'
        jmp P4          # and print it
P3:     mov b, $37      # Add 55 to get it in 'A' to 'F'
P4:     clc
        add a,b
        out a
        rts
