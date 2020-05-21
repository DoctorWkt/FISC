# Warren's Working Journal for the FISC CPU

This is my working journal for the FISC CPU. It will (hopefully) go
from when I first conceived of the design on paper through to soldering the
components on a PCB and running real instructions, and beyond. I didn't write
it for public consumption; the journal helps me keep track of what I'm doing,
what issues I still need to address etc. Anyway, read on for weeks of
frustration and occasional success ...

## Thu  2 Jan 10:35:36 AEST 2020

Yesterday I decided to start sketching a CPU design which had a proper
stack pointer, indexed addressing and which allowed for function recursion.
As of now, I've given it a name (FISC) and I've got what I think is a nice
design. Below are the notes that I wrote around 12am to 1am this morning.

PC and AR as per the CSCvon8 design. The Stack Pointer (SP) is a 16-bit
register which can load zero, hold, decrement and increment.

There are three address bus writers: PC, AR and SP. These also write to the
two 8-bit tri-state buffers: this allows all six registers to write to the
data bus.

PC now reads from the data bus. This allow us to do RTS more easily:

```
  PClo <- Mem[SP++]
  PChi <- Mem[SP++]
```

I'm hoping to have only a 4K ROM: I'll use a 4-to-16 demux to decode the
top 4 address bits and use them as a select. We will have a 64K RAM but
it won't get enabled when the 4K ROM is enabled. The 4K ROM is mapped
starting at address $0000.

Stack pointer: hopefully we can start this at $0000 and then decrement it
on the first push to be $FFFF.

### ALU Operations

B is hard-wired to be the second ALU input. The data bus is the first ALU
input. The ALU operation (5 bits) comes directly from the instruction register,
and the Oreg (directly connected to the ALU output) gets updated on
every microinstruction. This should be fine, because we can write Oreg out
to the final destination on the microinstruction immediately following the
ALU microinstruction.

There's a control line to load the Flags register. Thus, we can do this on
the ALU microinstruction and then hold the Flags value for the next full
instruction. This will allow JNE, JEQ etc. instructions.

The NZVC flags and the two ALU status flags go to the Jump Logic, the same
as with the CSCvon8. Three of the ALU operation bits also are the Jump
operation bits and always go to the Jump Logic. Now, one bit from the Decode
Logic is a "Jump Enable" control line. So we can jump only when we need to.

### Decode Logic Output

 + Data bus reader: 4 bits as we have 9 data bus readers. Need a 4-to-16 demux.
 + Data bus writer: 3 bits as we have 7 data bus writers. Need a 3-to-8 demux.
 + Address bus writer: 2 bits as we have 3 address bus writers. Need a 2-to-4 demux.
 + Stack pointer operation: 2 bits. Load, increment, decrement, do nothing.
 + PC increment: 1 bit. The PC load line comes out of the Decode Logic.
 + uSeq reset: 1 bit
 + Jump enable: 1 bit

At present, this leaves us with 2 bits spare out of 16 bits.

### Data Bus Reader Control Lines

I've converted the below into the `microcode` file, but here is what
I sketched out initially.

 + PChiread
 + PCloread
 + ARhiread
 + ARloread
 + Aread
 + Bread
 + IRread
 + UARTread
 + RAMread

Use one of the spare outputs to control loading of the Flags register.
We could use the other spare outputs for other I/O devices. Maybe we should
bring these out on the edge of the PCB.

### Data Bus Writer Control Lines

 + ADhiwrite
 + ADlowrite
 + ROMwrite
 + RAMwrite
 + UARTwrite
 + Owrite

We could use the other spare outputs for other I/O devices.
Maybe we should bring these out on the edge of the PCB.

### Address Bus Writer Control Lines

 + PCwrite
 + ARwrite
 + SPwrite

## Thu  2 Jan 10:40:30 AEST 2020

So the above is what I did during the night. I also drew the block diagram
for the CPU, and modified it about six times to get to the current version
(RCS version 1.4). I've spent the morning writing an architecture document
and I have produced the start of an implementation document with the list
of chips. So far I'm up to 24 chips, not including the clock or reset
circuitry. I think I'll use the reset chip that the Gigatron uses.

The next thing to do is to write a Perl simulator for this new design,
followed by a microcode generator and an assembler. Argh! So much to do!

## Thu  2 Jan 10:54:44 AEST 2020

I would love to have a clock interrupt so I can do context switching.
I'm also thinking of writing a terminal interface where the characters
with the high bit set are used to control "disk" block I/O, i.e. the
terminal interface would also act as a disk block server.

Now, an idea. The Flags register is 8-bits wide but I'm only using
four bits to store NZVC. I could use another bit as an interrupt
bit. What I was thinking is, on conditional instructions, I check
this bit. Instead of jumping to the AR value, can we get the CPU
to jump to a specific address?

It would be a clock interrupt but it would be delayed until we
perform a branch/jump instruction, which should not be too long.

Also: branch instructions. We can now use the ALU to add to the PC,
so we can do relative branches. I wonder if we can also do
position-independent coding as well? That would be good for context
switching. I'll have to think hard about this. If not, perhaps a
loader which can adjust jumps and JSRs when we load an executable.

This is starting to sound serious!

## Thu  2 Jan 15:57:55 AEST 2020

