// Module Name:    DataMem
// Description:    Data memory storage and interface for a 3BC processor.

module DataMem #(parameter W=8, A=8)  (
  input                 Clk,
                        Reset,
                        WriteEn,
  input       [A-1:0]   DataAddress,  // A-bit-wide pointer to 256-deep memory
  input       [W-1:0]   DataIn,		    // W-bit-wide data path, also
  output logic[W-1:0]   DataOut);

  logic [W-1:0] Core[2**A];       // 8x256 two-dimensional array -- the memory itself
									 
  always_comb                     // reads are combinational
    DataOut = Core[DataAddress];


  always_ff @ (posedge Clk)		    // writes are sequential
    // set DataMem core to all 0's initially for clean slate
    if(Reset) begin
      for(int i=0;i<256;i++)
	      Core[i] <= 0;
	  end else if(WriteEn) 
      Core[DataAddress] <= DataIn;

endmodule
