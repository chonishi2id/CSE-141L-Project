// Module Name:    DataMem
// Description:    Data memory storage and interface for a 3BC processor.

module DataMem (
  input               Clk,
                      Reset,
                      WriteEn,
  input       [7:0]   DataAddress,  // 8-bit-wide pointer to 256-deep memory
  input       [7:0]   DataIn,		    // 8-bit-wide data path, also
  output logic[7:0]   DataOut);

  logic [7:0] Core[256];       // 8x256 two-dimensional array -- the memory itself
									 
  always_comb                     // reads are combinational
    DataOut = Core[DataAddress];  // yes, DataOut will always be the value at the current
                                  // DataAddress, even during a write. This is fine, since
                                  // the output will only be used with relevant instructions
                                  
  always_ff @ (posedge Clk)		    // writes are sequential
    // set DataMem core to all 0's initially (may come in handy for debugging)
    if(Reset) begin
      for(int i=0;i<256;i++)
	      Core[i] <= 0;
	  end else if(WriteEn) 
      Core[DataAddress] <= DataIn;

endmodule
