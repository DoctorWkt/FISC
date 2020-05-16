# Indexed memory access through the stack pointer

	mov sp, $FE20	# Set the SP to $FE20
	mov a, 'A'	# Store 'A' at  $FE31
	mov $FE31, a
	mov a, 'B'	# Store 'B' at  $FE00
	mov $FE00, a

	mov a, $00	# Clear A
	mov a, sp+$0011	# Load A from $FF31
	out a
	mov a, sp+$FFE0	# Load A from $FFE00
	out a
	mov a, '\n'; out a


	jmp $FFFF
