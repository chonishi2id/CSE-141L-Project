// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	  // machine code
  output logic Jump     ,
               BranchEn ,
	             RegWrEn  ,	    // write to reg_file (common)
	             MemWrEn  ,	    // write to mem (store only)
	             LoadInst	,	    // mem or ALU to reg_file ?
      	       StoreInst,     // mem write enable
	             Ack      ,		  // "done w/ program"
  output logic [1:0] TargSel  // Select signal for LUT
  );

  assign MemWrEn = Instruction[8:6]==3'b110;	 //111  110
  assign StoreInst = Instruction[8:6]==3'b110;  // calls out store specially

  assign RegWrEn = Instruction[8:5]==4'b0000 ||
                   Instruction[8:5]==4'b0001 ||
                   Instruction[8:5]==4'b0010 ||
                   Instruction[8:5]==4'b0011 ||
                   Instruction[8:5]==4'b0100 ||
                   Instruction[8:5]==4'b0101 ||
                   Instruction[8:5]==4'b0110 ||
                   Instruction[8:5]==4'b1000 ||
                   Instruction[8:5]==4'b1001 ||
                   Instruction[8:5]==4'b1010 ||
                   Instruction[8:5]==4'b1011 ||
                   Instruction[8:5]==4'b1100 ||
                   Instruction[8:5]==4'b1101;   // all the instructions that result in a reg being written
  
  assign LoadInst = Instruction[8:6] == 3'b011;
  // reserve instruction = 9'b111111111; for Ack

  // jump on right shift that generates a zero
  // equiv to simply: assign Jump = Instrucxtion[2:0] == kRSH;
  always_comb
    if(Instruction[2:0] ==  kRSH)
      Jump = 1;
    else
      Jump = 0;

  // branch every time instruction = 9'b?????1111;
  assign BranchEn = &Instruction[3:0];

  // route data memory --> reg_file for loads
  //   whenever instruction = 9'b110??????; 
  assign TargSel  = Instruction[3:2];
  assign Ack = &Instruction;
endmodule

