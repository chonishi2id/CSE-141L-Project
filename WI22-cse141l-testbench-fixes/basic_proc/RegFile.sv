// Create Date:    2019.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-width, any-depth reg_file: just override the params!
*/
module RegFile #(parameter W=8, A=2)(		 // W = data path width (leave at 8); A = address pointer width (only need 2 for ours because we have 4 regs)
  input                Reset    ,
                       Clk      ,
                       WriteEn  ,
  input        [A-1:0] RaddrA   ,				 // address pointers
                       RaddrB   ,
                       Waddr    ,
  input        [W-1:0] DataIn   ,
  output logic [W-1:0] DataOutA ,
                       DataOutB
    );

// W bits wide [W-1:0] and 2**2=4 registers deep 	 
logic [W-1:0] Registers[2**A];

// combinational reads 
/* can write always_comb in place of assign
    difference: assign is limited to one line of code, so
	always_comb is much more versatile     
*/
always_comb DataOutA = Registers[RaddrA];	 
always_comb DataOutB = Registers[RaddrB];	

// sequential (clocked) writes 
always_ff @ (posedge Clk) begin
  if (Reset) begin
    Registers[0] <= '0;
    Registers[1] <= '0;
    Registers[2] <= '0;
    Registers[3] <= '0;
  end else if (WriteEn) begin	           // works just like data_memory writes
    Registers[Waddr] <= DataIn;
  end
end

endmodule
