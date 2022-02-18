// Module Name:    ProgCtr 
// Description:    Program counter (PC) for a 3BC processor

module ProgCtr #(parameter L=10) (
  input                Reset,      // reset, init, etc. -- force PC to 0
                       Clk,        // PC changes on posedge clk
					             BranchEn,   // branch to Target
                       En,         // enable program counter (set if and only if a program is running)
  input        [L-1:0] Target,     // branch destination (absolute address, not offset)
  output logic [L-1:0] ProgCtr     // the program counter register itself
  );
  
	 
  // program counter can clear to 0, increment, branch, or wait for for program start (En)
  always_ff @(posedge Clk) begin        // or just always; always_ff is a linting construct 
    if(Reset) begin // reset PC to 0 when Reset is set
      ProgCtr <= 0;	
    end
    if (En) begin   // PC counts when program is running (i.e. En is set)
      // count differently depending on whether we are branching or doing normal execution
      if (BranchEn) begin       // branching
        ProgCtr <= Target;        // branch to target
      end else                  // normal operation
        ProgCtr <= ProgCtr+'b1;   // run the next instruction
    end else begin
      ProgCtr <= ProgCtr;       // hold PC value if no program is running (i.e. En not set)
    end
  end
endmodule

