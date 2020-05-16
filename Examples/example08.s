# Subroutine call and return

	nop

start:  mov a, '1'; out a
	jsr fred
	mov a, '2'; out a
	mov a, '\n'; out a
	jmp $FFFF

fred: mov a, 'f'; out a
      mov a, 'r'; out a
      mov a, 'e'; out a
      mov a, 'd'; out a
      rts
