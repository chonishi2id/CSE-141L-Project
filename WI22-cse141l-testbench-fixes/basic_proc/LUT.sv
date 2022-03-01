// Module Name:    LUT
// Description:    PC Target and data memory address lookup table for a 3BC processor
//

module LUT(
    input        [ 7:0] Index,
    output logic [ 9:0] Out
);

    always_comb begin
        // populate the lookup table with proper addresses when the time comes
        case(Addr)
            0: Out = -459;  // this many instructions jumped in program 2's loop (Line 477->Line 18)
            1: Out = -356;  // this many instructions jumped in program 1's loop (Line 375->Line 19)
            2: Out = -302;  // this many instructions jumped in program 3's loop (Line 350->Line 48)
            // ...
            default: Out = 1;
        endcase
    end
endmodule
