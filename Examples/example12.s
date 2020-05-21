# Test some memory and UART operations

# Write to memory directly, then output to the UART
	mov $8000, 'A'
	out $8000

# Output bytes directly
	out 'B'
	out '\n'
	jmp $ffff
