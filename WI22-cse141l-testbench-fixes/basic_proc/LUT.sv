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
            0:  Out = -408;  
            1:  Out = 1;  
            2:  Out = 1;  
            3:  Out = 1;  
            4:  Out = 1;  
            5:  Out = 1; // (prog1 bnzl instruction)
            6:  Out = 1;
            7:  Out = 1;
            8:  Out = 1;  
            9:  Out = 1;  
            10: Out = 1; 
            11: Out = 1; 
            12: Out = 1; 
            13: Out = 1; 
            14: Out = 1; 
            15: Out = 1;
        endcase
    end
endmodule
