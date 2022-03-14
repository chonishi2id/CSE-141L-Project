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
            0: Out = -65536;  
            1: Out = ;  
            2: Out = -4096;  
            3: Out = ;  
            4: Out = -256;  
            5: Out = -64;
            6: Out = -16;
            7: Out = -4;
            8: Out = 4;  
            9: Out = 16;  
            10: Out = 64; 
            11: Out = 256; 
            12: Out = 1024; 
            13: Out = 4096; 
            14: Out = 960; 
            15: Out = 65536; 
        endcase

        // say we have these 6 offsets
        Cluster 1:
        // 18   -> 8 nops to 26
        // 19   -> 7 nops to 26
        // 25   -> 1 nop to 26
        // 26   -> in LUT

        Cluster 2:
        // 96   -> 8 nops to get to 104
        // 104  -> in LUT
    end
endmodule
