import definitions::*;			
`timescale 1ns/ 1ps

//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 000, A ADD B
* op: 100, A_AND B
* ...
* Pleaser refer to definitions.sv for support ops(make changes if necessary)
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module ALU_tb;
logic [ 7:0] INPUTA;  // data inputs
logic [ 7:0] INPUTB;
logic [ 3:0] op;      // ALU opcode, part of microcode
wire  [ 7:0] OUT;
wire Zero;
logic [ 7:0] expected;

// CONNECTION
ALU uut(
  .InputA(INPUTA),
  .InputB(INPUTB),
  .SC_in(SC_IN),
  .OP(op),
  .Out(OUT),
  .Zero(Zero)
    );

initial begin

 INPUTA = 1;
 INPUTB = 1;
 op = 4'b0000; //LSH
 test_alu_func; // void function call
 #5;


 INPUTA = 1;
 INPUTB = 1;
 op= 4'b0001; // RSH
 test_alu_func; // void function call
 #5;

 INPUTA = 1;
 INPUTB = 1;
 op = 4'b0010; //AND
 test_alu_func; // void function call
 #5;

 INPUTA = 1;
 INPUTB = 0;
 op = 4'b0011; //OR
 test_alu_func; // void function call
 #5;

 INPUTA = 3;
 INPUTB = 4;
 op = 4'b1000; //GEQ
 test_alu_func; // void function call
 #5;

 INPUTA = 2;
 INPUTB = 2;
 op = 4'b1001; //EQ
 test_alu_func; // void function call
 #5;

 INPUTA = 1;
 INPUTB = 1;
 op = 4'b1010; //NEG
 test_alu_func; // void function call
 #5;

 INPUTA = 1;
 INPUTB = 1;
 op = 4'b1011; //ADD
 test_alu_func; // void function call
 #5;

 INPUTA = 1;
 INPUTB = 3;
 op = 4'b1101; //NEQ
 test_alu_func; // void function call
 #5;


 end

 task test_alu_func;
 begin
   case (op)
  ADD : expected = INPUTA + INPUTB;  // ADD 
  LSH : expected = {INPUTA[6:0], SC_IN};  // LSH
  RSH : expected = {1'b0, INPUTA[7:1]};  // RSH
  AND : expected = INPUTA & INPUTB;     //AND
  OR  : expected = INPUTA || INPUTB;   // OR
  NEG : expected = ~INPUTA + 1; //NEG
  GEQ : expected = INPUTA >= INPUTB // GEQ
  EQ  : expected = INPUTA == INPUTB //EQ
  NEQ : expected = INPUTA != INPUTB //NEQ
   endcase
   #1; if(expected == OUT)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

 end
 endtask

endmodule