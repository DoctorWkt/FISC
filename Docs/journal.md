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

Nope, I need "registers" for all the temporary calculations in expressions.
How about eight 4-byte memory locations to be used as registers. I'm thinking
of putting them up at the top of memory, and moving the SP down to $FFE0. This
gives me eight 32-bit registers. I'll probably go little-endian :-) And if I
see any register spills, I can always add more registers!

I think I'll also have to write an assembly optimiser to walk the generated
code and see what things can be improved.

## Fri 22 May 18:37:21 AEST 2020

My Digikey parts arrived today. I haven't opened the box yet but now I can
print out the PCB layout and check that the parts will fit.

## Sat 23 May 10:06:03 AEST 2020

It took me a while to get the layout printed to the correct scale. I had
everything set at 100%, but it turned I had to scale by 103.25%. I worked
this out by putting a known length line on the silkscreen and used that to
determine the scaling.

This morning I got out all the Digikey parts, plus the parts I already have
and the results are that everything that I have fits. I do need to order
these from Jaycar:

 + two sockets for the 74LS469s: don't exist, use pin headers.
 + maybe some more rectangular LEDs: green ZD0232, yellow ZD0234
 + pack of eight 1K resistors: RR0572
 + chisel tips for my soldering (TS1640) station: TS1644
 + a socket for the oscillator: PI6454

I even found a spare pushbutton, my 555s and my existing timer, plus a ZIF
socket and a socket for the ZIF socket! I should wait for the 74LS469s to
arrive from UTsource as these are apparently Skinny DIPs, so I might get the
wrong sockets if they turn out not to be skinny.

I just had a look at my ACWJ compiler. There's an assumption in the code
generator that each register can hold the largest type. I'll need to break
that assumption as I don't want to have to copy around four bytes at a time
just to copy a `char` or an `int`. I might have to pass in the type of each
register as well as the register numbers themselves.

## Sun 24 May 20:07:29 AEST 2020

I think it's even worse. The compiler assumes registers, but if I do, e.g.

```
  int a, b=2, c=3; a= b + c;
```

Then I should be able to do it directly on the memory location and I won't
need "in-memory registers" to hold the final `b+c` value before it's copied
to `a`. So I might have to rejig the generic code generator, too.

However, on another note I've been annoyed that `csim` doesn't let me paste
in text when running with a pseudo-tty. I just worked out a solution:

```
use IO::Pty;
use Term::ReadKey;

# By default, UART I/O goes to STDIN/OUT
my $IN  = *STDIN;
my $OUT = *STDOUT;

# Read and return one character from the terminal
sub readterm {
    my $ch, $cnt;

    while (1) {
        $cnt = sysread( $IN, $ch, 1 );

        #print("Got cnt $cnt\n");
        return ($ch) if ( $cnt == 1 );
    }
}

...
    # Open up a pty
    if ( $ARGV[0] eq "-p" ) {
        $OUT = new IO::Pty;
        $IN  = $OUT;
        print( "pty is ", $OUT->ttyname(), "\n" );
        shift(@ARGV);
        next;
    }

...
ReadMode( 'cbreak', $IN );

...
    # Input from UART
    $databus = ord( readterm() );

...
    # Output to UART
    print( $OUT chr($databus) ); $| = 1;    # Flush the output
```

I did this in the CSCvon8 `csim`, and I'll add it also to the FISC `csim`.

## Sun 24 May 22:20:03 AEST 2020

I had this **really** crazy idea. Imagine that there was a second pair
of address registers, DRhi/DRlo as well as the existing ARhi/ARlo.
Imagine that they could *increment* as well as load (like the PC).

Given the above, we could write these instructions:

### addw $DDDD, $SSSS

Add a 16-bit value from `$SSSS` to `$DDDD`. Microcode:

  0. Load IR
  1. Load ARlo, clear carry
  2. Load ARhi
  3. Load B from Mem [AR]
  4. Load DRlo
  5. Load DRhi
  6. Oreg= Mem[DR]+B, save carry
  7. Mem[DR]= Oreg, increment AR
  8. Load B from Mem [AR], increment DR
  9. Oreg= Mem[DR]+B (with saved carry)
 10. Mem[DR]= Oreg, reset uSeq counter

The instruction would be 5 bytes long and take 10 microinstructions.
If we had to use byte instructions, we'd have to do:

```
   mov b, $SSSS
   add $DDDD, b		# Zeroes the carry in microcode
   mov b, $SSSS+1
   adc $DDDD+, b	# Add with carry
```

That's 12 bytes long and `5+6+5+6=22` microinstructions: significantly
longer in time and space. Hmm. I'm liking this. We would have to
replace the two 74HCT574 SOIC AR chips with four 74LS593 DIP chips.
More space on the PCB required.
Digikey sells SN74LS593DWR SOIC-20 for $20 each. Element 14 doesn't
sell them. Mouser (X-On) in quantities of 4,000+ only.

What this would mean is that the design would have both 8-bit and
16-bit instructions. Maybe I should completely hide the A and B
registers?

We have enough spare decode outputs to make this work, I think. I'd
have to sit down and make sure it was possible. Maybe I should do
this idea as FISC2? I've forked a copy of FISC to do this.

## Tue 26 May 13:46:41 AEST 2020

The 74LS469s arrived from Utsource and they are the correct footprints
for the PCB. So essentially there is nothing stopping me from ordering
the PCB from JLCPCB. OK: I've ordered five PCBs, here we go!

## Wed 27 May 14:33:11 AEST 2020

![](Figs/debounce.gif)

I built the above circuit which came from
[www.zen22142.zen.co.uk/Circuits/Switching/debounce.htm](www.zen22142.zen.co.uk/Circuits/Switching/debounce.htm)
on a breadboard:

![](Figs/debounce_bboard.jpg)

It works. There is a wire between pins 6 and 7. That's the fuzzy blue
wire sticking up. I didn't have a 1.8M resistor so I replaced the
10nF caps on the right with 22nF caps. That should be giving me a 22ms
clock pulse. Now I need to build it on a small piece of stripboard
with the same pinouts as the oscillator. Here's the layout:

![](Figs/debounce_strip.png)

It's going to be 10 by 8 holes in dimensions. No, I can get it
down to 9 by 8 holes:

![](Figs/debounce_strip2.jpg)

The three connections between adjacent tracks can be done with three solder bridges.

## Thu 28 May 08:03:16 AEST 2020

I built and tested the debounce circuit last night:

![](Figs/debounce_made.jpg)

and I used spare resistor legs instead of solder bridges. It works, once I
put in a couple of missing wires. So now I have a single-step clock pulse
circuit. I also tried out the DS1233 reset device and it works fine. It's
very sensitive to changes on the power supply! I have two fly leads coming
out of my USB cable to two pins, and if I move them too much on the breadboard
the reset line goes low.

I've also tried out the 74LS469 up/down counter:

![](Figs/74LS469_test.jpg)

and it works as advertised. I've got ~OE wired low to see the output. On
the bottom-right, ~CBI is wired low to test the counting. The top-right
brown wire is ~LD, wired high to allow counting. I've got eight data input
bits wired (for load testing). The top-left red wire is ~UD, currently
wired low for counting up.

I'm now at the point where I'm waiting for the PCB to arrive. I've bought
a small kit with some SMD components, so I can learn some SMD soldering
skills.

## Fri 29 May 17:20:54 AEST 2020

The ["heART" SMD
kit](https://proto-pic.co.uk/product/heart-pendant-education-stem-educational-soldering-product/)
arrived today and I've just soldered it up.  I destroyed one LED in
the process, and the capacitor isn't completely flat to the board,
but the kit works. I had to wick solder away twice during the build,
but overall I found it not bad at all.

## Sun  7 Jun 19:16:05 AEST 2020

I've been working on FISC2, but the PCB boards arrived during the week.
Before we went away on Friday, I'd soldered in the UART and oscillator
sockets, the reset device and the caps. The the microsequence counter.
And ... it didn't work!!!

We got back today and I had a chance to debug it. And damn!! I'd soldered
in a 74HCT151 *instead* of a 74HCT161 for the counter. Argh. And I can't
get the '151 off the PCB.

So, moral of story: check, check, check. I'll have to order another '151
and also learn how to remove SOIC devices from a PCB. At least I have
the FISC2 components to keep going, plus four more PCBs. But it's a big
step backwards.

## Mon  8 Jun 20:31:13 AEST 2020

This afternoon I used a new PCB and rebuilt up to where I thought I'd
arrived last week. With the correct counter device, yes we are seeing
the microsequencer counting from 0 to 15 on each clock cycle. The reset
line also works and resets the counter to zero.

Next will be the PC, the instruction ROM and the decode ROM, plus the
... well, actually all the control line demuxers and the IR as well!
This will allow me to `out 'H'; out 'i'` without the ALU or registers.

## Tue  9 Jun 09:54:02 AEST 2020

I've got the *MiniPro* ROM burner out and I've found my old ROM burning
scripts. The new instruction ROM is an AT28C64B so I've changed the `iread`
and `iwrite` scripts to reflect this. I've burned an instruction ROM that has:

```
	out 'F'; out 'I'; out 'S'; out 'C'
	out ' '; out 'C'; out 'P'; out 'U'
	out '\n'
	jmp $0000
```

This doesn't need SP, AR, A, B, O, Carry or the CPU, but it does need the
Decode ROM and the control line demuxers. I'm currently erasing the Decode
ROM and I'll burn it soon.

I had problems with the Decode ROM. The MiniPro gives a chip-ID mismatch
and fails to write, but after a few reads the chip-ID mismatch goes away.
Then I did a write which failed. But I've done a subsequent read (no
mismatch) and the contents match the ROM file. So I had to assume the
Decode ROM is OK.

