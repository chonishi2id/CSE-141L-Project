// Module Name:    Mux
// Description:    General purpose 8-bit wide 3 input multiplexer for use in a 3BC processor.
//                    1. Used to select whether data to write to RegFile is output of data memory,
//                       output of ALU, or the immediate value encoded in the current instruction.
module Mux (
    input [1:0]         Sel,        // selector for the mux
    input [7:0]         A, B, C     // inputs to the mux
    output logic [7:0]  Out );      // output of the mux

    // A if Sel==0
    // B if Sel==1
    // C if Sel==2
    // 0 if Sel==3 (will never occur)
    always_comb begin
        case(Sel)
            2'b00   : Out = A;
            2'b01   : Out = B;
            1'b10   : Out = C;
            default : Out = 0;
        endcase
    end
endmodule