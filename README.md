# FISC: An 8-bit TTL CPU with a Stack Register

FISC is an 8-bit microseqenced CPU wth a 64K address space built from
discrete TTL-level components. It provides:

 + recursive **F**unctions,
 + **I**ndexed addressing and
 + **S**tack operations

as well as the usual load/store and arithmetic operations, comparisons,
branches and jumps.

The design uses 25 chips and has 8K of ROM, 56K of RAM and a UART.

## Documentation

The overall design of the CPU is covered in
[Docs/arch_overview.md](Docs/arch_overview.md), and some details
of the expected hardware implementation are in 
[Docs/fisc_implementation.md](Docs/fisc_implementation.md).

## Implementation

At present, I have:

 + a Perl CPU simulator, [csim](csim)
 + an assembler, [cas](cas)
 + example assembly programs in [Examples](Examples)
 + a Verilog design in [Verilog](Verilog)
 + an initial schematic in [Kicad/schematic.pdf](Kicad/schematic.pdf)

I have a first draft PCB layout in [Kicad](Kicad) but this won't be
the final version. I still have to do a lot of checking on the design.

## Status of the CPU

**mid-May, 2020**: Both the Perl simulator and the Verilog model work
well. I've settled on the hardware design and done the schematic and
a rough PCB layout. Now I need to check for mistake and clean up the
PCB layout. I'd also like to port my `clc` compiler to this CPU.

For more detail on progress, you can read my [Docs/journal.md](journal).