## Tue  9 Jun 16:30:08 AEST 2020

I've done the soldering and into the testing. The PC is counting fine.
The uSeq is bering reset fine. I can see the `out` opcode and the ASCII
characters on the data bus. However ...

The IR isn't being loaded with the `1A` value for `out`. I can see the
`1A` on the input side of the chip, but what comes out is all ones except
one bit. I can also see that the data bus seems to have lots of ones on it
just as the clock pulse goes high. I don't know what is writing to the
data bus. Looks like I'll have to do some logic analysing.

## Wed 10 Jun 11:31:25 AEST 2020

I got the logic probe yesterday in the mail. Here's a summary. It seems like
the UART is the thing putting bogus stuff on the data bus. I've checked the
wiring and it seems identical to CSCvon8.

I was going to try my DSLogic Pro, but I can't work out a way to attach the
fly leads to the pin sockets that I have. The sockets are circular. I have
some pin headers but they are square and don't fit. And the fly leads have
pin sockets which fit the pin headers. So I'm stuck.

I got most of the way through building a colour-coded 16-bit LED array
for the decode logic output, but not done yet.

## Wed 10 Jun 16:06:25 AEST 2020

I got the LED array done. The greens are too dark. I also worked out a
solution for the pin sockets. I've used another pin socket and soldered
in short pieces of breadboard wires. So I can connect the Logic Pro fly
leads to the wires that are jutting out.

