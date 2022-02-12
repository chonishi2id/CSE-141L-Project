// Design Name:    basic_proc
// Module Name:    InstFetch 
// Project Name:   CSE141L
// Description:    instruction fetch (pgm ctr) for processor
//
// Revision:  2019.01.27
//
module ProgCtr #(parameter L=10) (
  input                Reset,      // reset, init, etc. -- force PC to 0
                       Start,      // Signal to jump to next program; currently unused 
                       Clk,        // PC can change on pos. edges only
<<<<<<< HEAD
					   BranchAbs,  // jump to Target
=======
					   BranchAbsEn,  // jump to Target
>>>>>>> 788e6f0d53329dbc62561cb187fb64807a354675
					   ALU_flag,   // Sometimes you may require signals from other modules, can pass around flags if needed
  input        [L-1:0] Target,     // jump ... "how high?"
  output logic [L-1:0] ProgCtr     // the program counter register itself
  );
  
	 
  // program counter can clear to 0, increment, or jump
  always_ff @(posedge Clk)         // or just always; always_ff is a linting construct
	if(Reset)
<<<<<<< HEAD
	  ProgCtr <= 0;				       // for first program; want different value for 2nd or 3rd
	else if(BranchAbs)	               // unconditional absolute jump (branch if equal)
	  ProgCtr <= Target;			   // how would you make it unconditional and/or absolute
=======
	  ProgCtr <= 0;	
	else if(BranchAbsEn)	               // unconditional absolute jump
	  ProgCtr <= Target;			   //   how would you make it conditional and/or relative?
>>>>>>> 788e6f0d53329dbc62561cb187fb64807a354675
	else
	  ProgCtr <= ProgCtr+'b1; 	       // default increment (no need for ARM/MIPS +4 -- why?)
endmodule

