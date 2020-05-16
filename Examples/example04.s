# Indexed memory reads

	mov a, 'e'
	mov $8002, a
	mov a, $00
	mov b, $02
	mov a, $8000+b		# Access $8002
	out a
	mov a, '\n' ; out a

	mov a, 'f'
	mov $8000+b, a

	mov a, $00
	mov b, $72
	mov a, $7F90+b		# Access $8002
	out a
	mov a, '\n' ; out a

end:	jmp $FFFF