I wanted to monitor the IR value but I can't. The SOIC is too small.
And the Decode ROM is too wide to get my DIP-20 test clip across it :-(
I can monitor the decode lines. For the first few microinstructions,
the `DbWr` lines stay at 0. The `DbRd` lines alternate 0, 9, 0, 9.
It seems to be loading the IR (9) and then doing a NOP immediately.
I should have monitored the `uSreset` line too, but I forgot.

I wished that DSView could group lines, so I could group all the `DbRd` lines
and see a hex value.

## Wed 10 Jun 22:04:08 AEST 2020

![](Figs/wide_test_clip.jpg)

Hah, I've found a solution for the test clip. I've removed the centre hinge
and spring. I've cut up an old pencil eraser to the right width and put
some above and below the old hinge point. Now the clip is the correct width
and I have a rubber band on the outside to squeeze it in. I haven't tried
it yet, but it's ready for tomorrow.

The only drawback is that the decode ROM output pin header is too close to
the ROM, so I can get at the IR input (now), but not all of the ROM output
pins.

What I want to know is what opcode values are being loaded by the IR. Also,
why is the microsequencer being reset every second microinstruction when
the `out` instruction should have three microinstructions.

## Thu 11 Jun 09:06:57 AEST 2020

Results so far. The IR (not always) loads with `1A` with `IRload` high
before the first clock tick. As the clock rises, `IRload` drops with
IR having the value `1A`.

First clock tick falling edge: `UARTread` falls, to tell the UART to read
from the data bus.

Second clock tick rising edge: `UARTread` rises, `uSreset` falls. Nothing
(that I'm monitoring) changes on the falling edge.

Third clock tick rising edge: The address bus is $0001 and the data bus is
$1A before the rising edge. `uSreset` and `IRload` rise on the rising edge.
The IR value stays at $1A.

However ... on the 3rd clock tick falling edge: `IRload` remains high,
I can see $1A on the data bus LEDs, but I'm seeing the IR load value $00.
I'm wondering if this means the data bus value is changing when the clock
drops. That's the only thing that I can think of.

Ok. I'm looking at the schematic now. I have the databus demux wired up
so that it only outputs a value when the clock is *low*. But that doesn't
make sense: we want the data bus to stabilise when the clock is high,
and remain stable once the clock goes low. So, I think there's no need for
the clock to go into this demux. In CSCvon8, the databus writer demux is
wired always on. OK, so I think that's my problem. So, pin 4 has to be
disconnected from the clock and wired low like pin 5. I'll need to lift
the pin up and solder it to its neighbour.

## Thu 11 Jun 13:55:33 AEST 2020

That was a pain but I did it. I cut the bottom of the leg off, then spent
ages trying to get it out and stop the pad from soldering to the top half.
Anyway, I've just run my first instructions to print:

```
    FISC CPU
```

However, the `jmp` instruction isn't being taken and it seems to go on to
`nop` land. But I'm so relieved that this works! Time to fix the schematic.
Both FISC and FISC2 schematics now fixed.

It could be that, as I haven't soldered in the AR yet, there is nothing on
the data bus to load and so the PC keeps what it already has got. Or there
could be a timing issue with the `~PCload` line.

## Thu 11 Jun 14:36:33 AEST 2020

Well, I've installed the AR chips and the effect is the same. So there must
be a timing issue on the `~PCload` line. Sometimes the jump is taken,
but sometimes not.

Ah, I think I worked out the problem. To do a jump, we need the ALU to
produce the `Zout` line. Hmm, looks at the PCB: I can't see an ALU
anywhere! That could explain why this is intermittent!

I hot wired pin hole 17 on the ALU footprint high. Now I'm seeing
`~PCload` and now it's taking the jump! Yay.

## Thu 11 Jun 16:43:15 AEST 2020

I've just burned the ALU ROM and soldered on the ALU ROM socket. Now the
fun part of trying to insert the ROM without bending any pins! Surprisingly,
this was easy, it went straight in with just one pin needing some
encouragement. And, yes, the `jmp` now works fine. I've taken a video
and put a GIF snippet of it up on Twitter.

## Fri 12 Jun 07:57:20 AEST 2020

I've soldered in A, B, Carry and O registers this morning, now trying to
run example01.s. I'm seeing "Hello world" which confirms that the A register
is working. But instead of the '!' at the end which is $10 + $11 done
with the ALU, I'm seeing 'Q' instead. That's $51 instead of $21.

I've written a new program to add A and B with 48 values. Here is what it
should do:

```
00000000  20 21 22 23 24 25 26 27  28 29 2a 2b 2c 2d 2e 2f  | !"#$%&'()*+,-./|
00000010  30 31 32 33 34 35 36 37  38 39 3a 3b 3c 3d 3e 3f  |0123456789:;<=>?|
00000020  40 41 42 43 44 45 46 47  48 49 4a 4b 4c 4d 4e 4f  |@ABCDEFGHIJKLMNO|
```

and here is what I'm seeing:

```
00000000  50 51 52 53 54 55 56 57  68 69 6a 6b 6c 6d 6e 6f  |PQRSTUVWhijklmno|
00000010  70 71 72 73 74 75 76 87  88 89 8a 8b 8c 8d 8e 8f  |pqrstuv.........|
00000020  70 71 72 73 74 85 86 87  88 89 8a 8b 8c 8d 8e 8f  |pqrst...........|
```

The low four bits are OK. I thought there might be a solder bridge somewhere,
but I see in the middle:

```
53 54 55 56 57 68 69	57 then 68
73 74 75 76 87 88 89	76 then 87
73 74 85 86 87 88 89	74 then 85
```

and that seems to indicate more of a bug in the ALU results. I might write
code to simply `out` both A and B registers to show that they are OK.

Here is what I see. The A register seems fine:

```
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
```
but the B register output is wrong:

```
b!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
  rqrstuvwxyz{|}~pqrstuvwxyz{|}~PABCTUVWXYZ[\]^_PABSTUVWXYZ[\]^_`
```

But this has to go through the ALU to get to the UART. I might now
try sending A through the ALU to do the same. I'll do a `clc` then a
`cinc` to send A through the ALU and store it back in the A register.
Then I'll output A on the UART. This produces:

```
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
```

so I have to assume that the O register is OK and it's looking
more likely to be the B register.

## Fri 12 Jun 11:00:56 AEST 2020

I wrote a program to raise each individual bit on the B register, and
monitored the ALU inputs for the B value. Looks like bit 6 is stuck high
and bits 3 and 4 are tied together.

I've checked the soldering and I did a continuity test. Bit 6 isn't
somehow connected to Vcc. Bits 3 and 4 are not bridged. There is continuity
from the B register to the ALU. I can see the correct values on the data bus
going in to the B register, but incorrect values are coming out.

Well, colour me surprised. I did a solder dewick on both sides of the
B register "just in case", and now it's working. All eight individual
bits are coming out fine! Now to try outputting B to the UART.

I've tried example03, the conditional jumps and it's all fine. Example 5,
copying B to A, works.

## Fri 12 Jun 18:17:07 AEST 2020

Next up, the RAM chip. I've installed the socket and the RAM. Here's my
test program:

```
	mov $8000, 'H'; mov a, $8000; out a
	mov $8001, 'e'; out $8001
	mov $8002, 'l'; out $8002
	mov a, $8002; out a
	mov a, 'o'; mov $8003, a; out $8003
	out '\n'; jmp $ffff
```

which should print out:

```
00000000  48 65 6c 6c 6f 0a                                 |Hello.|
```

```
00000000  ff 67 6e 6e 6f 0a                                 |.gnno.|
```

So I'll have to single step this and see what is going on.

## Fri 12 Jun 18:57:41 AEST 2020

It gets stranger. I think it must be the Carry not being cleared, as
now I see:

```
Ifmmo, not
Hello
```

The `mov` instruction clears the carry and does `A+0` to temporarily store
the byte before putting it into the RAM. That explains the up-by-one values.
However, when I preface the `mov` instructions with `clc`, I see:

```
Gdkko
```

which is now down-by-one! I can't explain that. So I should inspect the
Carry flag's value and see what's going on.

## Sat 13 Jun 09:35:08 AEST 2020

I've written the mov_word_byte to load the A register with the byte data
and write that into memory. This will eliminate the ALU from the operation.
If this works, I think I can confirm that the RAM is working. Then I can
concentrate on the ALU and the Carry flag. Just waiting the 10 minutes to
erase the Decode ROM.

OK, I'm running with the changed Decode ROM and `Hello` is being printed
out. That confirms that Memory seems to be working fine. I also dewicked
and resoldered the Carry chip to see if that will help. Now I should do
some tests. Here is one:

```
# Carry clear, prints 'A'
        clc; mov a, $20; mov b $21; add a, b; out a

# Set the carry
        mov a, $FF; mov b $10; add a, b

# Carry set, prints 'B'
        mov a, $20; mov b $21; add a, b; out a
```

and this works fine. So maybe I've fixed the Carry problem? More tests.

The first part of example 4 works:

```
        mov a, 'e'
        mov $8002, a
        mov a, $00
        mov b, $02
        mov a, $8000+b          # Access $8002
        out a
```

But the second part doesn't.

## Sun 14 Jun 09:06:06 AEST 2020

I was reading up on D flip-flop "ripple through", where the output follows input while clock is high. But
then I read that for edge-triggered D flip-flops, the new value is latched only when the clock changes, not
continuously afterwards. I think I'm going to have to do some logic analysis on the carry operation.

Here's the next test code:

```
# Clear carry, do an add with no carry
	clc; mov b, 'D'; mov a, $00; add a, b; out a
# Clear carry, do an add with a carry
	clc; mov a, $FF; add a, b; out a
	out '\n'; jmp $ffff
```

Here is what `csim` does on the second add, and I'm seeing:

```
PC 000b u1 IR 20 decode 02b040 Areg => dbus ff B 44 A+B 6943 C NOTZ ZNNEG NNNZ 
	Cout rises on clk, Cin rises on clkbar
```

and that seems to be fine!

## Sun 14 Jun 11:40:37 AEST 2020

Back to example 4 and I've worked out the problem. D'oh! I haven't soldered in the
buffers to write ADhi and ADlo to the data bus, have I?! So that's why we can't
do indexed addressing properly yet. I'll go do that.

I've soldered on the AD buffer chips and I'm seeing the `e` output for part two
of example 4. The only thing not on the board yet are the SP chips, even though
the sockets are there. So time to test all but the SP operations.

+ example01 works
+ example03 works
+ example04 works
+ example05 works
+ example06 works
+ example12 works

I can't do examples 02 or 07-10 as they depend on the stack pointer.
Example 11 gives this:

```
CEGIKKK or
BDFHJJJ instead of ABCDEDC
```

and there are lots of increments here, so I've probaby got my
microcode wrong.

So now it's time to plug in the SP chips and see what happens!

## Sun 14 Jun 12:38:55 AEST 2020

The SP chips are in. Example 02 works but ... I'm not seeing addresses $FFFF on the
address bus. I am seeing $FEFE to start with. So this probably means that the chips
start with an initial $FF value and not an initial $00 value. I'll need to create
an instruction to initialise the stack pointer's value.

## Sun 14 Jun 13:10:15 AEST 2020

I've rewritten the Decode ROM with the new `movsp` instruction. I've tried setting the
SP to $FFFF, $0000 and $0002 and I'm still seeing address $FEFE on the address bus for
the first push operation. That seems to imply that the chips are not loading their
values with the new `movsp` instruction. At least they are DIPs so I can probe them.

## Sun 14 Jun 15:54:40 AEST 2020

I just spent too long and got frustrated, then realised my problem. I've got the DSLogic
Plus conected to:

 + D0-3, Q0-3, SktOp0-1, SPloread, Clk, DbRd0-3

I couldn't work out why I was seeing the Q (output) values change when there was no
SPloread. I forgot that Q was connected to the data bus and so I was just seeing the
data bus values!

I'll take a step back for a bit. What I'll do is just some code to set SP and use its
existing value, plus a simple SP++ and SP--. I'll have to write some more microcode for this.

## Sun 14 Jun 22:36:44 AEST 2020

I've imported the `gen_ucode` script from 2FISC as it has better error detection
than the one here. I've added instructions to set the SP to a known value,
load A from the SP address, write A to the SP address, increment SP and decrement
SP. For all of these, I'm also writing the SP value out on the address bus
so that I can see it more easily. I'm erasing the Decode ROM, so another 10 minute
wait.

Argh. So... this works fine. I think now I suspect that my 16-LED display
for the address bus has a broken link which is why I'm seeing $FExx instead
of $FFxx! I'm prepared to try a JSR/RTS example.


+ example08 works
+ example09 works

Example 10: it mostly works but I get garbage on the UART for:

```
# Move B to memory and read it back
        mov b, 'l';  mov $8000, b
        mov a, $8000; out a

# Push B on the stack, get it back
        mov b, 'd'
        push b; pop a;
        out a
```

which could be the carry thing again. Example 11 is printing `CEGIKKK`
instead of `ABCDEDC`: ditto.

So, what doesn't work:

 + example 07 fails, prints junk instead of AB
 + example 10 fails, works partially
 + example 11 fails

All of these involve the ALU and some form of addition. So I've got things
narrowed down somewhat.

## Mon 15 Jun 10:39:55 AEST 2020

I've soldered in the power supply cap, so all the soldering is done. I checked
the address bus LEDs and they do seem fine. I might try accessing something
with the AR set to $FFFF to check if the LEDs are OK. If they are, and I see
$FExx with the SP, then there's something fishy with the SP. Didn't get much
sleep last night so I might pause for a while.

## Mon 15 Jun 14:23:56 AEST 2020

Feeling a bit more awake. Here's the test code to test SP, AR, PC:

```
        mov a, $00
        mov sp, $FFFF
        mov sp, a               # Put $00 at $FFFF
        mov $FFFF, a            # Ditto with AR
        jmp $FFFF
```

For SP I see $FEFF. For AR and PC I see $FFFF. So it's not the LEDs. I can
swap around the two SP chips to see if it is one of the chips.

Damn. I swapped the chips and I'm still seeing $FEFF. That must mean
that SPhi is somehow decrementing. Or, the value going into SPhi is
missing a bit. I'll put the logic analyser on it later.

## Tue 16 Jun 07:02:49 AEST 2020

Damn, damn, damn! I've finally worked it out (I hope), and it's not good news.
Let's review what we have.

![](Figs/74LS469.png)

The 74LS469 is an 8-bit register and up/down counter. The D lines read the
new value on a rising clock edge when `~LD` is low, and the register's value
is output on the Q lines when `~OE` is low.

Now the counting part. Here is the table from the datasheet:

![](Figs/74LS469_truthtable.png)

The count operation depends upon both `~UD` and the "Carry/Borrow In", `~CBI`.
When `~CBI` is high there is no counting. When `~CBI` is low:

  + the register increments when `~UD` is low, or
  + the register decrements when `~UD` is high.

There is also a  "Carry/Borrow Out" , `~CBO`. The datasheet says: two or
more 'LS469 octal up/down counters may be cascaded to provide larger counters.
So I assumed that it would be as simple as this:
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

Nope, I need "registers" for all the temporary calculations in expressions.
How about eight 4-byte memory locations to be used as registers. I'm thinking
of putting them up at the top of memory, and moving the SP down to $FFE0. This
gives me eight 32-bit registers. I'll probably go little-endian :-) And if I
see any register spills, I can always add more registers!

I think I'll also have to write an assembly optimiser to walk the generated
code and see what things can be improved.

## Fri 22 May 18:37:21 AEST 2020

My Digikey parts arrived today. I haven't opened the box yet but now I can
print out the PCB layout and check that the parts will fit.

## Sat 23 May 10:06:03 AEST 2020

It took me a while to get the layout printed to the correct scale. I had
everything set at 100%, but it turned I had to scale by 103.25%. I worked
this out by putting a known length line on the silkscreen and used that to
determine the scaling.

This morning I got out all the Digikey parts, plus the parts I already have
and the results are that everything that I have fits. I do need to order
these from Jaycar:

 + two sockets for the 74LS469s: don't exist, use pin headers.
 + maybe some more rectangular LEDs: green ZD0232, yellow ZD0234
 + pack of eight 1K resistors: RR0572
 + chisel tips for my soldering (TS1640) station: TS1644
 + a socket for the oscillator: PI6454

I even found a spare pushbutton, my 555s and my existing timer, plus a ZIF
socket and a socket for the ZIF socket! I should wait for the 74LS469s to
arrive from UTsource as these are apparently Skinny DIPs, so I might get the
wrong sockets if they turn out not to be skinny.

I just had a look at my ACWJ compiler. There's an assumption in the code
generator that each register can hold the largest type. I'll need to break
that assumption as I don't want to have to copy around four bytes at a time
just to copy a `char` or an `int`. I might have to pass in the type of each
register as well as the register numbers themselves.

## Sun 24 May 20:07:29 AEST 2020

I think it's even worse. The compiler assumes registers, but if I do, e.g.

```
  int a, b=2, c=3; a= b + c;
```

Then I should be able to do it directly on the memory location and I won't
need "in-memory registers" to hold the final `b+c` value before it's copied
to `a`. So I might have to rejig the generic code generator, too.

However, on another note I've been annoyed that `csim` doesn't let me paste
in text when running with a pseudo-tty. I just worked out a solution:

```
use IO::Pty;
use Term::ReadKey;

# By default, UART I/O goes to STDIN/OUT
my $IN  = *STDIN;
my $OUT = *STDOUT;

# Read and return one character from the terminal
sub readterm {
    my $ch, $cnt;

    while (1) {
        $cnt = sysread( $IN, $ch, 1 );

        #print("Got cnt $cnt\n");
        return ($ch) if ( $cnt == 1 );
    }
}

...
    # Open up a pty
    if ( $ARGV[0] eq "-p" ) {
        $OUT = new IO::Pty;
        $IN  = $OUT;
        print( "pty is ", $OUT->ttyname(), "\n" );
        shift(@ARGV);
        next;
    }

...
ReadMode( 'cbreak', $IN );

...
    # Input from UART
    $databus = ord( readterm() );

...
    # Output to UART
    print( $OUT chr($databus) ); $| = 1;    # Flush the output
```

I did this in the CSCvon8 `csim`, and I'll add it also to the FISC `csim`.

## Sun 24 May 22:20:03 AEST 2020

I had this **really** crazy idea. Imagine that there was a second pair
of address registers, DRhi/DRlo as well as the existing ARhi/ARlo.
Imagine that they could *increment* as well as load (like the PC).

Given the above, we could write these instructions:

### addw $DDDD, $SSSS

Add a 16-bit value from `$SSSS` to `$DDDD`. Microcode:

  0. Load IR
  1. Load ARlo, clear carry
  2. Load ARhi
  3. Load B from Mem [AR]
  4. Load DRlo
  5. Load DRhi
  6. Oreg= Mem[DR]+B, save carry
  7. Mem[DR]= Oreg, increment AR
  8. Load B from Mem [AR], increment DR
  9. Oreg= Mem[DR]+B (with saved carry)
 10. Mem[DR]= Oreg, reset uSeq counter

The instruction would be 5 bytes long and take 10 microinstructions.
If we had to use byte instructions, we'd have to do:

```
   mov b, $SSSS
   add $DDDD, b		# Zeroes the carry in microcode
   mov b, $SSSS+1
   adc $DDDD+, b	# Add with carry
```

That's 12 bytes long and `5+6+5+6=22` microinstructions: significantly
longer in time and space. Hmm. I'm liking this. We would have to
replace the two 74HCT574 SOIC AR chips with four 74LS593 DIP chips.
More space on the PCB required.
Digikey sells SN74LS593DWR SOIC-20 for $20 each. Element 14 doesn't
sell them. Mouser (X-On) in quantities of 4,000+ only.

What this would mean is that the design would have both 8-bit and
16-bit instructions. Maybe I should completely hide the A and B
registers?

We have enough spare decode outputs to make this work, I think. I'd
have to sit down and make sure it was possible. Maybe I should do
this idea as FISC2? I've forked a copy of FISC to do this.

## Tue 26 May 13:46:41 AEST 2020

The 74LS469s arrived from Utsource and they are the correct footprints
for the PCB. So essentially there is nothing stopping me from ordering
the PCB from JLCPCB. OK: I've ordered five PCBs, here we go!

## Wed 27 May 14:33:11 AEST 2020

![](Figs/debounce.gif)

I built the above circuit which came from
[www.zen22142.zen.co.uk/Circuits/Switching/debounce.htm](www.zen22142.zen.co.uk/Circuits/Switching/debounce.htm)
on a breadboard:

![](Figs/debounce_bboard.jpg)

It works. There is a wire between pins 6 and 7. That's the fuzzy blue
wire sticking up. I didn't have a 1.8M resistor so I replaced the
10nF caps on the right with 22nF caps. That should be giving me a 22ms
clock pulse. Now I need to build it on a small piece of stripboard
with the same pinouts as the oscillator. Here's the layout:

![](Figs/debounce_strip.png)

It's going to be 10 by 8 holes in dimensions. No, I can get it
down to 9 by 8 holes:

![](Figs/debounce_strip2.jpg)

The three connections between adjacent tracks can be done with three solder bridges.

## Thu 28 May 08:03:16 AEST 2020

I built and tested the debounce circuit last night:

![](Figs/debounce_made.jpg)

and I used spare resistor legs instead of solder bridges. It works, once I
put in a couple of missing wires. So now I have a single-step clock pulse
circuit. I also tried out the DS1233 reset device and it works fine. It's
very sensitive to changes on the power supply! I have two fly leads coming
out of my USB cable to two pins, and if I move them too much on the breadboard
the reset line goes low.

I've also tried out the 74LS469 up/down counter:

![](Figs/74LS469_test.jpg)

and it works as advertised. I've got ~OE wired low to see the output. On
the bottom-right, ~CBI is wired low to test the counting. The top-right
brown wire is ~LD, wired high to allow counting. I've got eight data input
bits wired (for load testing). The top-left red wire is ~UD, currently
wired low for counting up.

I'm now at the point where I'm waiting for the PCB to arrive. I've bought
a small kit with some SMD components, so I can learn some SMD soldering
skills.

## Fri 29 May 17:20:54 AEST 2020

The ["heART" SMD
kit](https://proto-pic.co.uk/product/heart-pendant-education-stem-educational-soldering-product/)
arrived today and I've just soldered it up.  I destroyed one LED in
the process, and the capacitor isn't completely flat to the board,
but the kit works. I had to wick solder away twice during the build,
but overall I found it not bad at all.

## Sun  7 Jun 19:16:05 AEST 2020

I've been working on FISC2, but the PCB boards arrived during the week.
Before we went away on Friday, I'd soldered in the UART and oscillator
sockets, the reset device and the caps. The the microsequence counter.
And ... it didn't work!!!

We got back today and I had a chance to debug it. And damn!! I'd soldered
in a 74HCT151 *instead* of a 74HCT161 for the counter. Argh. And I can't
get the '151 off the PCB.

So, moral of story: check, check, check. I'll have to order another '151
and also learn how to remove SOIC devices from a PCB. At least I have
the FISC2 components to keep going, plus four more PCBs. But it's a big
step backwards.

## Mon  8 Jun 20:31:13 AEST 2020

This afternoon I used a new PCB and rebuilt up to where I thought I'd
arrived last week. With the correct counter device, yes we are seeing
the microsequencer counting from 0 to 15 on each clock cycle. The reset
line also works and resets the counter to zero.

Next will be the PC, the instruction ROM and the decode ROM, plus the
... well, actually all the control line demuxers and the IR as well!
This will allow me to `out 'H'; out 'i'` without the ALU or registers.

## Tue  9 Jun 09:54:02 AEST 2020

I've got the *MiniPro* ROM burner out and I've found my old ROM burning
scripts. The new instruction ROM is an AT28C64B so I've changed the `iread`
and `iwrite` scripts to reflect this. I've burned an instruction ROM that has:

```
	out 'F'; out 'I'; out 'S'; out 'C'
	out ' '; out 'C'; out 'P'; out 'U'
	out '\n'
	jmp $0000
```

This doesn't need SP, AR, A, B, O, Carry or the CPU, but it does need the
Decode ROM and the control line demuxers. I'm currently erasing the Decode
ROM and I'll burn it soon.

I had problems with the Decode ROM. The MiniPro gives a chip-ID mismatch
and fails to write, but after a few reads the chip-ID mismatch goes away.
Then I did a write which failed. But I've done a subsequent read (no
mismatch) and the contents match the ROM file. So I had to assume the
Decode ROM is OK.

## Tue  9 Jun 16:30:08 AEST 2020

I've done the soldering and into the testing. The PC is counting fine.
The uSeq is bering reset fine. I can see the `out` opcode and the ASCII
characters on the data bus. However ...

The IR isn't being loaded with the `1A` value for `out`. I can see the
`1A` on the input side of the chip, but what comes out is all ones except
one bit. I can also see that the data bus seems to have lots of ones on it
just as the clock pulse goes high. I don't know what is writing to the
data bus. Looks like I'll have to do some logic analysing.

## Wed 10 Jun 11:31:25 AEST 2020

I got the logic probe yesterday in the mail. Here's a summary. It seems like
the UART is the thing putting bogus stuff on the data bus. I've checked the
wiring and it seems identical to CSCvon8.

I was going to try my DSLogic Plus, but I can't work out a way to attach the
fly leads to the pin sockets that I have. The sockets are circular. I have
some pin headers but they are square and don't fit. And the fly leads have
pin sockets which fit the pin headers. So I'm stuck.

I got most of the way through building a colour-coded 16-bit LED array
for the decode logic output, but not done yet.

## Wed 10 Jun 16:06:25 AEST 2020

I got the LED array done. The greens are too dark. I also worked out a
solution for the pin sockets. I've used another pin socket and soldered
in short pieces of breadboard wires. So I can connect the Logic Pro fly
leads to the wires that are jutting out.

I wanted to monitor the IR value but I can't. The SOIC is too small.
And the Decode ROM is too wide to get my DIP-20 test clip across it :-(
I can monitor the decode lines. For the first few microinstructions,
the `DbWr` lines stay at 0. The `DbRd` lines alternate 0, 9, 0, 9.
It seems to be loading the IR (9) and then doing a NOP immediately.
I should have monitored the `uSreset` line too, but I forgot.

I wished that DSView could group lines, so I could group all the `DbRd` lines
and see a hex value.

## Wed 10 Jun 22:04:08 AEST 2020

![](Figs/wide_test_clip.jpg)

Hah, I've found a solution for the test clip. I've removed the centre hinge
and spring. I've cut up an old pencil eraser to the right width and put
some above and below the old hinge point. Now the clip is the correct width
and I have a rubber band on the outside to squeeze it in. I haven't tried
it yet, but it's ready for tomorrow.

The only drawback is that the decode ROM output pin header is too close to
the ROM, so I can get at the IR input (now), but not all of the ROM output
pins.

What I want to know is what opcode values are being loaded by the IR. Also,
why is the microsequencer being reset every second microinstruction when
the `out` instruction should have three microinstructions.

## Thu 11 Jun 09:06:57 AEST 2020

Results so far. The IR (not always) loads with `1A` with `IRload` high
before the first clock tick. As the clock rises, `IRload` drops with
IR having the value `1A`.

First clock tick falling edge: `UARTread` falls, to tell the UART to read
from the data bus.

Second clock tick rising edge: `UARTread` rises, `uSreset` falls. Nothing
(that I'm monitoring) changes on the falling edge.

Third clock tick rising edge: The address bus is $0001 and the data bus is
$1A before the rising edge. `uSreset` and `IRload` rise on the rising edge.
The IR value stays at $1A.

However ... on the 3rd clock tick falling edge: `IRload` remains high,
I can see $1A on the data bus LEDs, but I'm seeing the IR load value $00.
I'm wondering if this means the data bus value is changing when the clock
drops. That's the only thing that I can think of.

Ok. I'm looking at the schematic now. I have the databus demux wired up
so that it only outputs a value when the clock is *low*. But that doesn't
make sense: we want the data bus to stabilise when the clock is high,
and remain stable once the clock goes low. So, I think there's no need for
the clock to go into this demux. In CSCvon8, the databus writer demux is
wired always on. OK, so I think that's my problem. So, pin 4 has to be
disconnected from the clock and wired low like pin 5. I'll need to lift
the pin up and solder it to its neighbour.

## Thu 11 Jun 13:55:33 AEST 2020

That was a pain but I did it. I cut the bottom of the leg off, then spent
ages trying to get it out and stop the pad from soldering to the top half.
Anyway, I've just run my first instructions to print:

```
    FISC CPU
```

However, the `jmp` instruction isn't being taken and it seems to go on to
`nop` land. But I'm so relieved that this works! Time to fix the schematic.
Both FISC and FISC2 schematics now fixed.

It could be that, as I haven't soldered in the AR yet, there is nothing on
the data bus to load and so the PC keeps what it already has got. Or there
could be a timing issue with the `~PCload` line.

## Thu 11 Jun 14:36:33 AEST 2020

Well, I've installed the AR chips and the effect is the same. So there must
be a timing issue on the `~PCload` line. Sometimes the jump is taken,
but sometimes not.

Ah, I think I worked out the problem. To do a jump, we need the ALU to
produce the `Zout` line. Hmm, looks at the PCB: I can't see an ALU
anywhere! That could explain why this is intermittent!

I hot wired pin hole 17 on the ALU footprint high. Now I'm seeing
`~PCload` and now it's taking the jump! Yay.

## Thu 11 Jun 16:43:15 AEST 2020

I've just burned the ALU ROM and soldered on the ALU ROM socket. Now the
fun part of trying to insert the ROM without bending any pins! Surprisingly,
this was easy, it went straight in with just one pin needing some
encouragement. And, yes, the `jmp` now works fine. I've taken a video
and put a GIF snippet of it up on Twitter.

## Fri 12 Jun 07:57:20 AEST 2020

I've soldered in A, B, Carry and O registers this morning, now trying to
run example01.s. I'm seeing "Hello world" which confirms that the A register
is working. But instead of the '!' at the end which is $10 + $11 done
with the ALU, I'm seeing 'Q' instead. That's $51 instead of $21.

I've written a new program to add A and B with 48 values. Here is what it
should do:

```
00000000  20 21 22 23 24 25 26 27  28 29 2a 2b 2c 2d 2e 2f  | !"#$%&'()*+,-./|
00000010  30 31 32 33 34 35 36 37  38 39 3a 3b 3c 3d 3e 3f  |0123456789:;<=>?|
00000020  40 41 42 43 44 45 46 47  48 49 4a 4b 4c 4d 4e 4f  |@ABCDEFGHIJKLMNO|
```

and here is what I'm seeing:

```
00000000  50 51 52 53 54 55 56 57  68 69 6a 6b 6c 6d 6e 6f  |PQRSTUVWhijklmno|
00000010  70 71 72 73 74 75 76 87  88 89 8a 8b 8c 8d 8e 8f  |pqrstuv.........|
00000020  70 71 72 73 74 85 86 87  88 89 8a 8b 8c 8d 8e 8f  |pqrst...........|
```

The low four bits are OK. I thought there might be a solder bridge somewhere,
but I see in the middle:

```
53 54 55 56 57 68 69	57 then 68
73 74 75 76 87 88 89	76 then 87
73 74 85 86 87 88 89	74 then 85
```

and that seems to indicate more of a bug in the ALU results. I might write
code to simply `out` both A and B registers to show that they are OK.

Here is what I see. The A register seems fine:

```
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
```
but the B register output is wrong:

```
b!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
  rqrstuvwxyz{|}~pqrstuvwxyz{|}~PABCTUVWXYZ[\]^_PABSTUVWXYZ[\]^_`
```

But this has to go through the ALU to get to the UART. I might now
try sending A through the ALU to do the same. I'll do a `clc` then a
`cinc` to send A through the ALU and store it back in the A register.
Then I'll output A on the UART. This produces:

```
a!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
```

so I have to assume that the O register is OK and it's looking
more likely to be the B register.

## Fri 12 Jun 11:00:56 AEST 2020

I wrote a program to raise each individual bit on the B register, and
monitored the ALU inputs for the B value. Looks like bit 6 is stuck high
and bits 3 and 4 are tied together.

I've checked the soldering and I did a continuity test. Bit 6 isn't
somehow connected to Vcc. Bits 3 and 4 are not bridged. There is continuity
from the B register to the ALU. I can see the correct values on the data bus
going in to the B register, but incorrect values are coming out.

Well, colour me surprised. I did a solder dewick on both sides of the
B register "just in case", and now it's working. All eight individual
bits are coming out fine! Now to try outputting B to the UART.

I've tried example03, the conditional jumps and it's all fine. Example 5,
copying B to A, works.

## Fri 12 Jun 18:17:07 AEST 2020

Next up, the RAM chip. I've installed the socket and the RAM. Here's my
test program:

```
	mov $8000, 'H'; mov a, $8000; out a
	mov $8001, 'e'; out $8001
	mov $8002, 'l'; out $8002
	mov a, $8002; out a
	mov a, 'o'; mov $8003, a; out $8003
	out '\n'; jmp $ffff
```

which should print out:

```
00000000  48 65 6c 6c 6f 0a                                 |Hello.|
```

```
00000000  ff 67 6e 6e 6f 0a                                 |.gnno.|
```

So I'll have to single step this and see what is going on.

## Fri 12 Jun 18:57:41 AEST 2020

It gets stranger. I think it must be the Carry not being cleared, as
now I see:

```
Ifmmo, not
Hello
```

The `mov` instruction clears the carry and does `A+0` to temporarily store
the byte before putting it into the RAM. That explains the up-by-one values.
However, when I preface the `mov` instructions with `clc`, I see:

```
Gdkko
```

which is now down-by-one! I can't explain that. So I should inspect the
Carry flag's value and see what's going on.

## Sat 13 Jun 09:35:08 AEST 2020

I've written the mov_word_byte to load the A register with the byte data
and write that into memory. This will eliminate the ALU from the operation.
If this works, I think I can confirm that the RAM is working. Then I can
concentrate on the ALU and the Carry flag. Just waiting the 10 minutes to
erase the Decode ROM.

OK, I'm running with the changed Decode ROM and `Hello` is being printed
out. That confirms that Memory seems to be working fine. I also dewicked
and resoldered the Carry chip to see if that will help. Now I should do
some tests. Here is one:

```
# Carry clear, prints 'A'
        clc; mov a, $20; mov b $21; add a, b; out a

# Set the carry
        mov a, $FF; mov b $10; add a, b

# Carry set, prints 'B'
        mov a, $20; mov b $21; add a, b; out a
```

and this works fine. So maybe I've fixed the Carry problem? More tests.

The first part of example 4 works:

```
        mov a, 'e'
        mov $8002, a
        mov a, $00
        mov b, $02
        mov a, $8000+b          # Access $8002
        out a
```

But the second part doesn't.

## Sun 14 Jun 09:06:06 AEST 2020

I was reading up on D flip-flop "ripple through", where the output follows input while clock is high. But
then I read that for edge-triggered D flip-flops, the new value is latched only when the clock changes, not
continuously afterwards. I think I'm going to have to do some logic analysis on the carry operation.

Here's the next test code:

```
# Clear carry, do an add with no carry
	clc; mov b, 'D'; mov a, $00; add a, b; out a
# Clear carry, do an add with a carry
	clc; mov a, $FF; add a, b; out a
	out '\n'; jmp $ffff
```

Here is what `csim` does on the second add, and I'm seeing:

```
PC 000b u1 IR 20 decode 02b040 Areg => dbus ff B 44 A+B 6943 C NOTZ ZNNEG NNNZ 
	Cout rises on clk, Cin rises on clkbar
```

and that seems to be fine!

## Sun 14 Jun 11:40:37 AEST 2020

Back to example 4 and I've worked out the problem. D'oh! I haven't soldered in the
buffers to write ADhi and ADlo to the data bus, have I?! So that's why we can't
do indexed addressing properly yet. I'll go do that.

I've soldered on the AD buffer chips and I'm seeing the `e` output for part two
of example 4. The only thing not on the board yet are the SP chips, even though
the sockets are there. So time to test all but the SP operations.

+ example01 works
+ example03 works
+ example04 works
+ example05 works
+ example06 works
+ example12 works

I can't do examples 02 or 07-10 as they depend on the stack pointer.
Example 11 gives this:

```
CEGIKKK or
BDFHJJJ instead of ABCDEDC
```

and there are lots of increments here, so I've probaby got my
microcode wrong.

So now it's time to plug in the SP chips and see what happens!

## Sun 14 Jun 12:38:55 AEST 2020

The SP chips are in. Example 02 works but ... I'm not seeing addresses $FFFF on the
address bus. I am seeing $FEFE to start with. So this probably means that the chips
start with an initial $FF value and not an initial $00 value. I'll need to create
an instruction to initialise the stack pointer's value.

## Sun 14 Jun 13:10:15 AEST 2020

I've rewritten the Decode ROM with the new `movsp` instruction. I've tried setting the
SP to $FFFF, $0000 and $0002 and I'm still seeing address $FEFE on the address bus for
the first push operation. That seems to imply that the chips are not loading their
values with the new `movsp` instruction. At least they are DIPs so I can probe them.

## Sun 14 Jun 15:54:40 AEST 2020

I just spent too long and got frustrated, then realised my problem. I've
got the DSLogic Plus conected to:

 + D0-3, Q0-3, SktOp0-1, SPloread, Clk, DbRd0-3

I couldn't work out why I was seeing the Q (output) values change when there was no
SPloread. I forgot that Q was connected to the data bus and so I was just seeing the
data bus values!

I'll take a step back for a bit. What I'll do is just some code to set SP and use its
existing value, plus a simple SP++ and SP--. I'll have to write some more microcode for this.

## Sun 14 Jun 22:36:44 AEST 2020

I've imported the `gen_ucode` script from 2FISC as it has better error detection
than the one here. I've added instructions to set the SP to a known value,
load A from the SP address, write A to the SP address, increment SP and decrement
SP. For all of these, I'm also writing the SP value out on the address bus
so that I can see it more easily. I'm erasing the Decode ROM, so another 10 minute
wait.

Argh. So... this works fine. I think now I suspect that my 16-LED display
for the address bus has a broken link which is why I'm seeing $FExx instead
of $FFxx! I'm prepared to try a JSR/RTS example.


+ example08 works
+ example09 works

Example 10: it mostly works but I get garbage on the UART for:

```
# Move B to memory and read it back
        mov b, 'l';  mov $8000, b
        mov a, $8000; out a

# Push B on the stack, get it back
        mov b, 'd'
        push b; pop a;
        out a
```

which could be the carry thing again. Example 11 is printing `CEGIKKK`
instead of `ABCDEDC`: ditto.

So, what doesn't work:

 + example 07 fails, prints junk instead of AB
 + example 10 fails, works partially
 + example 11 fails

All of these involve the ALU and some form of addition. So I've got things
narrowed down somewhat.

## Mon 15 Jun 10:39:55 AEST 2020

I've soldered in the power supply cap, so all the soldering is done. I checked
the address bus LEDs and they do seem fine. I might try accessing something
with the AR set to $FFFF to check if the LEDs are OK. If they are, and I see
$FExx with the SP, then there's something fishy with the SP. Didn't get much
sleep last night so I might pause for a while.

## Mon 15 Jun 14:23:56 AEST 2020

Feeling a bit more awake. Here's the test code to test SP, AR, PC:

```
        mov a, $00
        mov sp, $FFFF
        mov sp, a               # Put $00 at $FFFF
        mov $FFFF, a            # Ditto with AR
        jmp $FFFF
```

For SP I see $FEFF. For AR and PC I see $FFFF. So it's not the LEDs. I can
swap around the two SP chips to see if it is one of the chips.

Damn. I swapped the chips and I'm still seeing $FEFF. That must mean
that SPhi is somehow decrementing. Or, the value going into SPhi is
missing a bit. I'll put the logic analyser on it later.

## Tue 16 Jun 07:02:49 AEST 2020

I wrote up some details of the 74LS469 component and one of my conclusions
turned out to be very wrong. So, below is (hopefully) the correct information.
After that, I'll write about the implications for this FISC project.

![](Figs/74LS469.png)

The 74LS469 is an 8-bit register and up/down counter. The D lines read the
new value on a rising clock edge when `~LD` is low, and the register's value
is output on the Q lines when `~OE` is low.

Now the counting part. Here is the table from the datasheet:

![](Figs/74LS469_truthtable.png)

The count operation depends upon both `~UD` and the "Carry/Borrow In", `~CBI`.
When `~CBI` is high there is no counting. When `~CBI` is low:

  + the counter increments when `~UD` is low, or
  + the counter decrements when `~UD` is high.

There is also a  "Carry/Borrow Out", `~CBO`. The datasheet says: two or
more 'LS469 octal up/down counters may be cascaded to provide larger counters.
This allows us to cascade two counters as follows:

![](Figs/74LS469_casc1.png)

with the left device holding the lower 8 bits and the right device
holding the higher 8 bits.

The datasheet then goes on to say this very cryptic pair of sentences:

>The carry-out (~CBO) is TRUE (~CBO == LOW) when
>the output register (Q7 – Q0) is all HIGHs, otherwise FALSE
>(~CBO == HIGH). ... The borrow-out (~CBO) is TRUE (~CBO == LOW)
>when the output register (Q7 – Q0) is all LOWs, otherwise
>FALSE (~CBO == HIGH).

What the datasheet should have done was give this second truth table:

~CBI | ~UD  | Reg Value  | ~CBO | Comment
:---:|:----:|:----------:|:----:|------
  H  |  X   |  XXXXXXXX  |   H  | We will not inc/decrement, pass this on
  L  |  L   |  11111111  |   L  | We will increment, so should higher counter
  L  |  H   |  11111111  |   H  | We will decrement, next higher doesn't
  L  |  L   |  00000000  |   H  | We will increment, next higher doesn't
  L  |  H   |  00000000  |   L  | We will decrement, so should next counter
  L  |  X   |  All else  |   H  | We are nowhere near a carry/borrow situation

In other words, it's the *combination* of the `~CBI`, the `~UD` and
the register's value which controls the register's Carry/Borrow Out.

When the `~CBI` is high, not only will the lower counter *not* increment or
decrement, but it will tell the higher counter not to increment or
decrement (via the high `~CBO`).

When the lower counter is incrementing (`~LD` is low) and the lower counter's
value is $FF, the lower counter's `~CBO` goes low. Similarly, when the
lower counter is decrementing (`~LD` is high) and the lower counter's value
is $00, the lower counter's `~CBO` goes low. Otherwise, the lower counter's
`~CBO` stays high.

I did some breadboard testing with two cascaded '469s:

![](Figs/469_breadboard.jpg)

The small stripboard on the right is a clock pulse circuit with a white wire
output going to both devices. Both 469's have their output enabled; the
green LED shows the lower `~CBO` output. I have jumpers to manually load both
counters with a value.

The yellow wire is wired to the `~UD` on both counters, and the green wire
is the `~CBI` for the lower counter.

With `~CBI` high, the lower `~CBO` is high regardless of what counter
value or lower `~UD` I set. Even better, with `~CBI` low, I could set the counter combination
to $00F0 and then increment up to $00FF, then to $0100 and $0101 etc. Then
I could alter `~UD` and decrement back down to $00F0. Ditto for crossing
both ways around $FFFF/$0000.

Here is the way I've wired up the two '469s for the Stack pointer in FISC:

![](Figs/74LS469_casc2.png)

`StkOp1` acts as a "Hold" control line: when high, this
prevents the lower (left) counter on the left from incrementing or
decrementing. And when `StkOp1` is low, `StkOp0` controls
the direction: low for increment and high for decrement.

Now that I have two "Hold" values, I can demux the two `StkOp` lines
and use one of the four bit combinations as a `PCincr` line to increment the
Program Counter.

Thus, my CPU's truth table looks like:

 StkOp1 | StkOp0 | Purpose
:------:|:------:|:---------
   0    |    0   |  Increment the 16-bit SP
   0    |    1   |  Decrement the 16-bit SP
   1    |    0   |  Hold the SP
   1    |    1   |  Hold the SP, increment the PC

In the next section, I will explain why my design still has a problem
with the 74LS469 devices.

## Wed 17 Jun 10:40:38 AEST 2020

So here's the problem with how I've used the 74LS469. Their loads are edge
triggered by a clock signal, but they require `~LD` to be asserted low
*before* the clock signal. Or at least, it's dangerous if the `~LD` line
changes at the same time as the clock signal.

I had got used to the '574 registers which have a single edge-triggered
load line. For these, I generate a rising edge
control line when `~Clkbar` rises in the middle of the clock cycle, and this
is fine. For the 74LS469s, I did this:

![](Figs/fisc_sp_clock.png)

This is a problem. `~Clkbar` is the clock for loads and increments. But
I'm generating the `~SPLoread` line also as a rising edge control line
when `~Clkbar` rises. So now the '469 `~LD` rises concurrently with `CLK`:
very bad. There is no guarantee that `~LD` will be high by the time that
`CLK` rises. I think that this is the reason why I am trying to load $FF
into the high byte of the stack pointer but I'm seeing $FE as the output.

Unfortunately for me, I can't just alter a wire or two to fix it. What I
need to do is to generate `~LD` in the first half of the clock cycle
(when the system clock goes high), then let `~Clkbar` rise in the middle
of the clock cycle.

I can take this lesson and apply it to my FISC2 design. But for this
design, I will have to live with the fact that I can't load the stack
pointer with a new value. I should be able to increment and decrement OK,
though. I'll do some logic analysis to confirm this.

## Thu 18 Jun 12:09:11 AEST 2020

I just realised that I can copy the SPhi/SPlo values into the A register.
So I wrote some print hex code and I ran this in `csim`:

```
23		# Print out three test
AB		# values to show that
9A		# prhex works
0000		# Print SPhi/SPlo
FFFF		# Decrement SP
FFFE		# Decrement SP
FFFF		# Increment SP
0000		# Increment SP
00		# Increment SP, crash
```

Because `prhex()` is implemented as a function, the code crashes when the
stack pointer is above $0000, as that's pointing at the ROM of course.
You can't `JSR` and save the return address at a ROM location!

When I do this on the real hardware, I get different initial SP values:

```
23                                                                  
23                                                                  
AB                                                                  
9A
FEFE		# Starts at $FEFE
FEFD
FEFC
FEFD                                                                
FEFE                                                                
FEFF                                                                
FF00                                                                
End
```

but then:

```
23
AB
9A
FFFF		# Starts at $FFFF
FFFE
FFFD
FFFE
FFFF
0000
00		# Crash of course
```

I know it's crazy, but let's try to force a specific SP value with, e.g.,
`mov sp, $ABCD`. Wow, it works!

```
23
AB
9A
ABCD
ABCC
ABCB
ABCC
ABCD
ABCE
ABCF
End
```

So, perhaps I was wrong again!! I'm using a slow 555 to run this. What
I might do is use a faster clock, capture a few thousand runs and see
if it is consistent. Yes, I did 3,000 runs with a faster 555 clock and it is
consistent. I might try my 1MHz oscillator for the first time.

I can't find it, so I dug out my Bitscope Micro which has a 250kHz wave
generator. At 250kHz, the CPU loads the SP, increments and decrements fine.

I then tried my 3.57MHz oscillator and got these results when it worked
(but mostly, it just didn't work or crashed):

```
23
AB
9A
FFD6
FFD5
FFD4
FFD5
FFD6
FFD7
FFD8
End
```

It seems like the increment/decrement is working but the load isn't.
So, at high clock speeds, either:

 + the SP load does not occur if we change the `~LD` signal at the
   same time as we clock the 74LS469. Or,
 + the instruction ROM which holds the $ABCD value is too slow to
   get it to the 74LS469 devices.

Now I need an intermediate clock generator :-)

## Thu 18 Jun 14:07:44 AEST 2020

So ... lateral thinking time. I already have a pair of 74LS469s
wired up on a breadboard. I can hard wire them to count up.
If I apply the 3.57MHz clock to the low one, I get a divide by
2, 4 etc. output on the sixteen Q outputs :-) I like the irony
of using two 74LS469s to debug the operation of two other
74LS469s! Will do this later.

## Thu 18 Jun 20:53:19 AEST 2020

Firstly, the breadboard with the 3.57Mhz clock works.
Secondly, I used my DSLogic Plus to get the available
clock rates (Hz or multiple):

```
 54.61
109.22
218.45
436.98
873.78
  1.75k
  3.50k
  6.99k
 13.98k
 27.96k
 55.93k
111.86k
223.71k
446.43k
892.86k
  1.79M
  3.57M
```

That last one shows that the 74LS469 devices can increment in a cascaded
fashion at 3.57MHz, which is excellent. Hopefully tomorrow I can
use these clock rates to see how far I can push the loading
of the 74LS469s on the FISC PCB.

## Thu 18 Jun 21:12:52 AEST 2020

I just tried, and the results are very interesting. At no speed with
this new clock does it load the SP in a stable fashion. I can get a
few dozen or perhaps hundred runs, but the SP isn't loaded consistently
and sometimes it's not loaded at all.

But, going back to the SPlo wiring:

![](Figs/fisc_sp_clock.png)

That `~clkbar` signal is the normal clock signal inverted. I have a
spare DIP 74HCT04 hex inverter here. What if I run the clock through
five inverters? It will be inverted, but also be delayed compared
to the normal `~clkbar` signal. That might slow it down enough to
allow the `~LD` lines on the 74LS469s to be set before the `CLK`
arrives.

It's worth a shot. If it works, it will confirm that `~LD` must be set
well before the `CLK` arrives. And, I could "dead bug" this change :-)

