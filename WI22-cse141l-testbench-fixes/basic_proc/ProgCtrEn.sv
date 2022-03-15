// Module Name:    ProgCtrEn 
// Description:    State bit that is set if and only if PC should be counting in a 3BC processor

module ProgCtrEn (
    input                 Clk,      
                          Start,        // signal from outside (e.g. the testbench) to start running programs
    output logic          CountEn );    // output to PC indicating whether it should be counting or not
  
    logic running;
    logic start_went_low;
	 
    always @(negedge Start) begin
        start_went_low = 1;
    end

    always @(posedge Clk) begin
        if (start_went_low) running <= (Start == 0);
        else running <= 0;
    end

    always_comb begin
        CountEn = running;
    end
endmodule