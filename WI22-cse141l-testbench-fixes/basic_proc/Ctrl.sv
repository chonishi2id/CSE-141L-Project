// Module Name:     Ctrl 
// Description:     Control signals for a 3BC processor
//                  (combinational, not clocked)

import definitions::*;

// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[8:0]          Instruction ,	    // machine code
  output logic [1:0]  RegLoadType ,	    // mem, ALU_out, or immediate written to reg_file ?
  output logic        RegWrEn     ,     // write to reg_file (common)
      	              StoreInst   ,     // mem write enable
	                    Ack               // "done w/ program"
  );

  // set for all instructions that result in writing to memory (just one, str)
  assign StoreInst = Instruction[8:5] == 4'b0110;

  // set for all the instructions that result in a reg being written
  assign RegWrEn = Instruction[8:5]==4'b0000 || Instruction[8:5]==4'b0001 ||
                   Instruction[8:5]==4'b0010 || Instruction[8:5]==4'b0011 ||
                   Instruction[8:5]==4'b0100 || Instruction[8:5]==4'b0101 ||
                   Instruction[8:5]==4'b1000 || Instruction[8:5]==4'b1001 || 
                   Instruction[8:5]==4'b1010 || Instruction[8:5]==4'b1011 || 
                   Instruction[8:5]==4'b1100 || Instruction[8:5]==4'b1101;
  
  always_comb begin
    // case to decide what wire the RegFile's DataIn selector should be
    case (Instruction[8:5])
      kLDI    : RegLoadType = 2'b00; // 00 to select immediate value
      kLDR    : RegLoadType = 2'b01; // 01 to select output from DataMem
      default : RegLoadType = 2'b10; // 10 to select ALU_out, yes this implies that ALU out will be
                                     // at DataIn for RegFile even on instructions that don't load,
                                     // but this is fine since RegFile only actually loads when the 
                                     // instruction is relevant
    endcase
  end

  // reserve instruction = 9'b111111111; for Ack
  always_comb begin 
    Ack = &Instruction;
  end
endmodule