## Fri 19 Jun 08:08:21 AEST 2020

I've put a 74HCT04 on the breadboard, connected it to the 3.57MHz clock
and put five inverters in series. I am getting a 30nS time delay plus
the clock inversion:

![](Figs/inv_30ns.png)

That's excellent. So now I can try and lift the pin 1s on the two 74LS469s
on the PCB and connect them to this delayed `~clkbar` signal and see what
happens.

## Sat 20 Jun 10:40:25 AEST 2020

I've added the new 74HCT04 inverter to the PCB "deadbug" style. Here is what
it looks like:

![](Figs/deadbug_inverter.jpg)

The blue line is the original `~clkbar` signal which goes to the top-left
inverter input. This goes through four inverters and comes out on the
mid-right vertical white/blue line to pin 1 of SPlo: this is the
delayed `~clkbar` signal. This is also connected to pin 1 of SPhi.
You can see that I've just bent out the pin 1s of the two 74LS469 chips.
I also put in some electrical tap for the left-hand 74LS469 pin 1 to stop
the original `~clkbar` signal accidentally interacting with the delayed
`~clkbar` signal.

![](Figs/deadbug_delay.png)

Measured with DSview, the four inverters introduce a delay of about
20nS (325.00 - 305.00 nS between the first two signals). The bottom
signal is the `~LD` signal dropping on SPhi. You can see that it
definitely arrives before the new `CLK` signal for the 74LS469.

