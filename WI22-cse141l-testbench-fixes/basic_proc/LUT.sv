// Module Name:    LUT
// Description:    PC Target and data memory address lookup table for a 3BC processor
//

module LUT(
    input        [ 3:0] Index,
    output logic [ 9:0] Out
);

    always_comb begin
        // powers of 4
        case(Index)
            0:  Out = 0;  
            1:  Out = 0;  
            2:  Out = 0;  
            3:  Out = 0;  
            4:  Out = 0;  
            5:  Out = -408; // (prog1 bnzl instruction)
            6:  Out = 0;
            7:  Out = 0;
            8:  Out = 0;  
            9:  Out = 0;  
            10: Out = 0; 
            11: Out = 0; 
            12: Out = 0; 
            13: Out = 0; 
            14: Out = 0; 
            15: Out = 0; 
        endcase
    end
endmodule
