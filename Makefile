all: alu.rom ucode.rom
	chmod +x cas csim

run: instr.rom ucode.rom alu.rom
	./csim

test: alu.rom ucode.rom runtests
	chmod +x runtests cas csim
	./runtests

# Generate the ALU ROM's contents
alu.rom: gen_alu
	chmod +x gen_alu
	./gen_alu

# Generate the Decode ROM's contents
ucode.rom: microcode gen_ucode
	chmod +x gen_ucode
	./gen_ucode

# Clean out the Verilog simulation and the assembled program
# but keep the ALU and Decode ROMs
clean:
	rm -rf a.out *.vcd instr.rom

# Clean out everything
realclean: clean
	rm -rf *.rom alu.hex opcodes