Now for the results. Using my 555 clock circuit, say around 5kHz,
it works. The assembly is now:

```
        mov sp, $FFFF
        mov $8000, $23; jsr prhex; out '\n'
        mov $8000, $AB; jsr prhex; out '\n'
        mov $8000, $9A; jsr prhex; out '\n'

        mov sp, $ABCD
# Print out the SP as it is now
        movasphi; mov $8000, a; jsr prhex
        movasplo; mov $8000, a; jsr prhex; out '\n'
# Decrement it
# Decrement it
# Increment it
# Increment it
# Increment it
# Increment it
```

and I see:

```
23
AB
9A
ABCD
ABCC
ABCB
ABCC
ABCD
ABCE
ABCF
End
```

I let it repeat 1,100 times with the same result.
Then I moved up to my 1MHz oscillator which I found. Now I
see:

```
23
AB
9A
FFFF
FFFE
FFFD
FFFE
FFFF
0000
00	and crash
```

which I can't understand at the moment. With the 3.57MHz
oscillator, I also see:

```
23
AB
9A
FFFF
FFFE
FFFD
FFFE
FFFF
0000
00	and crash
```

OK, but we know that the `~LD` signal is arriving before the
`CLK` signal now. I'm going to have to inspect the data
bus value to see what is actually being loaded.

