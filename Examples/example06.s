# 16-bit addition

	mov a,  $FF	# $8000 is #$10FF
	mov $8000, a
	mov a,  $10
	mov $8001, a
	mov a,  $75	# $8002 is #$6675
	mov $8002, a
	mov a,  $66
	mov $8003, a

	mov a, $8000	# Add the low bytes
	mov b, $8002
	clc
	add a, b
	mov $8000, a

	mov a, $8001	# Add the high bytes
	mov b, $8003
	add a, b
	mov $8001, a
	out a
	mov a, $8000
	out a
	mov a, '\n'
	out a
	jmp $FFFF	# Result: #$7774
