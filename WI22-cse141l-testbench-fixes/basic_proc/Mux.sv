// Module Name:    Mux
// Description:    General purpose 8-bit wide 2:1 multiplexer for use in a 3BC processor.
//                    1. Used to select which register is the source/destination
//                      address in data memory operations.

module Mux (
    input Sel,                  // selector for the mux
    input [7:0]         A, B,   // inputs to the mux
    output logic [7:0]  Out );  // output of the mux

    // A if Sel==0
    // B if Sel==1
    always_comb begin
        Out = Sel ? B : A
    end
endmodule