## Sat 20 Jun 15:30:28 AEST 2020

I attached my DSLogic Plus to the PCB and recorded the delayed `~clkbar`, the
SPhi `~LD` line and the bottom 4 bits of the data bus. I put this code into
the ROM:

```
	mov sp, $FFFF
	mov sp, $3300
	mov sp, $4400
	mov sp, $5500
	jmp $0000
```

I recorded 5mS of activity with the 3.57MHz oscillator, dumped it as a CSV
file and parsed it with a small Perl script. What I got was:

```
    SDhi loads 3
    SDhi loads 4
    SDhi loads 5
    SDhi loads f
```

two hundred times. This is strong evidence that the values are definitely
being written into SPhi. Now I need to find out if and why they are not
coming back out again.

## Sat 20 Jun 18:46:08 AEST 2020

My new test code is this:

```
        mov sp, $0F26; movasphi
        mov sp, $7389; movasphi
        mov sp, $A4BC; movasphi
        mov sp, $D51E; movasphi
        jmp $0000
```

and I'm watching the low 4 bits on the data bus when SPhi is copied to the
A register. I can't explain what's going on. Here are some captures. The
signals are:

 + clk, ~OE, clkbar (delayed), ~LD
 + d0, d1, d2, d3
 + dbwr0, dbwr1, dbwr2
 + a0, a1, a2, a3

