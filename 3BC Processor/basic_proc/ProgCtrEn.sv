// Module Name:    ProgCtrEn 
// Description:    State bit that is set if and only if PC should be counting in a 3BC processor

module ProgCtrEn (
    input                 Clk,      
                          Start,        // signal from outside (e.g. the testbench) to start running programs
    output logic          CountEn );    // output to PC indicating whether it should be counting or not
  
    logic running;
    logic start_went_low;
    logic clock_started;
	 
    always @(negedge Start) begin
        if (clock_started == 1) start_went_low <= 1;
    end

    always @(posedge Clk) begin
        clock_started <= 1;
        if (start_went_low) running <= (Start == 0);
        else running <= 0;
    end

    always_comb begin
        CountEn = running;
    end
endmodule