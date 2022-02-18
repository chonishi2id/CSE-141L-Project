// Module Name:    	TopLevel 
// Description:		Top level connections for a 3BC processor.

module TopLevel(		   // you will have the same 3 ports
    input     	 Start,    // start next program
				 Reset,	   // init/reset, active high
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
);

wire [ 9:0] PgmCtr,        		// program counter
			PCTarg;
wire [ 8:0] Instruction;   		// our 9-bit opcode
wire [ 7:0] ReadA, ReadB, R3;  	// reg_file outputs
wire [ 7:0] InA, InB, 	   		// ALU operand inputs
            ALU_out;       		// ALU result
wire [ 7:0] RegWriteValue, 		// data in to reg file
            MemWriteValue, 		// data in to data_memory
			MemAddr,			// data memory address to write/read to/from
	    	MemReadValue;  		// data out from data_memory
wire        StoreInst,	   		// data_memory write enable (only need to write when instruction is str)
	    	RegWrEn,	   		// reg_file write enable
	    	Zero,          		// ALU output = 0 flag
            BranchEn;	   		// to program counter: branch enable
			PC_en;				// set when program is running (enables program counter)
			AddrSel;			// indicates (selects) which register contains the source/destination
								// address in data memory operations
logic[15:0] CycleCt;	   		// standalone; NOT PC!


	// multiplexer for selecting which register is the source/destination address in 
	// data memory operations.
	Mux M1 (
		.A(ReadA),
		.B(ReadB),
		.Sel(AddrSel),
		.Out(MemAddr)
	);

	ProgCtrEn PC_EN (
		.Start(Start),
		.CountEn(PC_en)
	);

	// Fetch stage = Program Counter + Instruction ROM
	ProgCtr PC (		       // this is the program counter module
		.Reset        (Reset   ) ,  // reset to 0
		.Start        (Start   ) ,  // start signal
		.Clk          (Clk     ) , 
		.BranchEn  	  (BranchEn) ,  // tell PC to branch to address in Target
		.Target       (PCTarg  ) ,  // "where to?" during a jump or branch
		.ProgCtr      (PgmCtr  ) ,	// program count = index to instruction memory
		.En			  (PC_en)
	);					  

	// instruction ROM -- holds the machine code pointed to by program counter
	InstROM #(.W(9)) IR(
		.InstAddress  (PgmCtr) 		, 
		.InstOut      (Instruction)
	);

	// Decode stage = Control Decoder + Reg_file
	// Control decoder
	Ctrl CTRL (
		.TargSel
		.Instruction  (Instruction) ,  // from instr_ROM
		.RegWrEn      (RegWrEn)		,  // register file write enable
		.LoadInst     (LoadInst)	,  // selects memory vs ALU output as data input to reg_file
		.StoreInst    (StoreInst)	,  // set when the current instruction is str
		.Ack          (Ack)			,  // "done" flag
		.AddrSel	  (AddrSel)		   // selects which regfile output contains source/dest address
									   // for data memory operations
	);

	// reg file
	RegFile #(.W(8), .A(2)) RF (			  // .A(3) makes this 2**2=4 registers deep
		.Clk	   (Clk)    	     ,
		.Reset     (Reset),
		.WriteEn   (RegWrEn)    	 , 
		.RaddrA    (Instruction[4:3]),        // index of first reg  e.g. with add R1, R2, R1 is in Instruction[4:3]
		.RaddrB    (Instruction[2:1]),		  // index of second reg e.g. with add R1, R2, R2 is in Instruction[2:1]
		.Waddr     (Instruction[4:3]),		  // store result in first reg, e.g. with add R1, R2, R1 is in Instruction[4:3]
		.DataIn    (RegWriteValue)	 	 , 
		.DataOutA  (ReadA)		 	 , 
		.DataOutB  (ReadB)			 ,
		.R3		   (R3)	 
	);
/* one pointer, two adjacent read accesses: 
  (sample optional approach)
	.raddrA ({Instruction[5:3],1'b0});
	.raddrB ({Instruction[5:3],1'b1});
*/
    assign InA = ReadA;						  // connect RF out to ALU in
	assign InB = ReadB;	          			  // interject switch/mux if needed/desired

	
	// switch to decide what value is being written to reg (function of 
	// whether opcode is load, loadi, or otherwise)
	always_comb begin
		if LoadInst begin 								// writing from data_mem into reg if set
			RegWriteValue = MemReadValue;					// data memory output
		end else if Instruction[8:5] == 4'b0100 begin	// writing immediate value (opcode for loadi)
			RegWriteValue = Instruction[2:0];				// immediate value
		end else begin									// writing ALU output to reg otherwise
			RegWriteValue = ALU_out;						// alu output
		end
	end

    ALU ALU  (
	  .InputA  (InA),
	  .InputB  (InB), 
	  .OP      (Instruction[8:6]),
	  .Out     (ALU_out),			// to be written to reg
	  .Zero	   (Zero)				// set when result of ALU is 0...used to decide whether to branch      
	  );
  
	DataMem DM (
		.DataAddress  (MemAddr), 		// selected by mux M1 (either loading or storing)
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