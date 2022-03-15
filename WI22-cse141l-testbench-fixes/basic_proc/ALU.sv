// Create Date:    2018.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2021.07.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			          // includes package "definitions"
module ALU (
  input        [7:0]    InputA,       // data inputs
                        InputB,
  input        [3:0]    OP,		        // ALU opcode, part of microcode
  input        [2:0]    Im,           // wires containing the immediate value for I-type instructions (Instruction[2:0])
  output logic [7:0]    Out,		      // data output 
  output logic          Branch        // output = zero flag	 !(Out)
  );								    
	 
  op_mne op_mnemonic;			            // type enum: used for convenient waveform viewing
	
  always_comb begin
    Out = 0; // No Op = default
    Branch = 0;                             
    case (OP)							  
      ADD : Out = InputA + InputB;        // add two regs
      ADDI: Out = InputA + Im;            // add an immediate value to regA
      LSH : begin                         // shift left Im places, fill in with zeroes 
        case (Im)
          3'b001: Out = {InputA[6:0], 1'b0};
          3'b010: Out = {InputA[5:0], 2'b00};
          3'b011: Out = {InputA[4:0], 3'b000};
          3'b100: Out = {InputA[3:0], 4'b0000};
          3'b101: Out = {InputA[2:0], 5'b00000};
          3'b110: Out = {InputA[1:0], 6'b000000};
          3'b111: Out = {InputA[0]  , 7'b0000000};
        endcase
      end
	    RSH : begin
        case (Im)
          3'b001: Out = {1'b0, InputA[7:1]};
          3'b010: Out = {2'b00, InputA[7:2]};
          3'b011: Out = {3'b000, InputA[7:3]};
          3'b100: Out = {4'b0000, InputA[7:4]};
          3'b101: Out = {5'b00000, InputA[7:5]};
          3'b110: Out = {6'b000000, InputA[7:6]};
          3'b111: Out = {7'b0000000, InputA[7]};
        endcase
      end
      AND : Out = InputA & InputB;        // bitwise AND
      OR  : Out = InputA || InputB;       // bitwise OR
      NEG : Out = ~InputA + 1;            // 2's complement negation
      GEQ : Out = (InputA >= InputB);     // Greater than or Equal to
      EQ  : Out = (InputA == InputB);     // Equals to
      NEQ : Out = (InputA != InputB);     // Not Equals to
      BNZL : Branch = (InputA != 0);       // Branch not equal to zero
      BNZR : Branch = (InputA != 0);       // Branch not equal to zero
    endcase
  end

  always_comb
    op_mnemonic = op_mne'(OP);			  // displays operation name in waveform viewer
endmodule