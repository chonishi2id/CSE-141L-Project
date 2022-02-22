// Create Date:    2018.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2021.07.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			          // includes package "definitions"
module ALU #(parameter W=8, Ops=4)(
  input        [W-1:0]   InputA,      // data inputs
                         InputB,
  input        [Ops-1:0] OP,		      // ALU opcode, part of microcode
  output logic [W-1:0]   Out,		      // data output 
  output logic           Branch         // output = zero flag	 !(Out)
  );								    
	 
  op_mne op_mnemonic;			          // type enum: used for convenient waveform viewing
	
  always_comb begin
    Out = 0;      
    Branch = 0;
    // No Op = default
    case (OP)							  
      ADD : Out = InputA + InputB;        // add 
      LSH : Out = {InputA[6:0], 1'b0};    // shift left, fill in with zeroes 
	    RSH : Out = {1'b0, InputA[7:1]};    // shift right
      AND : Out = InputA & InputB;        // bitwise AND
      OR  : Out = InputA || InputB;       // bitwise OR
      NEG : Out = ~InputA + 1;
      GEQ : Out = (InputA >= InputB);         // Greater than or Equal to
      EQ  : Out = (InputA == InputB);        // Equals to
      NEQ : Out = (InputA != InputB);         // Not Equals to
      BNZ : Branch = (InputA != 0);      //Branch not equal to zero
    endcase
  end

  always_comb
    op_mnemonic = op_mne'(OP);			  // displays operation name in waveform viewer
endmodule