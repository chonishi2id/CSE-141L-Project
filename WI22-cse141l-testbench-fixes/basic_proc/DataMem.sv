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
    // set DataMem core to all 0's initially (may come in handy for debugging)
    if(Reset) begin
      for(int i=0;i<256;i++) begin
	      Core[i] <= 0;
      end
      // prepare data memory for testing with data_mem_01
      // prog 1 input
      Core[0]  = 'h52;
      Core[1]  = 'h03;
      Core[2]  = 'hE6;
      Core[3]  = 'h05;
      Core[4]  = 'h7B;
      Core[5]  = 'h01;
      Core[6]  = 'h34;
      Core[7]  = 'h06;
      Core[8]  = 'hC1;
      Core[9]  = 'h06;
      Core[10] = 'h81;
      Core[11] = 'h04;
      Core[12] = 'hA1;
      Core[13] = 'h03;
      Core[14] = 'h6A;
      Core[15] = 'h02;
      Core[16] = 'h14;
      Core[17] = 'h05;
      Core[18] = 'h05;
      Core[19] = 'h07;
      Core[20] = 'hA3;
      Core[21] = 'h06;
      Core[22] = 'hC8;
      Core[23] = 'h00;
      Core[24] = 'hCC;
      Core[25] = 'h00;
      Core[26] = 'h20;
      Core[27] = 'h02;
      Core[28] = 'hE9;
      Core[29] = 'h01;

      // prog 2 input
      Core[64] = 'h4D;
      Core[65] = 'hA4;
      Core[66] = 'h57;
      Core[67] = 'hC7;
      Core[68] = 'hEF;
      Core[69] = 'hA2;
      Core[70] = 'h56;
      Core[71] = 'hF3;
      Core[72] = 'hD3;
      Core[73] = 'h1E;
      Core[74] = 'hF8;
      Core[75] = 'h69;
      Core[76] = 'h6C;
      Core[77] = 'hBD;
      Core[78] = 'h97;
      Core[79] = 'h6A;
      Core[80] = 'hC5;
      Core[81] = 'h0D;
      Core[82] = 'h2F;
      Core[83] = 'h95;
      Core[84] = 'h63;
      Core[85] = 'hC6;
      Core[86] = 'h1C;
      Core[87] = 'h28;
      Core[88] = 'h10;
      Core[89] = 'h09;
      Core[90] = 'h09;
      Core[91] = 'h35;
      Core[92] = 'hBD;
      Core[93] = 'h3B;
      
	  end else if(WriteEn) 
      Core[ReadA] <= ReadB;

endmodule