The first is at a slow clock speed:

![](Figs/slow_clock_capture.png)

At point 1, `~LD` goes low followed by `clkbar`, and $3 (0011) is loaded
into SPhi. At point 2, `~OE` goes low when `SPwrite` is selected which
writes the value onto the address bus (which I should check).

Then at point 3, `abwr` goes to 1. `SPhiwrite` is already on (not shown)
and `ADhiwrite` goes low; this turns on the ADlo buffer. The effect is to
write $3 on the data bus. All fine.

Now let's look at a capture with the 1Mhz clock speed:

![](Figs/1MHz_capture.png)

At point (as above), we should be loading the SPhi register. This time the
value is $4 (0100). At point 2, `~OE` goes low as above. At point 3,
`~OE` goes low again and the value should be on the data bus. However,
this time we get $F on the data bus.

I noticed at point 1 that the data bus value changes a bit after `clkbar`
goes high. This is because we increment the PC mid-cycle. This increments
the values on the address bus, changes the instruction ROM output and thus
changes the data bus value to $2 (0010). I was worried that this might
be causing the SPhi register to mis-read the data bus value. So I changed
the microcode to leave the PC untouched in this microinstruction, and 
add the `PCincr` as a new microinstruction following this one.

This kept the data bus value constant for thw whole of the `~LD` clock
cycle, but at 1MHz it still didn't make a change.

