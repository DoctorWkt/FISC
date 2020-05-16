# Subroutine call and return
# with a parameter and
# a local variable

start:  mov a, '1'; out a
	mov a, 'o'; push a	# Push 'o' as a parameter
	jsr fred
	mov a, '2'; out a
	mov a, '\n'; out a
	jmp $FFFF

fred: mov a, 'f'; out a
      mov a, 'r'; out a
      mov a, 'e'; out a
      mov a, 'd'; out a
      mov a, sp+$0002; out a	# Print out the parameter
      mov a, 'k'
      mov sp+$FFFF, a		# Store 'k' as local at SP-1
      clr a
      mov a, sp+$FFFF; out a	# Print out the local
      rts
