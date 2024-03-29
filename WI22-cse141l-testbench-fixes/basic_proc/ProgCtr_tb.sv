//Test bench
// Program Counter
`timescale 1ns / 1ps
module ProgCtr_tb;

bit Reset;
bit Start;
bit Clk;
bit BranchAbsEn;
bit ALU_flag;
bit [9:0] Target;
logic [9:0] ProgCtr_o;

ProgCtr uut(
    .Reset(Reset),
    .Start(Start),
    .Clk(Clk),
    .BranchAbsEn(BranchAbsEn),
    .ALU_flag(ALU_flag),
    .Target(Target),
    .ProgCtr(ProgCtr_o)
);

initial begin
    Reset = 1'b1;
    Clk = '0;
    BranchAbsEn = '0;
    ALU_flag = '0;
    Target = '0;

    #1 Clk = '1; //advance 1 time unit, latch values

    #1 Clk = '0; //advance 1 time unit, check results
    $display("Check Reset");
    assert (ProgCtr_o == 'd0);
    Reset = 1'b0; //turn reset off
	 BranchAbsEn = '1;
    Target = 10;

    #1 Clk = '1; //advance 1 time unit, check results
    
    #1 Clk = '0; //advance 1 time unit, check results
    $display("Check if PC jumps to target");
    assert (ProgCtr_o == 10);
    BranchAbsEn = '0;

    #1 Clk = '1; //advance 1 time unit, latch values

    #1 Clk = '0; //advance 1 time unit, check results
    $display("Check if PC increments by 1");
    assert (ProgCtr_o == 10 +'b1);
    
end
endmodule