# Implementation of the FISC CPU

This document outlines some of the implementation decisions for the FISC
CPU. As with the CSCvon8 CPU, one of the goals is to keep the chip count
down. This time, recursive functions, local variables and indexed addressing
are important goals.

## List of Chips

FISC is going to be an upgrade to the CSCvon8 CPU implementation, so I can
reuse many of the previous components. Here is the list of chips that I
expect to use. All of these chips have tri-state outputs, which means I
can connect them directly to the address and data busses.

```
PC                      2       74LS593 DIP utsource
AR                      2       74HCT574 SOIC
SP                      2       74LS469 DIP utsource
Address buffers         2       74HCT541 SOIC
ROM                     1       28C256 or smaller ROM, try AT28C64B 8Kx8 DIP
RAM                     1       AS6C62256 SRAM SOIC
UART                    1       UM245R DIP
Areg                    1       74HCT574 SOIC
Breg                    1       74HCT574 SOIC
ALU                     1       27C322 ROM DIP utsource
Carry                   1       74HCT574 SOIC (sigh)
Oreg                    1       74HCT574 SOIC
IR                      1       74HCT574 SOIC
uSeq counter            1       74HCT161 SOIC
Decode logic            1       AT27C1024 ROM DIP
Jump logic              1       74HCT151 SOIC
```

We also need to demultiplex several of the bit groups from the Decode Logic,
so we also need these chips:

```
Inverter                1       74HCT240 SOIC
2:4 address demux       1/2     74HCT139 SOIC
4:16 dbus rd demux      1       74HCT154 SOIC
3:8 dbus wr demux       1       74HCT138 SOIC
2:4 stack demux         1/2     74HCT139 SOIC
Memory selector         1       74HCT138 SOIC
```

This brings the chip count to 25. This doesn't include the clock component
or the reset circuitry.

## Two-Phase Clock Cycle

As with the CSCvon8 CPU, the FISC CPU has a two phase clock cycle.

In the first half of the clock cycle (i.e. on the rising clock edge),
the address is asserted on the address bus, and data is asserted on
the data bus. The ALU performs its operation and produces an output.

In the second half of the clock cycle (i.e. on the falling clock edge),
any data on the data bus is stored into zero or more registers and the
O and Carry registers are updated.

## Program Counter

I chose to re-use the 74LS593 as the device for the PC because it has
an asynchronous load. We need this because there is a delay between
the drop in the `clk` signal in the middle of the clock cycle and the
generation of the `~PCload` control line. If the load was synchronous,
the `~PCload` would have its old value when `clk` drops and the PC
would never jump. It's a pity that there isn't a modern SOIC packaged
8-bit up/down counter with tri-state output and asynchronous active-low
load.

## Stack Pointer

The SP is made from two 74LS469 up/down counters. I wish there was a
modern 8-bit up/down counter. I couldn't use this device for the PC as
it has a synchronous load.

## Other Registers

All other registers are the 74HCT574 which is both modern and comes in
a SOIC package. This has tri-state output which we need to ensure that
only one device writes to a bus at any time. The only big disadvantage
with this device is that its load line is active high. The decode
logic produces active low lines, so we need several inverter gates
for the 74HCT574 load lines.

## Conditional Jumps

As there are more devices to control in this design, I ran out of
control lines with the 16 bits of output from the AT27C1024 ROM
I'm using to decode the instruction. Thus, there are several
demux chips. Even then, I had to "cheat" and overload the bottom
three bits from the actual instruction to control one of the
eight possible jumps. This is fine, except that we have to put
the jump instructions at specific opcode numbers.

For example, the 74HCT151 3:8 demultiplexer (which does the jump)
logic receives the `zero output` line from the ALU on its lowest
input. Therefore, any instruction which needs to jump when this
line is asserted must have `000` as the low three bits of the
opcode number. The "Jump if A equals B" instruction (which tests
if A-B is zero) is thus at opcode 0x10 and not at opcode 0x11.

## Chip Count

One of the goals in this design is the keep the chip count down,
and at present the chip count is 25. There are things that I
wish I could improve. For example, we need to store the ALU carry
between successive additions or subtractions. I am using a whole
74HCT574 to store this and I wish I could keep the carry in an
exisiting device but I can't.

A 74HCT138 is used to select the bottom 8K of memory to be the ROM.
I could lose this and use the most significant bit of the address
bus to select between ROM and RAM. But then I would have 32K of
ROM and 32K of RAM.

We need the O register to buffer the output from the ALU. We can't
write it directly to the data bus as the data bus is itself one
of the inputs to the ALU.

We also need the two 74HCT541 buffers to allow/stop the address
bus value on to the data bus. We can't just enable/disable
(for example) the AR registers output instead. Consider the
instruction `A = Memory[ AR ]`. The address bus has to have the
AR value, and the data bus has to have the value from memory.