So I'm a bit stumped.

The next thing I can try to do is to monitor the address bus value,
especially at point 2 when we write the SP value on to the address bus.
If the value is OK there, then the 74LS469 must be working fine and the
problem is elsewhere, e.g. the buffers allowing the address bus value on
to the data bus.

## Sun 21 Jun 20:03:03 AEST 2020

I monitored the address bus and I'm still not seeing the correct value
on the address bus when `~OE` is low. I've also written an instruction
to load SPhi directly from A across the data bus. This bypasses the
address bus in case there is something weird on the address bus. Here
is the microcode:

```
# Copy A into SPhi. I try several times
# to do this, and in different ways
67 movsphia: Awrite SPhiread
        SPwrite
        Awrite SPhiread
        SPwrite
        Awrite SPhiread
        SPwrite
        Awrite SPhiread
        SPwrite
        Awrite SPhiread SPwrite
        Awrite SPhiread SPwrite
        Awrite SPhiread SPwrite
        Awrite SPhiread SPwrite
        uSreset
```

I output the SPvalue on the address bus with `SPwrite` which
drops `~OE` low. So I try to write the A value four times
and then inspect it four times.

After that, keep `~OE` low for all four times that I try to
write A to SPhi. At 1MHz, the A value either never loads,
or it never comes back out on the address bus.

But at low frequencies (20kHz with my 555 circuit), this works.
Here's the code I'm using now which copies sixteen A values into
SPhi, gets them back and prints them out:

```
        mov a, $30; movsphia; movasphi; out a
        mov a, $31; movsphia; movasphi; out a
        mov a, $32; movsphia; movasphi; out a
        mov a, $33; movsphia; movasphi; out a
        mov a, $34; movsphia; movasphi; out a
        mov a, $35; movsphia; movasphi; out a
        mov a, $36; movsphia; movasphi; out a
        mov a, $37; movsphia; movasphi; out a
        mov a, $38; movsphia; movasphi; out a
        mov a, $39; movsphia; movasphi; out a
        mov a, $4A; movsphia; movasphi; out a
        mov a, $4B; movsphia; movasphi; out a
        mov a, $4C; movsphia; movasphi; out a
        mov a, $4D; movsphia; movasphi; out a
        mov a, $4E; movsphia; movasphi; out a
        mov a, $4F; movsphia; movasphi; out a
        out '\n'
        jmp $0000
```

and at 20kHz repeatedly prints out:

```
0123456789JKLMNO
```

But garbage at 1MHz. I've captured both runs with
DSview as files
`write_a_to_sp_1MHz.dsl` and `write_a_to_sp_20kHz.dsl`
with these lines:

 + clk, ~OE, clkbar (delayed), ~LD
 + d0, d1, d2, d3
 + dbwr0, dbwr1, dbwr2
 + a0, a1, a2, a3

So I can inspect and compare them.

## Tue 23 Jun 21:19:42 AEST 2020

I'm taking a step back. With my "cascaded 74LS469 clock" that has sixteen
clock frequencies, I can't get the SPhi register to load at all! But it
does load perfectly well with my 555 timer circuit. So, could it be the
voltage amplitude or shape of the clock signal that is causing problems?

I don't have very good analog tools here, so below is the best that I can do.
I'm using my Bitscope Micro analog scope to measure things. Oscilloscope:
20MHz bandwidth, normal, smooth, paused, wideband. CH A: 9.2V, 0V REF, 
2V/div. Timing: Post, Zoom, Auto Focus, 1uS/div, Repeat, Trace. Trigger:
High Speed, CH A, Rise, 127mV.



 + 555 oscillator: up to 25kHz, maybe a 75% duty cycle, 3.48V range. SPhi
   always loads.
 + 1MHz oscillator: measures at 1MHz, looks reasonably like a square wave,
4.82V range. SPhi doesn't load at all.
 + 3.57MHz oscillator: the scope's bandwidth is too low to see a square
   wave, but the frequency is about 3.33MHz and the apparent voltage
   range is 4.86V. SPhi doesn't load at all.
 + Cascasded 74LS469 clock: My multimeter shows only 4V between Vcc and
   ground on the 74LS469 pins. The output is a good square wave, but the
   voltage range is only 2.2V! This probably explains why I'm not seeing
   anything when I use this as the clock source.

OK, so I am now trying the waveform generator on the Bitscope Micro itself.
0V to 3.3V. And ... it's working perfectly up to 250kHz. Now I wish I had
a signal generator that went up to 5MHz.

## Wed 24 Jun 11:28:18 AEST 2020

I don't have a 5MHz signal generator and the cascasded 74LS469s don't work.
But I do have a 74HC161 4-bit counter. Just wired it up on a breadboard
and checked it with my Bitscope Micro. Voltage is good: 4.5V or better.
The frequencies measured are close enough to what they should be with
the 3.57MHz oscillator:

```
223.71k
446.43k
892.86k
  1.79M
```

So that's another four clock frequencies I can try.

## Thu 25 Jun 12:54:58 AEST 2020

None of these worked. So it seems to me that some characteristic of
the clock signal is causing problems. I've now turned my attention
to the `~LD` signal itself.

I'm using DSview, two channels (`CK` and `~LD`), 400MHz. I'm tweaking the
threshold to try and see what the levels are on the `~LD` signal
and also on the `CK` signal.

With the working 555 clock signal, I can raise the sample threshold
up to 3.6V and the `~LD` waveform looks OK. Above that, I see glitches.
I can lower the threshold all the way down to 0.2V and it's still OK.  

Now the working 250kHz Bitscope Micro clock signal.
Low threshold for `~LD` is now 0.3V, high threshold is 3.7V.

Now let's try the failing 1MHz oscillator. Remember: the rest of the CPU
is still working, but the `~LD` is failing to work.
Low threshold for `~LD` is now 0.8V, high threshold is 4.1V.

Now let's try the failing 3.57MHz oscillator.
Low threshold for `~LD` is now 0.7V, high threshold is 4.8V.

So, let's change tack and measure the clock signal itself.

555 clock: 0.2V to 3.1V.
Bitscope Micro: 1.3V to 2.7V.
1MHz oscillator: 0.1V to 4.9V.
3.57MHz oscillator: 0.1V to 4.9V.

Summary table:

```
Source     | Clk low   | Clk high  |  ~LD low  | ~LD high
           | threshold | threshold | threshold | threshold
-----------|-----------|-----------|-----------|-----------
  555      |   0.2V    |   3.1V    |    0.2V   |    3.6V 
Bitscope   |   1.3V    |   2.7V    |    0.3V   |    3.7V
1MHz Osc   |   0.1V    |   4.9V    |    0.8V   |    4.1V
3.57MHz Osc|   0.1V    |   4.9V    |    0.7V   |    4.8V
```

## Thu 25 Jun 16:21:19 AEST 2020

I went crazy and tried a 1K pulldown resistor from `~LD` to ground,
didn't make the 1MHz clock work. Sigh. An even smaller pulldown
resistor also doesn't make any difference.

So, I think for FISC, I'm going to have to give up on the idea
of a stack pointer. Damnit!

## Thu 25 Jun 22:25:20 AEST 2020

If we can't set the stack pointer's value manually, but we can increment and
decrement it, then at least I can write code to decrement it to a known value:

```
# Force the Stack Pointer to have a specific value, $FFFF

	mov b, $FF		# We compare against B
L1:	movasplo		# Get SPlo
	jeq a, b, L2		# Break out of inner loop if $FF
	dec sp			# Nop, so decrement the SP
	jmp L1
L2:	movasphi		# Get SPhi
	jeq a, b, L3		# Break out of outer loop if $FF
	dec sp			# Nop, so decrement the SP
	jmp L1
L3: ...
```

This actually works! So, I went all-in and compiled `himinsky.cl` into assembly
code, and appended the assembly code to the bottom (so that the function calls
have a stack to work on). Guess what?! ... It works!! And it works at 3.57MHz
as well :-)

Now I have a workaround for the damn stack pointer issue. I've just plugged the
USB cable into the UART three times in a row. The reset circuit brings the
system up a few hundred milliseconds later, and the damn thing quite happily
runs the Minsky sine wave each time. What a relief!

## Sat 27 Jun 21:11:07 AEST 2020

I was reading the datasheet for the 74LS469 again and this time I noticed in
one of the tables that the minimum setup time is 50nS. This is probably the
root cause of my problem. The `~LD` line isn't set 50nS before the `CLK`
arrives. Well, I can't change the design now that I've built the thing, but
I've already fixed the FISC2 design to set `~LD` at the start of the clock
cycle. With the Decode ROM delay, that still should be at least 150nS before
the clock drops mid-cycle. I'll be doing some breadboard testing and I'll
find out then.

## Sun  5 Jul 15:38:09 AEST 2020

I think I've taken the FISC CPU as far as I can go. It's been a very useful
dry-run for the ![FISC2](https://github.com/DoctorWkt/2FISC) CPU. So I've
stopped development of FISC now, and you should follow the 2FISC link for
further developments.