I've got `csim` and the `microcode` to the point where I can load A
and B, add them and print out A's value as a character, then jump to
$FFFF to stop the simulation. No assembler as yet.

Actually, the old `cas` assembler works for now, as I'm not using the
special instructions like JSR. I've got an example program that prints
out "Hello world", calculates the ASCII value of '!' and prints it out.

What I'm struggling with is the names for the opcodes. Also, I'll
need to do some grouping for the ALU operations. Let's go with the
eight possible ALU groups:

 + 00-1F: Non ALU operations. I'll use 10-17 to be jump on Flags instructions,
   maybe 18-1F for branch on Flags instructions.
 + 20-3F: A= A op B
 + 40-5F: A= Mem op B
 + 60-7F: Mem= Mem op B
 + 80-9F: Mem= A op B
 + A0-BF:
 + C0-DF:
 + E0-FF:

## Thu  2 Jan 17:12:46 AEST 2020

I just got PUSH A and POP A to work, that's excellent. It worked in
`csim` first time.

I'm considering putting in another tristate buffer so that B can
also write on to the data bus. I think it's a bit limiting that
we can't do this. On the other hand, we could possibly use ARhi
and ARlo as registers :-)

## Thu  2 Jan 17:46:36 AEST 2020

I think I might have found a fatal flaw in my new design.
It's because the ALU op is hard-coded in the instruction. This
means that we can't alter it during the microsequence. Consider
the operation `A = <addr>,B` where `<addr>` is the base and `B`
is the offset.

Assume we have already done:

```
  MEMwrite ARhiread PCincr
  MEMwrite ARloread PCincr
```

and the base address is now in `AR`. What we want to do next is:

```
  ARlo = ARlo + B and set/clear carry (via Oreg)
  ARhi = ARhi + 0 with carry in (via Oreg)
```

But now we need two different ALU operations, `A+B` and `A+0`
and, at present, the architecture doesn't allow this to happen.
Damn!

I can see a way around this, but I don't like it. We need another
8-bit register. Here's how it would work. We have an ALUop register
controlled by an ALUopread control line.

The bottom five bits of the Decode output would now be:

 + Data bus writers (3 bits, 2:0)
 + Address bus writers (2 bits, 4:3)

because we can assert *no* data bus reader and so it doesn't
matter what's on either bus. In fact, we might be able to use
the *no data bus reader* as the ALUopread control line.

So, the Decode logic can disable data bus reading and send
the low five output bits as the ALUop to the ALUop register.
Then on the *next* microinstruction the ALU operation will
get performed. It will add a clock cycle delay to the ALU
operations, unfortunately.

One problem is `UARTwrite`. Sending this to the UART will
cause it to remove a character from the input buffer. Can
we move this control line to some other control output?

We don't need `Stkload` as we already have `SPhiread` and
`SPloread`. But we do need two stack operation bits
because we need increment/decrement/do nothing. We could
replace `Stkload` as `UARTwrite`.

I also don't think we need a tristate buffer for B's
output. Let's have `Bwrite` controlling B's output.
As long as there is no data bus reader, we can send
B to the ALU at the same time that its value is
on the data bus.

So, in summary:

 + replace `Stkload` as `UARTwrite`.
 + remove `UARTwrite` from the data bus writers.
 + use data bus reader 0xD as ALUopread even
   though it's not on the data bus.
 + add an ALUop register to the design.

## Fri  3 Jan 09:11:44 AEST 2020

Argh. It gets worse. I need the ALU plus the addressing registers in
the data path so that we can do 16-bit indexing. But to do this, we
need to be able to do an addition with no carry, store any carry result,
then do addition with the stored carry, all in one microsequence, e.g.

```
   clear carry
   ARlo = ARlo + B, set carry flag
   ARhi = ARhi + 0 with previous carry
```

But the current ALU doesn't have a carry-in bit! The only way I can see
how to fix this is to use one of the ALUop bits as a carry in, but I
don't want to sacrifice 16 of the 32 ALU operations. Aha, I have an idea!
Let's keep 32 ALU operations, but duplicate the
additions and subtractions in the bottom and top halves. They will use
the carry-in bit, but the other ALUops will see this bit as an ALUop bit.

```
# ALU operations (5 bits, 4:0).
# The starred operations use
# the top ALUop bit as a carry-in.
0          = 0000
A          = 0001
B          = 0002
-A         = 0003
-B         = 0004
A+1        = 0005
B+1        = 0006
A-1        = 0007
B-1        = 0008
A+B        = 0009 *
A-B        = 000A *
A-Bspecial = 000B *
A*BLO      = 000C
A*BHI      = 000D
A/B        = 000E
A%B        = 000F
A<<B       = 0010
A>>BL      = 0011
A>>BA      = 0012
AROLB      = 0013
ARORB      = 0014
A&B        = 0015
A|B        = 0016
A^B        = 0017
!A         = 0018
A+B        = 0019 *
A-B        = 001A *
A-Bspecial = 001B *
           = 001C
!B         = 001D
A+BCD      = 001E
A-BCD      = 001F
```

No this doesn't work as the top bit now has to be
wired to the Flags register, but also the ALUop
register at the same time. Sigh.

## Sun  5 Jan 17:44:03 AEST 2020

I worked out a solution, a sort of a kludge. We still use the top
bit as both an ALUop bit and also a carry-in bit. So we need a
way to set it. I've come up with this list of ALU operations:

