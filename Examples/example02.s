# Push and pop examples

	nop
	mov b, 0
	mov a, '\n' ; push a
	mov a, '\n' ; push a
	mov a, 'o' ; push a
	mov a, 'l' ; push a
	mov a, 'l' ; push a
	mov a, 'e' ; push a
	mov a, 'H' ; push a

	# Ensure we don't still have a 'H'
	mov a, $00

	pop a; out a
	pop a; out a
	pop a; out a
	pop a; out a
	pop a; out a
	pop a; out a
	pop a; out a

end:	jmp $FFFF
