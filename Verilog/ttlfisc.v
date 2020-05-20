// TTL version of the FISC CPU
// (c) 2020 Warren Toomey, GPL3

`default_nettype none
`include "tbhelper.v"
`include "74138.v"
`include "74139.v"
`include "74161.v"
`include "74151.v"
`include "74154.v"
`include "74240.v"
`include "74469.v"
`include "74574.v"
`include "74593.v"
`include "ram.v"
`include "rom.v"
`include "uart.v"

module ttlfisc (i_clk, reset, PCval);

  parameter AddressSize = 16;
  parameter WordSize = 8;

  input                     i_clk;      // Clock signal
  input                     reset;      // Reset signal
  output [AddressSize-1:0]  PCval;	// PC's value

  // Internal wires and busses
  wire clk_bar;				// Inverted clock signal.
  wire [WordSize-1:0]    databus;       // The value on the data bus
  wire [WordSize-1:0]    MEMresult;     // The value from memory
  wire [WordSize-1:0]    RAMresult;     // The value from RAM
  wire [WordSize-1:0]    ROMresult;     // The value from ROM
  wire [AddressSize-1:0] addressbus;    // The value on the address bus
  wire [AddressSize-1:0] controlbus;    // The values of the control lines
  wire [WordSize-1:0]    Aval;          // Output of A register
  wire [WordSize-1:0]    Bval;          // Output of B register
  wire [WordSize-1:0]    Cval;          // Output of carry register
  wire [WordSize-1:0]    Oval;          // Output of O register
  wire [WordSize-1:0]    ARhival;       // Output of AH register
  wire [WordSize-1:0]    ARloval;       // Output of AL register
  wire [AddressSize-1:0] ARval;         // Output of 16-bit AR register
  wire [WordSize-1:0]    SPhival;       // Current Stack Pointer value
  wire [WordSize-1:0]    SPloval;       // Current Stack Pointer value
  wire [AddressSize-1:0] SPval;         // Current Stack Pointer value
  wire [WordSize-1:0]    PChival;       // Current PC value
  wire [WordSize-1:0]    PCloval;       // Current PC value
  wire [WordSize-1:0]    UARTval;       // Value read from the UART

  // Busses output by the Decode Logic
  wire [2:0]		 JumpOp;	// What type of jump operation
  wire [3:0]		 ALUop;         // ALU operation
  wire [2:0]             DbusWr;        // Who is writing to the data bus
  wire [1:0]             AbusWr;        // Who is writing to the address bus
  wire [3:0]             DbusRd;        // Who is reading from the data bus
  wire [1:0]             StkOp;         // Stack operation


  // Some control lines
  wire       	uSreset;   	// Active low, reset the microsequencer
  wire       	PCincr;         // Active high, increment the PC
  wire          PCread;         // Active low, load the PC

  // Data bus read control lines
  wire          Jmpena;         // Active low,  enable a jump
  wire          ARhiread;       // Active high, read the AH register
  wire          ARloread;       // Active high, read the AL register
  wire          SPhiread;       // Active low,  load the SPhi register
  wire          SPloread;       // Active low,  load the SPlo register
  wire          Aread;          // Active high, read the A register
  wire          Bread;          // Active high, read the B register
  wire		IRread;		// Active high, read the IR register
  wire		MEMread;        // Active low,  read RAM from databus
  wire          Carryread;      // Active high, load carry from ALU
  wire          UARTread;       // Active low,  send data to UART

  // Data bus write control lines
  wire          ADhiwrite;      // Active low, put high address on data bus
  wire          ADlowrite;      // Active low, put low address on data bus
  wire          MEMwrite;       // Active low, put memory value on data bus
  wire          UARTwrite;      // Active low, put UART value on data bus
  wire          Awrite;         // Active low, put A register on data bus
  wire          Owrite;         // Active low, put O register on data bus

  // Address bus write control lines
  wire          PCwrite;        // Active low, put PC on address bus
  wire          ARwrite;        // Active low, put AR on address bus
  wire          SPwrite;        // Active low, put SP on address bus

  // Inverter: used to invert several control lines. Read alternate lines
  // to see which input becomes which output.
  ttl_74240 inverter(1'b0, 1'b0,
	i_clk,   ROMselect, dread_out[3], dread_out[4],
	    dread_out[7], dread_out[8], dread_out[9], dread_out[11],
  	clk_bar, RAMselect, ARhiread,     ARloread,
	    Aread,        Bread,        IRread,       Carryread);

  // Microsequencer
  wire uSeq_unused;
  ttl_74161 uSeq(reset, uSreset, 1'b1, 1'b1, 4'b0, i_clk, uSeq_unused, uSval);

  // Instruction Register
  ttl_74574 IR(1'b0, IRread, reset, databus, IRval);

  // Decodeindex is the address going into the Decode ROM
  wire [WordSize-1:0]	IRval;		// Output from the instruction register
  wire [3:0] 		uSval;		// Current microsequence phase
  wire [WordSize-1+4:0] Decodeindex= { IRval, uSval };

  // The Decode ROM
  rom #(.AddressSize(12), .WordSize(AddressSize), .Filename("../ucode.rom"))
        Decoder(Decodeindex, controlbus, 1'b0, 1'b0);

  // Output from the Decode ROM
  assign uSreset= controlbus[15];       // Active low, reset the microsequencer
  assign StkOp=   controlbus[14:13];    // Stack operation
  assign DbusRd=  controlbus[12:9];     // Data bus reader
  assign AbusWr=  controlbus[8:7];      // Address bus writer
  assign DbusWr=  controlbus[6:4];      // Data bus writer
  assign ALUop=   controlbus[3:0];      // ALU operation
  assign JumpOp=  IRval[2:0];           // Jump op comes from the instruction
  
  // Address bus writer demux
  /* verilator lint_off UNUSED */
  wire [3:0] awrite_out;
  /* verilator lint_on UNUSED */
  ttl_74139 #(.BLOCKS(1)) abus_writer(1'b0, AbusWr, awrite_out);
  assign PCwrite= awrite_out[0];
  assign ARwrite= awrite_out[1];
  assign SPwrite= awrite_out[2];

  // Data bus writer demux
  /* verilator lint_off UNUSED */
  wire [7:0] dwrite_out;
  /* verilator lint_on UNUSED */
  ttl_74138 dbus_writer(1'b0, 1'b0, 1'b1, DbusWr, dwrite_out);
  assign MEMwrite=  dwrite_out[0];
  assign ADhiwrite= dwrite_out[1];
  assign ADlowrite= dwrite_out[2];
  assign UARTwrite= dwrite_out[3];
  assign Awrite=    dwrite_out[4];
  assign Owrite=    dwrite_out[5];

  // Databus reader demux
  // The i_clk input is used to drop the control line halfway through the clock
  // cycle. This allows the data bus load control lines to be asserted in
  // consecutive microinstructions. Some lines are inverted by the inverter.
  /* verilator lint_off UNUSED */
  wire [15:0] dread_out;
  /* verilator lint_on UNUSED */
  ttl_74154 dbus_reader(i_clk, i_clk, DbusRd, dread_out);
  assign Jmpena= dread_out[2];
  assign SPhiread= dread_out[5];
  assign SPloread= dread_out[6];
  assign MEMread= dread_out[10];
  assign UARTread= dread_out[12];

  // Demux for PC increment
  /* verilator lint_off UNUSED */
  wire [3:0] pcincr_demux_out;
  /* verilator lint_on UNUSED */
  assign PCincr= pcincr_demux_out[3];
  ttl_74139 #(.BLOCKS(1)) pcincr_demux(1'b0, StkOp, pcincr_demux_out);

  // Address bus writer demux. XXX Fix with a component
  assign addressbus= (AbusWr==2'h1) ? ARval : 
  		     (AbusWr==2'h2) ? SPval : PCval;

  // Data bus value demux. XXX Can we get the individual values
  // to be hi-Z as needed, and assign all of them directly to
  // databus?
  assign UARTval = 8'h00;
  assign databus= (DbusWr == 3'h0) ? MEMresult :
		  (DbusWr == 3'h1) ? addressbus[15:8] :
                  (DbusWr == 3'h2) ? addressbus[7:0] :
                  (DbusWr == 3'h3) ? UARTval :
                  (DbusWr == 3'h4) ? Aval :
                  (DbusWr == 3'h5) ? Oval : 8'h00;

  // Address value demux. XXX ditto
  assign MEMresult= (ROMselect===1'b0) ? ROMresult : RAMresult;

  // Main Memory
  // ROM is mapped to the low 8K of memory, RAM is the upper 56K.
  // ROMselect, active low, selects the ROM and not the RAM.
  wire #(21, 21) ROMselect= (addressbus[15:13] == 3'b000) ? 1'b0 : 1'b1;
  wire RAMselect;

  rom #(.AddressSize(13), .Filename("../instr.rom"),
	.DELAY_RISE(150), .DELAY_FALL(150))
        ROM(addressbus[12:0], ROMresult, ROMselect, MEMwrite);

  ram #(.AddressSize(16))
        RAM(addressbus[15:0], databus, RAMselect, MEMread, MEMwrite, RAMresult);

  // Several registers; most read from the data bus
  ttl_74574 A(Awrite, Aread, reset, databus, Aval);
  ttl_74574 B(1'b0, Bread, reset, databus, Bval);
  ttl_74574 O(Owrite, clk_bar, reset, ALUresult[7:0], Oval);
  ttl_74574 AH(ARwrite, ARhiread, reset, databus, ARhival);
  ttl_74574 AL(ARwrite, ARloread, reset, databus, ARloval);
  assign ARval= { ARhival, ARloval };

  // The two PC components. We connect the carry from PClo to PChi.
  // The carry from PChi is unused. PCread is enabled when the PC jumps,
  // i.e. is readed from the address register AR.
  // The clk_bar is used to increment the PC. It's complicated.
  wire PCcarry;
  wire PCunused;
  ttl_74593 PClo(1'b1, PCwrite, clk_bar, 1'b0,
		 PCincr, PCread, reset, clk_bar,
		 1'b0, PCcarry, PCloval, addressbus[7:0]);
  ttl_74593 PChi(1'b1, PCwrite, PCcarry, 1'b0,
		 1'b0, PCread, reset, clk_bar,
		 1'b0, PCunused, PChival, addressbus[15:8]);
  assign PCval= { PChival, PCloval };

  // The stack pointer is similar to the PC in that we connect the carry
  // from SPlo to SPhi. However, it reads from the data bus. Also, we
  // use the Stkop to determine if we hold, increment or decrement
  wire SPcarry;
  wire SPunused;
  //
  // In CK, LD_bar, UD_bar, CBI_bar, OE_bar, A. Out Y, CBO_bar
  //
  ttl_74469 SPlo(clk_bar, SPloread, StkOp[0], StkOp[1],
                        SPwrite, databus, SPloval, SPcarry);
  ttl_74469 SPhi(clk_bar, SPhiread, StkOp[0], SPcarry,
                        SPwrite, databus, SPhival, SPunused);
  assign SPval= { SPhival, SPloval };

  // Carry register
  ttl_74574 Carry(1'b0, Carryread, reset, { 7'b0, ALUresult[8] }, Cval);

  // The ALU. This takes as inputs the ALUop from the decode ROM,
  // the values from the databus and B registers, and the carry in flag.
  /* verilator lint_off UNUSED */
  wire [AddressSize-1:0] ALUresult;
  /* verilator lint_on UNUSED */
  wire [20:0] ALUindex= { Cval[0], ALUop, databus, Bval };
  rom #(.AddressSize(21), .WordSize(AddressSize), .Filename("../alu.rom"))
        ALU(ALUindex, ALUresult, 1'b0, 1'b0);

  // The UART. Output the data bus value when UARTread goes low.
  uart UART(databus, UARTread);

  // The Jump logic. We take as inputs the JumpOp from the IR,
  // several active high status lines from the ALU, and two status lines
  // from the UART. In this version, the two UART lines are set low.
  wire [7:0] jumpInput= { 1'b0, 1'b0, ALUresult[14:9] };
  wire Jmpunused;
  ttl_74151 jumpLogic(Jmpena, jumpInput, JumpOp, Jmpunused, PCread);

endmodule