```
# ALU operations (5 bits, 4:0).
# Top bit is bank select bit and
# also the carry-in bit
-A         = 0000       and clear carry bit
-B         = 0001       and set carry bit
A+B        = 0002       uses carry-in
A-B        = 0003       uses carry-in
A-Bcomp    = 0004       no carry-in
A-Bspecial = 0005       no carry-in
A+1        = 0006
B+1        = 0007
A-1        = 0008
B-1        = 0009
A&B        = 000A
A|B        = 000B
A^B        = 000C
!A         = 000D
!B         = 000E
A<<B       = 000F

-A         = 0010       and clear carry bit
-B         = 0011       and set carry bit
A+B        = 0012       uses carry-in
A-B        = 0013       uses carry-in
A-Bcomp    = 0014       no carry-in
A-Bspecial = 0015       no carry-in
A          = 0016
B          = 0017
A*BLO      = 0018
A*BHI      = 0019
A/B        = 001A
A%B        = 001B
A>>B       = 001C
A>>BA      = 001D
AROLB      = 001E
ARORB      = 001F
```

We have two banks of ALU operations. The first (low) bank is chosen when
the carry-in bit is clear; the second (top) bank is chosen when the carry-in
bit is set. Note that six ALU operations are in there twice.

Let's say we want to do A+1, but we don't know the state of the carry-in bit in
the Flags register. We can do this microcode:

 + Send ALUop "-A" to the ALU and write to the Flags register. Now the
   carry-in bit is zero. The next ALU operation will be in the low bank of
   sixteen.
 + Send ALUop "A+1" to the ALU and write to the Flags register. Now we have
   the result of "A+1" in Oflags and the NZVC result in the flags register.

This means that we use (waste?) a clock cycle to set the carry flag to a known
value before we do the real ALU operation. The only exceptions to this are the
first six ALU operations in each half, as they are duplicated across both ALU
operation banks.

I've recoded the `gen_alu` script to generate the ROM contents of the ALU with
these two banks of operations.

## Sun  5 Jan 21:11:50 AEST 2020

I've redrawn the block diagram and I've redone the control lines in the microcode.
I haven't fixed up `csim` or the rest of `microcode` yet.

## Sun  5 Jan 22:06:07 AEST 2020

I've worked on the microcode and `csim` and I've got `example01.s` working.
There's now a `CLC` instruction to clear the carry before we do the addition.
It's a start, and at least `A+B` works. Actually, all three first examples
now work. I haven't written any more yet.

## Mon  6 Jan 11:44:24 AEST 2020

It all became too messy once I tried to do indexed address, with a 16-bit add
between ARhi/lo and B. So I've gone with a 4-bit ALUop and the carry-in is now
always the top address bit to the ALU ROM. The ALU operations are:

```
# ALU operations (4 bits, 3:0).
A+B        = 0000       # uses carry-in
A-B        = 0001       # uses carry-in
A&B        = 0002
A|B        = 0003
A^B        = 0004
A<<B       = 0005
A>>BL      = 0006
A*B        = 0007       # low 8-bit result
A/B        = 0008
A%B        = 0009
A+0        = 000A       # uses carry-in
A-Bcomp    = 000B       # no carry-in
A-Bspecial = 000D       # no carry-in
A+1        = 000D
A-1        = 000E
~A         = 000F
```

The Decode Logic now outputs these 16 bits of control lines:

```
 + ALU operations (4 bits, 3:0)
 + Data bus writers (3 bits, 6:4)
 + Address bus writers (2 bits, 8:7)
 + Data bus readers (4 bits, 12:9)
 + Stack operation (2 bits, 14:13)
 + uSreset   = 8000
```

I'm cheating a bit: `Jmpena` is now one of the data bus reader outputs because
when we are jumping, we are not reading from the data bus. Also, `PCincr` is
now a stack operation as we have two bits (four outputs) and we need stack hold,
increment and decrement, so we can do `PCincr` as a fourth option.

So far I've got all three existing examples to work. I've also got `LDA $ADDR,B`
and `STA $ADDR,B` to work. I've updated `gen_alu`, the `microcode`, and I also
had to fix `cas` as it had old code that was breaking the new indexing.

I've also redrawn the block diagram. No ALUop register now, so that's one less
chip.

## Tue  7 Jan 09:06:41 AEST 2020

I've spent some time thinking about jumps. I want to keep the 8:1 mux as
there is no commonly-available 16:1 mux. But I also want to end up with
jumps that will suit a compiler. So here are my ideas.

Lose the concept of NVZC. Just have a 1-bit Flags register to record the carry.
We will have 16 ALUops, with a carry-in from the Flags register.

The ALU now outputs these flags:

 + Carry
 + Zero
 + Negative
 + Negative or Zero
 + Not Negative, Not Zero
 + Not Negative or Zero

We keep the A-Bcomp instruction, but replace the A-Bspecial instruction with
"0", i.e. output zero. This sets the Zero output and clears the Carry flag.

We can now have several conditional jump instructions, e.g.

 + `JANE B $addr`, performs A-Bcomp, jump if Not Zero
 + `JAEQ B $addr`, performs A-Bcomp, jump if Zero
 + `JALT B $addr`, performs A-Bcomp, jump if Not Negative or Zero
 + `JAGT B $addr`, performs A-Bcomp, jump if Negative or Zero
 + `JALE B $addr`, performs A-Bcomp, jump if Not Negative, Not Zero
 + `JAGE B $addr`, performs A-Bcomp, jump if Negative

