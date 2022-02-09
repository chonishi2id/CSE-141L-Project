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
					   ALU_flag,   // Sometimes you may require signals from other modules, can pass around flags if needed
=======
					        BranchAbs,  // jump to Target
							  ALU_flag,   // Sometimes you may require signals from other modules, can pass around flags if needed
>>>>>>> a09b81282c95eac4d62a57077525bd9dd9c5f2af
  input        [L-1:0] Target,     // jump ... "how high?"
  output logic [L-1:0] ProgCtr     // the program counter register itself
  );
  
	 
  // program counter can clear to 0, increment, or jump
  always_ff @(posedge Clk)	           // or just always; always_ff is a linting construct
	if(Reset)
	  ProgCtr <= 0;				       // for first program; want different value for 2nd or 3rd
<<<<<<< HEAD
	else if(BranchAbs)	               // unconditional absolute jump (branch if equal)
	  ProgCtr <= Target;			   //   how would you make it unconditional and/or absolute
=======
	else if(BranchAbs)	               // unconditional absolute jump
	  ProgCtr <= Target;			   //   how would you make it conditional and/or relative?
>>>>>>> a09b81282c95eac4d62a57077525bd9dd9c5f2af
	else
	  ProgCtr <= ProgCtr+'b1; 	       // default increment (no need for ARM/MIPS +4 -- why?)
endmodule

