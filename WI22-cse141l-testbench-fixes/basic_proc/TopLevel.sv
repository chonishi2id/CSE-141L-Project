// Module Name:    	TopLevel 
// Description:		Top level connections for a 3BC processor.

module TopLevel(		   // you will have the same 3 ports
    input     	 Start,    // start next program
				 Reset,	   // init/reset, active high
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
);

wire [ 9:0] PgmCtr,        		// program counter
			LUTOut;				// output of LUT, either PC branch offset or Data Memory address
wire [ 8:0] Instruction;   		// our 9-bit opcode
wire [ 7:0] ReadA, ReadB, R3;  	// reg_file outputs
wire [ 7:0] InA, InB, 	   		// ALU operand inputs
            ALU_out;       		// ALU result
wire [ 7:0] RegWriteValue, 		// data in to reg file
            MemWriteValue, 		// data in to data_memory
	    	MemReadValue;  		// data out from data_memory
wire [1:0]	RegLoadType;		// whether value to load into reg is from DataMem, ALU, or is an immed. value
wire        StoreInst,	   		// data_memory write enable (only need to write when instruction is str)
	    	RegWrEn,	   		// reg_file write enable
	    	Zero,          		// ALU output = 0 flag
            BranchEn,	   		// to program counter: branch enable
			PC_en,				// set when program is running (enables program counter)
			AddrSel;			// indicates (selects) which register contains the source/destination
								// address in data memory operations
logic[15:0] CycleCt;	   		// standalone; NOT PC!

	// lookup table to get 10-bit output PC branch targets and data memory addresses
	LUT L2 (
		.Index(ReadA),
		.Out(LUTOut)
	);

	// multiplexer for selecting whether DataIn to RegFile is the immediate value in
	// Instruction[2:0] or the value of another register.
	Mux M1 (
		.A		(MemReadValue),						// load from data memory
		.B		( {5'b00000, Instruction[2:0] } ),	// load immediate value in Instruction[2:0]
		.C		(ALU_out),							// load from ALU
		.Sel	(RegLoadType),						// determines load from ALU, data memory, or immediate
		.Out	(RegWriteValue)						// either A, B, or C depending on Sel
	);

	ProgCtrEn PC_EN (
		.Clk(Clk),
		.Start(Start),
		.CountEn(PC_en)
	);

	// Fetch stage consists of Program Counter and Instruction ROM
	ProgCtr PC (		       // this is the program counter module
		.Reset        (Reset   ) ,  // reset to 0
		.Clk          (Clk     ) , 
		.BranchEn  	  (BranchEn) ,  // tell PC to branch to offset in Target
		.Offset       (LUTOut  ) ,  // "how far?" during a jump or branch
		.ProgCtr      (PgmCtr  ) ,	// program count = index to instruction memory
		.En			  (PC_en)
	);					  

	// instruction ROM -- holds the machine code pointed to by program counter
	InstROM IR(
		.InstAddress  (PgmCtr) 		, 
		.InstOut      (Instruction)
	);

	// Decode stage consists of Control Decoder and Register File
	// Control decoder
	Ctrl CTRL (
		.Instruction  (Instruction) ,  // from instr_ROM
		.RegWrEn      (RegWrEn)		,  // register file write enable
		.RegLoadType  (RegLoadType)	,  // encode to indicate load from ALU, data memory, or immediate
		.StoreInst	  (StoreInst)	,  // set if the current instruction stores a value to data memory	
		.Ack          (Ack)			   // "done" flag
	);

	// register file
	RegFile RF (
		.Reset     (Reset)			 ,
		.Clk	   (Clk)    	     ,
		.WriteEn   (RegWrEn)    	 , 
		.RaddrA    (Instruction[4:3]),        // index of first reg  e.g. with add R1, R2, R1 is in Instruction[4:3]
		.RaddrB    (Instruction[2:1]),		  // index of second reg e.g. with add R1, R2, R2 is in Instruction[2:1]
		.Waddr     (Instruction[4:3]),		  // store result in first reg, e.g. with add R1, R2, R1 is in Instruction[4:3]
		.DataIn    (RegWriteValue)	 , 
		.DataOutA  (ReadA)		 	 , 
		.DataOutB  (ReadB)
	);

    assign InA = ReadA;						  // connect RF out to ALU in
	assign InB = ReadB;	          			  // interject switch/mux if needed/desired

	// ALU
    ALU ALU  (
	  .InputA  (InA),				// ALU input
	  .InputB  (InB), 				// ALU input
	  .OP      (Instruction[8:5]),	// opcode of the current instruction
	  .Im	   (Instruction[2:0]),	// immediate value for I-type instructions
	  .Out     (ALU_out),			// to be written to reg
	  .Branch  (BranchEn)    		// set when instruction is a bnz instruction and InputA != 0
	  );
  
	// Data Memory
	DataMem DM (
		.DataAddress  (LUTOut), 		// selected by mux M1 (either loading or storing)
		.WriteEn      (StoreInst), 		// write to DataAddress if we are StoreInst set (i.e. current instruction is str)
		.DataIn       (ReadB),			// data to write is the second register (DataOutB) in the instruction (see str in ISA spec)
		.DataOut      (MemReadValue), 	// output data read from data memory
		.Clk 		  (Clk),
		.Reset		  (Reset)
	);
	
/* count number of instructions executed
      not part of main design, potentially useful
      This one halts when Ack is high  
*/
always_ff @(posedge Clk)
  if (Reset)	   // if(start)
  	CycleCt <= 0;
  else if(Ack == 0)   // if(!halt)
  	CycleCt <= CycleCt+16'b1;

endmodule