# Test the Mem = Mem op B instructions

# Add B to memory location
	mov a '@'
	mov $8000, a
	mov b, $01
	add $8000, b
	mov a, $8000; out a

# Increment the location
	inc $8000; mov a, $8000; out a
	inc $8000; mov a, $8000; out a
	inc $8000; mov a, $8000; out a
	inc $8000; mov a, $8000; out a
	dec $8000; mov a, $8000; out a
	dec $8000; mov a, $8000; out a

# Clear a location
	clr $8000

	mov a, '\n';  out a
	jmp $ffff
