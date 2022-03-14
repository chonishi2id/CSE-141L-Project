// Description: Definitions of global constants useful for a 3BC processor.

package definitions;
    // Instruction map
    const logic [3:0]kLSH  = 4'b0000;
    const logic [3:0]kRSH  = 4'b0001;
    const logic [3:0]kAND  = 4'b0010;
    const logic [3:0]kOR   = 4'b0011;
    const logic [3:0]kLDI  = 4'b0100;
    const logic [3:0]kLDR  = 4'b0101;
    const logic [3:0]kSTR  = 4'b0110;
    const logic [3:0]kBNZR = 4'b0111;
	const logic [3:0]kGEQ  = 4'b1000;
    const logic [3:0]kEQ   = 4'b1001;
	const logic [3:0]kNEG  = 4'b1010;
    const logic [3:0]kADD  = 4'b1011;
    const logic [3:0]kADDI = 4'b1100;
	const logic [3:0]kNEQ  = 4'b1101;
    const logic [3:0]kBNZL = 4'b1110;
// enum names will appear in timing diagram
    typedef enum logic[3:0] {
        LSH, RSH, AND, OR, LDI, LDR, STR, BNZR, GEQ,
        EQ, NEG, ADD, ADDI, NEQ, BNZL } op_mne;
// note: kADD is of type logic[3:0] (4-bit binary)
//   ADD is of type enum -- equiv., but watch casting
//   see ALU.sv for how to handle this   
endpackage // definitions
