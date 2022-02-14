// Revision Date:    2020.08.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
    input     	 Start,    // start next program
				 Reset,	   // init/reset, active high
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
);

wire [ 9:0] PgmCtr,        // program counter
			PCTarg;
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] ReadA, ReadB;  // reg_file outputs
wire [ 7:0] InA, InB, 	   // ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] RegWriteValue, // data in to reg file
            MemWriteValue, // data in to data_memory
	    	MemReadValue;  // data out from data_memory
wire        MemWrite,	   // data_memory write enable
	    	RegWrEn,	   // reg_file write enable
	    	Zero,          // ALU output = 0 flag
            Jump,	   	   // to program counter: jump 
            BranchEn;	   // to program counter: branch enable
logic[15:0] CycleCt;	   // standalone; NOT PC!

// Fetch stage = Program Counter + Instruction ROM
  ProgCtr PC1 (		       // this is the program counter module
	.Reset        (Reset   ) ,  // reset to 0
	.Start        (Start   ) ,  // SystemVerilog shorthand for .grape(grape) is just .grape 
	.Clk          (Clk     ) ,  //    here, (Clk) is required in Verilog, optional in SystemVerilog
	.BranchAbsEn  (Jump    ) ,  // jump enable
	.ALU_flag	  (Zero    ) ,  // 
	.Target       (PCTarg  ) ,  // "where to?" or "how far?" during a jump or branch
	.ProgCtr      (PgmCtr  )	   // program count = index to instruction memory
  );					  

	// instruction ROM -- holds the machine code pointed to by program counter
	InstROM #(.W(9)) IR1(
		.InstAddress  (PgmCtr) 		, 
		.InstOut      (Instruction)
	);

	// Decode stage = Control Decoder + Reg_file
	// Control decoder
	Ctrl Ctrl1 (
		.Instruction  (Instruction) ,  // from instr_ROM
		.Jump         (Jump) 		,  // to PC to handle jump/branch instructions
		.BranchEn     (BranchEn)	,  // to PC
		.RegWrEn      (RegWrEn)		,  // register file write enable
		.MemWrEn      (MemWrite)	,  // data memory write enable
		.LoadInst     (LoadInst)	,  // selects memory vs ALU output as data input to reg_file
		.StoreInst    (StoreInst)	,
		.Ack          (Ack)			   // "done" flag
	);

	// reg file
	RegFile #(.W(8), .A(2)) RF1 (			  // .A(3) makes this 2**2=4 registers deep
		.Clk	   (Clk)    	     ,
		.Reset     (Reset),
		.WriteEn   (RegWrEn)    	 , 
		.RaddrA    (Instruction[4:3]),        // index of first reg  e.g. with add R1, R2, R1 is in Instruction[4:3]
		.RaddrB    (Instruction[2:1]),		  // index of second reg e.g. with add R1, R2, R2 is in Instruction[2:1]
		.Waddr     (Instruction[4:3]),		  // store result in first reg, e.g. with add R1, R2, R1 is in Instruction[4:3]
		.DataIn    (ALU_out)	 	 , 
		.DataOutA  (ReadA)		 	 , 
		.DataOutB  (ReadB)			 
	);
/* one pointer, two adjacent read accesses: 
  (sample optional approach)
	.raddrA ({Instruction[5:3],1'b0});
	.raddrB ({Instruction[5:3],1'b1});
*/
    assign InA = ReadA;						  // connect RF out to ALU in
	assign InB = ReadB;	          			  // interject switch/mux if needed/desired
// controlled by Ctrl1 -- must be high for load from data_mem; otherwise usually low
	assign RegWriteValue = LoadInst? MemReadValue : ALU_out;  // 2:1 switch into reg_file
    ALU ALU1  (
	  .InputA  (InA),
	  .InputB  (InB), 
	  .OP      (Instruction[8:6]),
	  .Out     (ALU_out),			// to be written to reg
	  .Zero	(  Zero)	            // status flag; may have others, if desired
	  );
  
	DataMem DM1(
		.DataAddress  (ReadB), 
		.WriteEn      (MemWrite), 
		.DataIn       (ReadA), 
		.DataOut      (MemReadValue), 
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