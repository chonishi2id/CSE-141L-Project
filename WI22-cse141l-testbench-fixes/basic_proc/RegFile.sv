// Module Name:    RegFile
// Description:    Register file for a 3BC processor

module RegFile (		  
  input                Reset    ,
                       Clk      ,
                       WriteEn  ,
  input        [1:0]   RaddrA   ,				 // 2-bit wide address pointers for the 4 regs in a 3BC processor
                       RaddrB   ,
                       Waddr    ,
  input        [7:0]   DataIn   ,        // 8-bit wide data in a 3BC processor
  output logic [7:0]   DataOutA ,
                       DataOutB
    );

logic [7:0] Registers[4];

// combinational reads 
always_comb begin 
  DataOutA = Registers[RaddrA];	 
  DataOutB = Registers[RaddrB];	
end

// sequential writes 
always_ff @ (posedge Clk) begin
  // when WriteEn set, write input data (DataIn) to the reg at write address (Waddr)
  if (WriteEn) begin	           
    Registers[Waddr] <= DataIn; 
  end
end

endmodule
