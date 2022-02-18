// Module Name:     Ctrl 
// Description:     Control signals for a 3BC processor
//                  (combinational, not clocked)

import definitions::*;

// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	  // machine code
  output logic RegWrEn  ,	    // write to reg_file (common)
	             MemWrEn  ,	    // write to mem (store only)
	             LoadInst	,	    // mem or ALU to reg_file ?
      	       StoreInst,     // mem write enable
	             Ack            // "done w/ program"
  );

  // set for all instructions that result in writing to memory
  assign MemWrEn = Instruction[8:6]==3'b110;	 //111  110
  
  assign StoreInst = Instruction[8:6]==3'b110;  // calls out store specially

  // set for all the instructions that result in a reg being written
  assign RegWrEn = Instruction[8:5]==4'b0000 || Instruction[8:5]==4'b0001 ||
                   Instruction[8:5]==4'b0010 || Instruction[8:5]==4'b0011 ||
                   Instruction[8:5]==4'b0100 || Instruction[8:5]==4'b0101 ||
                   Instruction[8:5]==4'b0110 || Instruction[8:5]==4'b1000 ||
                   Instruction[8:5]==4'b1001 || Instruction[8:5]==4'b1010 ||
                   Instruction[8:5]==4'b1011 || Instruction[8:5]==4'b1100 ||
                   Instruction[8:5]==4'b1101;  
  
  always_comb begin
    LoadInst = Instruction[8:6] == 3'b011;
  end

  always_comb begin
    if(Instruction[2:0] ==  kRSH)
      Jump = 1;
    else
      Jump = 0;
  end

  // reserve instruction = 9'b111111111; for Ack
  always_comb begin 
    Ack = &Instruction;
  end
endmodule

