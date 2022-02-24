// Module Name:    LUT
// Description:    PC Target and data memory address lookup table for a 3BC processor
//

module LUT(
    input        [ 3:0] Index,
    output logic [ 9:0] Out
);

    always_comb begin
        // populate the lookup table with proper addresses when the time comes
        case(Addr)
            2'b00: Target = 10'h3f0; // -16, i.e., move back 16 lines of machine code
            2'b01: Target = 10'h003;
            2'b10: Target = 10'h007;
            2'b11: Target = 10'h001; // default to 1 (or PC+1 for relative)
            // ...
        endcase
    end
endmodule
