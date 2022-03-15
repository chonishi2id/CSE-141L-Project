// Module Name:    DataMem
// Description:    Data memory storage and interface for a 3BC processor.

module DataMem (
  input               Clk,
                      Reset,
                      WriteEn,
  input       [7:0]   ReadA,  // 8-bit-wide pointer to 256-deep memory
  input       [7:0]   ReadB,
  input       [7:0]   DataIn,		    // 8-bit-wide data path, also
  output logic[7:0]   DataOut);

  logic [7:0] Core[256];       // 8x256 two-dimensional array -- the memory itself
									 
  always_comb begin               // reads are combinational
    DataOut = Core[ReadB];        // yes, DataOut will always be the value at ReadB
  end                             // even during a write. This is fine, since
                                  // the output will only be used with relevant instructions
                                  
  always_ff @ (posedge Clk)		    // writes are sequential
    if(Reset) begin
      // prepare data memory for testing with data_mem_01 (i.e. test case #1, see data_mems folder)
      $readmemh("data_mem_01-initial.hex", Core);
	  end else if(WriteEn) 
      Core[ReadA] <= ReadB;
endmodule
