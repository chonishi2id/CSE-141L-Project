// Module Name:    ProgCtr 
// Description:    Program counter (PC) for a 3BC processor

module ProgCtr (
  input                Reset,      // reset, init, etc. -- force PC to 0
                       Clk,        // PC changes on posedge clk
					             BranchEn,   // branch to Target
                       En,         // enable program counter (set if and only if a program is running)
                       Source,     // signals the source of the branch offset { 0: LUTin, 1: RegIn }
  input        [7:0]   RegIn,      // branch destination (offset from current PC)   [used with bnzr]
  input        [10:0]   LUTin,      // branch  destination (offset from current PC)  [used with bnzl]
  output logic [10:0]   ProgCtr     // the program counter register itself
  );
  
	 
  // program counter can clear to 0, increment, branch, or wait for for program start (En)
  always_ff @(posedge Clk) begin  
    if(Reset) begin // reset PC to 0 when Reset is set
      ProgCtr <= 0;	
    end else if (En) begin   // PC counts when program is running (i.e. En is set)
      // count differently depending on whether we are branching or doing normal execution
      if (BranchEn) begin       // branching
        ProgCtr <= ProgCtr + (Source ? {3'b000, RegIn} : LUTin); // branch to target
      end else                  // normal operation
        ProgCtr <= ProgCtr+'b1;   // run the next instruction
    end else begin
      ProgCtr <= ProgCtr;       // hold PC value if no program is running (i.e. En not set)
    end
  end
endmodule

