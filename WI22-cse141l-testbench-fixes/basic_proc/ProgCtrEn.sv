// Module Name:    ProgCtrEn 
// Description:    State bit that is set if and only if PC should be counting in a 3BC processor

module ProgCtrEn (
    input                 Start,        // signal from outside (e.g. the testbench) to start running programs
    output logic          CountEn );    // output to PC indicating whether it should be counting or not
  
    logic running;
	 
    always @(negedge Start) begin
        running <= 1;
    end

    always @(posedge Start) begin
        running <= 0;
    end

    always_comb begin
        CountEn = running;
    end
endmodule