When B is an operand, B gets preserved. But we can have other jump groups
where B is not an operand, e.g. `JANE $const $addr`. We will have to load
the constant into B to do the comparison.

For absolute jumps, use the new "0" ALU op and jump if zero.

That's six jumps based on the ALU output. This leaves two more for JIU and
JOU, plus we can JMP using "0" and jump if zero. This gives us nine jumps.

## Tue  7 Jan 10:47:29 AEST 2020

I've rewritten `gen_alu`, `csim` and some of the `microcode`. I've
written all the `AcmpB` instructions and checked four of them, all OK.
I feel happier with this. I've got a single carry bit for Flags now,
so I should also check that I can do 16-bit addition.

## Tue  7 Jan 12:14:37 AEST 2020

Hmm, I've got instructions with stack indexed by B and by a constant working.
However: I thought $FF would be treated as -1, but it's being treated as 255.
So I've got to go back to `gen_alu` and make sure that values $80 and above
are treated as negative values for addition and subtraction. Fixed, I hope.

We have JSR and RTS working. We can access parameters and locals via
the stack pointer and an offset. I have to live with the fact that B
gets destroyed by several instructions. We also have $ADDR,B working as
well, plus PUSH and POP.

Basically, the CPU is doing what I wanted it to do. Now for the chip count:

```
PC                      2       74LS593 DIP utsource
AR                      2       74HCT574 SOIC
SP                      2       74LS469 DIP utsource
Address buffers         2       74HCT241 SOIC
ROM                     1       28C256 or smaller ROM, try AT28C64B 8Kx8 DIP
RAM                     1       AS6C62256 SRAM SOIC
UART                    1       UM245R DIP
Areg                    1       74HCT574 SOIC
Breg                    1       74HCT574 SOIC
ALU                     1       27C322 ROM DIP utsource
Flags                   1       74HCT574 SOIC (sigh)
Oreg                    1       74HCT574 SOIC
IR                      1       74HCT574 SOIC
uSeq counter            1       74HCT161 SOIC
Decode logic            1       AT27C1024 ROM DIP
Jump logic              1       74HCT151 SOIC
Inverter                1       74HCT04 SOIC
2:4 address demux       1/2     74HCT139 SOIC
4:16 dbus rd demux      1       74HCT154 SOIC
3:8 dbus wr demux       1       74HCT138 SOIC
2:4 stack demux         1/2     74HCT139 SOIC
Memory selector         1       74HCT154 SOIC
                       --
                       25
```

I have to assume at least one or two more logic chips. I'm not including
the clock or reset circuitry here. I suppose that's not so bad considering
the new functionality.

It sure would be nice to find a way to merge some chips, especially the
1-bit carry register.

## Wed  8 Jan 20:10:08 AEST 2020

I got sick of the old assembly syntax, so I've rewritten the assembler.
We now have an "op dst,src" syntax with a lot of operand styles. I had
to rewrite the microcode in the process. I also turned the CPU into
a little-endian format!

Now a problem. When I changed `gen_alu` to make sure that values $80 and
above are treated as negative values, this affects both operands.
The problem is with the second instruction:

```
      mov b, $72
      mov a, $7F90+b          # Access $8002
```

We do `$90+$72`, but $90 is now negative and not positive. So instead of
getting `$02` with a carry, we don't get a carry. We end up with `$7F02`
instead of `$8002`.

The problem is, I want an unsigned address but a signed offset so that we
can do `address+offset` (for parameters) and ``address-offset` (for locals).
But I still want 8-bit addition on two signed values as well.

While I'm still pondering the solution, I've bring up to date the
architecture and implementation documents. I'm hoping I only need to
change the ALU ROM and Decode ROM contents to fix my problem, and no
big architecture redesign.

## Wed  8 Jan 21:38:58 AEST 2020

Ok, reality check: -1 is $FFFF *not* $00FF. So we can't have an 8-bit
offset and treat it as signed, because if $7F is positive it is $007F,
and if $80 is negative then it is $FF80. We need the top 8-bits as well.

So, any `+b` offset will always be positive. If we want negative stack
offsets, we need to do `sp+word` and do a full 16-bit addition.

## Thu  9 Jan 08:56:42 AEST 2020

I've changed the stack+b and stack+byte instructions to be
stack+word, and now we can properly do signed stack+offset.
I reverted the ALU back to what it was before. Looking at
the Gigatron components, there are two demuxes in a 74HCT139
so we just saved a chip! Down to 25 chips.

I imported the `runtests` script from *acwj* and rewrote it
to test our assembly examples. I now need to do the same for
`mktests`.

## Roadmap

I think the essential high-level architecture of FISC is now solid. So,
if I were to continue on this journey, here is what should come next:

 1. Complete `csim` by adding UART input.
 2. Start work on a Verilog implementation of the design. I'd
    need to code up the 74LS469 counter and possibly a few other
    devices, then wire them up. Use this to ensure that it will
    work once converted to chips.
 3. Write a FISC back-end for the `acwj` compiler. This will show
    that the architecture is decent.
 4. Port the CSCvon8 ROM monitor over, and modify `cas` to produce
    RAM-loaded executables.
 5. Start work on the KiCad schematic. Get that done.
 6. Start work on the PCB layout using SOIC devices. Get that done.
 7. Order the PCBs and parts.
 8. Build the damn thing!

I am at the point where I know all the above is possible: I can't
see any roadblocks. But I can also see that this will take about
12 months of sporadic work. The question is: do I really want to do this?

## Thu  9 Jan 11:38:18 AEST 2020

I got UART input working in `csim`. I think for the Verilog, I should
start with the CSCvon8 implementation and change it to be FISC without
the stack pointer. That will help me relearn Verilog and associated tools.

## Thu  9 Jan 17:18:06 AEST 2020

I made a start on the Verilog code. I've started to convert the CSCvon8 code.
I'm also considering using the 74F579 up/down counter instead of the 74LS469.
The only problem is that it reads & writes on the same pins, which screws up
the access to the two busses. In order to use it, I think I need a
bidirectional buffer. Something like this:

```
   -------------------------------- Address bus
              |
              |
              |
 +--------+   |
 | 74F579 |---+
 +--------+   |
            ____
  74HCT245  \_/_\ with OE_bar and DIR
              |
   -------------------------------- Data bus
```

With `OE_bar` high, both sides are high-Z. With `OE_bar` low, the `DIR`
controls the flow of data from one side to the other.

We would tie `DIR` to the 74F579's own `OE_bar` to try to send data to the
data bus, as well as definitely send data to the address bus. Then
ADhiwrite would be connected to the 74HCT245 `OE_bar` and allow the write
out to the data bus.

For the 74F579 to read from the data bus, it's `OE_bar` would be high and
would flip the direction. Then ADhiwrite .... Hmm, it's complicated! Maybe
I should stick with the 74LS469 :-)

## Sun 12 Jan 17:28:21 AEST 2020

I just had a realisation. There is only one load input to the PC chip,
and it has to do loads for JSR/RTS and also for jumps. This, I think, means
that I should wire the PC chips to load from the address bus, and get the
AR chips to write to the address bus. Obviously, the PC can't load a
16-bit address from the 8-bit data bus on Jmpena.

This does mean that we have to do a JSR like a JMP but with saving the
PC on the stack first.

I also think I should stick with 74LS469s for the PC and SP, and HCT574s
for all the other registers. Then we only need a 1-directional address->data
buffer.

## Tue 14 Jan 08:47:32 AEST 2020

Over the last 2 days I drew the first rough cut schematic for the CPU in
Kicad. This is to help me check that the control liens are going to work,
and also rewrite `csim` to make sure it matches 100%. Just for a minute
I thought the `74LS469` counters didn't do their load/inc/dec when the
output wasn't enabled (based on the truth table). Looked at the gate
diagram and there are hi-Z buffers on the output so there should not be a
problem. Phew! The design is 25 logic gates. I need only two inverter gates
and a single register bit for Carry: wish there was a way to merge them to
lose a chip. Now I need to go through it all and cross-check everything.

Done. I fixed a few things but there wasn't too much wrong. I did put
bubbles on all the active-low lines. Just printing it out. Yes I will
have to fix up the microcode and `csim` to match the schematic.

I've updated the control lines in the microcode but I need to fix JSR and
RTS. And I need to fix `csim` to match.

## Tue 14 Jan 22:32:43 AEST 2020

I just fixed the microcode, `cas` and `csim` to match the schematic. Yay!

Now that B can't be written to the data bus, is there a way to do this, e.g.
through the ALU? Right now, I'm thinking that we use A-Bcomp to compare
A and B, but we do this for the flags. Why not output B on the eight data
bits as well as the flags? I'll try this soon.

Now that the schematic is done, I might tackle the Verilog. I'll need to build
models for the '154, the '469 and the '541. Mux and buffer should be easy, but
the counter will be interesting.

Tim Rudy has already done the '154. I've just written the other two, but
I haven't written test benches for them yet.

## Wed 15 Jan 17:38:24 AEST 2020

I've done the test benches and fixed a few minor blips for the '469 and
the '541. Now the big job of writing the Verilog code for the whole CPU.

## Fri 17 Jan 14:46:35 AEST 2020

Argh. I wrote the Verilog code and it didn't work, so I started from
scratch and wrote it again, and it didn't work. So now I've started
from the CSCvon8 code and it's now at the point where I can do:

```
nop; mov a, 'H' ; out a
```

I haven't touched the ALU or the jump logic yet.

## Fri 17 Jan 15:34:57 AEST 2020

I got enough of the jump logic working to do an absolute jump, so now
I can jump to `$FFFF` and exit the verilog simulation. I need to do
at least one `nop` instruction as the first instruction.

## Sat 18 Jan 13:51:13 AEST 2020

Just added the stack pointer and got it to work. I'm fighting a glitch
where the B and Carry regs are initialised to zero, but `iverilog` starts
them as `xx` because their inputs are initially undefined. I can't see
why this is a problem. For now, I'm setting the carry value to hard-coded
zero, and we have to initialise the B register before we can jump. Why?
Because we need a valid ALU result to set the Zero flag to jump, and there
is no valid ALU result until B has a non `xx` result! Sigh.

## Mon 11 May 11:29:23 AEST 2020

It's been a few months and I lost heart with the above stumbling block.
I was speaking to some other people and I had the idea of adding a
synchronous reset line to all the register chips, just to make the Verilog
code play ball.

I've added a reset line to the `74574.v` model.

Heh. The 74LS574 has a rising edge load line and I'm using this chip for these devices:

```
  ttl_74574 IR(1'b0, IRread & reset, reset, databus, IRval);
  ttl_74574 A(Awrite, Aread, reset, databus, Aval);
  ttl_74574 B(1'b0, Bread, reset, databus, Bval);
  ttl_74574 O(Owrite, Carryread, reset, ALUresult[7:0], Oval);
  ttl_74574 AH(ARwrite, ARhiread, reset, databus, ARhival);
  ttl_74574 AL(ARwrite, ARloread, reset, databus, ARloval);
  ttl_74574 Carry(1'b0, Carryread, reset, { 7'b0, ALUresult[8] }, Cval);
```

and I have these wires declared:

```
  wire          ARhiread;       // Active low, read the AH register
  wire          ARloread;       // Active low, read the AL register
  wire          Aread;          // Active low, read the A register
  wire          Bread;          // Active low, read the B register
  wire          IRread;         // Active low, read the IR register
  wire          Carryread;      // Active low, load carry from ALU
```

Can you spot the problem? All of these lines should be active **high** not active low!
Argh! Damn, that's a lot of inverter gates I'm going to need. I've put in some `~`
inverters in the Verilog and now example 3 works fine.

So, will I have to rethink the design or will I have to live with probably another
chip for the inverter gates?

## Mon 11 May 14:17:55 AEST 2020

Here's the output of the databus reader demux:

```
  assign Jmpena= dread_out[2];
  assign ARhiread= ~dread_out[3];               // XXX NOT!
  assign ARloread= ~dread_out[4];               // XXX NOT!
  assign SPhiread= dread_out[5];
  assign SPloread= dread_out[6];
  assign Aread= ~dread_out[7];                  // XXX NOT!
  assign Bread= ~dread_out[8];                  // XXX NOT!
  assign IRread= ~dread_out[9];                 // XXX NOT!
  assign MEMread= dread_out[10];
  assign Carryread= ~dread_out[11];             // XXX NOT!
  assign UARTread= dread_out[12];
```

Five are active low, six are active high. I already have a hex inverter and I'm using
two gates, so there are only four spare. So even if I moved the 4-to-16 chip from the
74156 (inverted outputs) to the 744515 (normal outputs), I'd still need five inverters
and I only have four. I don't suppose there are octal inverter chips?

Yes, the 74HCT240 is an inverting octal buffer, so I could use that. And it seems to
be the inverting equivalent to the 74HC541 which I'm using right now! Ok, so thankfully
I can have eight inverter gates on one chip and I won't need another chip. Phew!

## Mon 11 May 14:34:12 AEST 2020

I've tried all the examples from 01 up to 09. All of them work except 08 which prints
out more than it should:

```
1fred2   is the correct output, but:
1fred1fred1fred1fred1fred1fred1fred1fred1fred1fred1fred1fred2
```

This is heartening, as it means the Verilog version is getting much closer to working
than when I left it in January.

For `example08` the RTS is doing this in `csim`:

```
PC 001d IR 50 uinst 0xc48c B 00 Zero 3200 Z NOZ ZNNEG JZ:  => 0007
PC 0007 IR 50 uinst 0x4000
```

but in the Verilog version the PC goes back to zero.

I think I have my stack pointer wiring wrong, as I'm seeing the SP value go from 0x0000
to 0x01FF which makes no sense. It should go to 0xFFFF.

## Mon 11 May 20:34:36 AEST 2020

It turns out that I had both the wiring between the two SP counters wrong, but also
the implementation of the 74LS469 counter. The CBI_bar output is more complicated than
I thought, and depends on the internal register value, CBI_bar and UD_bar. Anyway, I've
worked it out and now the Verilog version passes all nine tests that the Perl simulator
passes. I'm very happy now!

## Wed 13 May 13:01:33 AEST 2020

I started work on adding the octal inverter to the Kicad design. While I was cross-checking
the schematic with the Perl code, the microcode and the Verilog version, I noticed in the
Verilog version that I am still using 74LS593s instead of the 74LS469 counter that are in
the schematic. So I should now fix up the Verilog version!

I think I might have a problem here using the 74LS469 for the PC. It increments and loads on
a rising clock edge, so I'm using clkbar for this. However, there is a delay for PCread as it
comes through the Jump Logic which requires Jmpena to come out od the Databus Read Demux. So,
clkbar goes up but PCread is still high, so the 74LS469 doesn't load the address into the PC
from the address bus. But the '593 counters are asynchronous load, so they work fine for jumps.

## Thu 14 May 11:19:02 AEST 2020

I added a '240 octal inverter in to the verilog version and it all still works.
I've put the '593 counters into the Kicad design for the PC. I've just spent about an hour
going through all the lines, pins and chips on the Kicad design. I fixed a few silly mistakes
and I think it's good now. I do need to add in a reset, a clock and the bypass caps.

## Thu 14 May 13:06:26 AEST 2020

I added the caps, reset device, clock crystal and some pin headers on the address, data bus
and the uSeq value. The only thing I really now need to add is a button to manually reset the
CPU. Not exactly sure how to do this at present.

## Fri 15 May 16:58:12 AEST 2020

Alastair Hewitt on Hackaday TTLers Chat recommends the DS1233 as the PDF explains how to
put in a reset button. So I've changed the schematic to have this. I've just also added
lots of text to the schematic to sort of explain how it works. I moved all the components
around on the PCB and got the via count down from 272 to something about 150. That's
excellent. I might be able to squeeze the design to reduce the dimensions as well.

## Sat 16 May 10:59:59 AEST 2020

As I mentioned the CPU on the Hackaday TTLers Chat, I've decided that it's time to
make a Github repository for it. So I spent some time cleaning up the files and making
it ready for uploading.

## Sun 17 May 14:00:36 AEST 2020

I set up the Github repository and made a few typo changes. I've got the 3D model
for the UM245R back in, and I've spaced out a few things on the PCB. The vias are back
up over 200, though. I've imported
the `clc` compiler from the CSCvon8 repository and changed it. It's compiling these
programs OK: `legetests.c`, `hiprhex.cl` and `triangle.cl`. But `himinsky.cl`
and `signedprint.cl` don't work yet although they compile and assemble. I've only spent
an hour doing this so there is room for improvement! I did have to add the `equ`
pseudo-op to the assembler.

## Mon 18 May 13:14:41 AEST 2020

I'm going to put `clc` aside for a bit and start to think about building this. I've ordered
a SMT practice kit so I can practice my soldering. Now I need to think about what to order
and from where.

```
 C1-C27 0.1uF      Bypass Caps                  Digikey
 C25    220uF      Power Cap                    Digikey
 IC1    DS1233-10+ Reset Device                 Digikey
 J1                Data Bus Pin Header          Digikey
 J2                Address Bus Pin Header       Digikey
 J3                uSeq Pin Header              Digikey
 J4                Control Lines Pin Header     Digikey
 J5                Clock Pin Header             Digikey
 SW1    KS01Q01    Pushbutton                   Digikey
 U1     74LS593    PChi                         Borrow from CSCvon8
 U2     74LS593    PClo                         Borrow from CSCvon8
 U3     74HCT138   Address Decode               Digikey
 U4     74HCT240   Inverter                     Digikey
 U5, U6 74LS469                                 Utsource
 U7, U8, U11-U14, U17 74HCT574 Registers        Digikey
 U9     CY628128E  RAM                          Digikey
 U10    AT28C64B   ROM                          Digikey
 U15, U16 74HCT541 Tristate Buffers             Digikey
 U18    74HCT161   uSeq Counter                 Digikey
 U19    74HCT138   Databus Write Demux          Digikey
 U20    74HCT151   Jump Logic                   Digikey
 U21    74HCT139                                Digikey
 U22    74HCT154                                Digikey
 U23    M27C322    ALU                          Borrow from CSCvon8
 U24    UM245R     UART                         Borrow from CSCvon8
 U25    AT27C1024  Decode ROM                   Borrow from CSCvon8
 U26    ECS-100AX  Oscillator                   Borrow from CSCvon8
```

So I only need to buy some up/down counters from Utsource. The rest comes
from Digikey and I can reuse some of the CSCvon8 components.

OK, I've ordered what I could from Digikey. I couldn't get
the 64K SRAM from Digikey so I will have to try elsewhere for that.

## Tue 19 May 12:36:52 AEST 2020

I ordered the 74LS469s and a Hitachi RAM chip from Utsource, but then
Alastair on the TTLers chat suggested the Alliance Memory AS6C1008
which is a 128K chip that is still sold. I ordered one from Digikey.
So I need to update the schematic for that, and also put in a ZIF
socket 3D shape on the PCB layout. Then cross-check that the footprints
on the PCB match the chips I've ordered.

I've added the AS6C1008 and found a ZIF socket model. I've swapped the
RAM and ROM to fit the ZIF socket better. Now I'm letting that run in
freeroute to see what it does.

I've just rotated the RAM and ROM 90 degrees and the initial via count
is just 220, so that bodes well! Yes, a few SOICs were 3.9mm wide but
I had 7.5mm footprints. Now fixed. And freeroute is running again ...

## Tue 19 May 17:46:09 AEST 2020

I also moved the UART out to the edge. We're down to 139 vias and 15.976M
total trace length at pass 25. Doing well. Completed and down to 133 vias
and 15.9M total trace length at pass 30 something.

## Wed 20 May 11:21:06 AEST 2020

Going to sleep last night, I had this crazy idea. If I'm putting in a RAM
chip with more than 64K, how could I access the other 64K banks? Then I
had the crazy idea: if the 8-bit Carry register was two 4-bit registers
with their own load lines, I could store the bank number in one register.

But I've given up on this idea because, apart from the A and B register,
there is no easy way to move data between the banks. As soon as you
change the register, the old bank is invisible. I was hoping to use one
bank as a file system but it's not going to work.

But ... say I could do this, e.g. with a 74HCT74 dual D flip/flop: one
bit for carry, one bit to select the bank. Is there a way to make one
section of one bank always visible regardless of the bank bit? Such
as an 8K section of bank 0? I think I'd need at least one more glue
chip to make this happen and it's only a "would be nice" thing, so
no I won't go down this crazy path for now :-)

## Wed 20 May 13:09:17 AEST 2020

Yesterday I did look at SDCC as a compiler and assembler as it is
retargettable. But I think I'd still like to do my own. I'm getting
to the point where I think I should write a proper assembly grammar.
But I want soemthing where I can generate the Perl code and distribute
that, so other people won't have to install a yacc/lex equivalent.

## Wed 20 May 15:13:03 AEST 2020

I fixed one bug in `clc`, so `Examples/signedprint.cl` now works.
But `Examples/himinsky.cl` isn't working yet. I was able to use the
debug output from CSCvon8's `csim` and compare it to the `csim`
output here.

Ahah. In CSCvon8 we have both logical and arithmetic shift right ALU
operations. We use one for the `prhex()` function. We use the other
for the `>>` operator. FISC only has the logical shift right. So I
can't implement the `>>` operator in FISC in one instruction, sigh.

If I change the logical shift right operation to an arithmetic shift right,
then can I do an `lsr` like this:

```
        mov a, $whatever
        mov b, $04
        asr a, b		# Shift right
        mov b, $0f
	and a, b		# Lose the top bits
```

Yes I think so. It's an extra two instructions when printing hex digits.
Done. I forgot to do a `make realclean` and for a while I was using the
cached ALU ROM, sigh. Just pushed the compiler up to Github.

## Wed 20 May 16:26:21 AEST 2020

Next problem: the Verilog model outputs the same as `csim` for all the assembly
examples, but it doesn't output the same for the `clc` example programs. Not
sure why not yet. I think it might be the compare and jump instructions.
No, it's the `inc a` instruction. I must have the microcode wrong. No,
I had the O register wired wrong. It was loading when `Carryread` was being
asserted, not all the time on `clkbar`. Fixed. All the assembly tests pass.
Now I need to check the hi-level programs. `himinsky.cl` works though. Yes,
they all work fine.

## Thu 21 May 09:03:04 AEST 2020

I printed out the schematic and I've done a pass through it just looking at
the pin assignments for all the components. They all look OK except for
the octal inverter 74HCT240. I need to find a few more datasheets to confirm
the pin assignments, then work out if Kicad has it wrong. Ouch, I have two
datasheets with completely different pin assignments! Which one is correct?
I think I'm going to have to trust the Nexperia datasheet: rev 4 2016,
against the TI datasheet: October 2004. It also agrees with the Kicad pin
assignments. The TTLers suggest to test the hardware. It's SOIC but I might
be able to wire up one inverter with fly leads and see.

Someone on the Digital Design HQ Discord pointed out that the labelling is
consistent: for example, although 2Y0 and 2Y3 are swapped, so are 2A0 and 2A3.
So it really doesn't matter, phew!

## Thu 21 May 11:07:13 AEST 2020

Now doing the wiring and the purpose for all the pins. Mostly good, but I see
that I've wired up the two active low enables on the 74HCT139 to `i_clk`. But
the Verilog design has:

```
  ttl_74139 #(.BLOCKS(1)) abus_writer(1'b0, AbusWr, awrite_out);
  ttl_74139 #(.BLOCKS(1)) pcincr_demux(1'b0, StkOp, pcincr_demux_out);
```

with them wired low. I think the Verilog version is correct. We always want
something writing to the address bus, so no need for the clock signal. For
the PC increment logic, if we used `i_clk` as the output enable, then it will
enable `PCincr` when the clock drops (second half of the clock cycle). But with
it wired low, `PCincr` would only go low when both `StkOp` lines are high.

The Address Bus logic can definitely be low. I'll go check the PC increment in
Verilog and see what happens. It works when always low, doesn't work when set
to `i_clk`, so I'll rewire it low! Done. And we're freerouting again ...

## Thu 21 May 11:58:45 AEST 2020

I've been trying to work on a way to get B out on the data bus. I think I can do it.
The `A-Bcomp` ALU operation is used to compare A against B. This sets the top
eight bits from the ALU as comparison result bits. But we don't use the lower
eight bits (i.e the actual A-B result). So I could put B's value in the bottom
eight bits. I'll go try it and see what it does.

Yes, it works. I've added several more instructions with B's value on the data
bus, and I've written a test for it. All existing tests and the compiler runs
still work.

Freeroute keeps crashing or locking up on the new board design. Not sure why.

I've added even more instructions to the instruction set. I've fixed `csim` to
reset the terminal if several signals arrive.

Back to freeroute. I've made the board a bit wider in the hope that it gives the
program more 'space' to route things. I've also found two "newer" free routers
on Github, so I'm running all three at the same time to see what they do. Yes,
the original isn't crashing now so that's good. Well, one of them is completely
useless. One calls itself version 1.3.2-alpha and the original is 1.3.1. So I'm
running just these two now and will see how they go.

## Fri 22 May 08:37:08 AEST 2020

Well, version 1.3.2-alpha of freerouter is much better than 1.3.1. 1.3.2a got
down to 121 vias, 16.15M total trace length whereas 1.3.1 got to 130 vias and
16.00M total trace length. So I've got a routed PCB again!

In terms of the PCB, I think I'll have to wait now for all the parts to arrive.
I will print out the PCB design on paper and make sure that all the parts match
the footprints. Then I can order the PCB.

In the meantime, I might start working on writing a new FISC backend for my
ACWJ C compiler. I won't use registers: the A and B will just be used to get
things done. I'll use 16-bit `int`s with 8-bit `char`s and 32-bit `long`s. I'll
start with `int`s and `chars` though.
