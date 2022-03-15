// Module Name:    InstRom 
// Description:    Instruction memory for a 3BC processor

module InstROM (
  input       [9:0] InstAddress,    // 10-bit addressing for instructions in case we have need for that many instructions
  output logic[8:0] InstOut);       // 9-bit instructions per project specification
	 
// read instructions from file machine_code.txt
// declare 2-dimensional array, 10 bits wide, 2^10 words deep
  logic[8:0] inst_rom[2**10];
  always_comb InstOut = inst_rom[InstAddress];

  // Load instruction memory from external file
  initial begin
	$readmemb("machine_out_prog1.hex", inst_rom);
      // could also use absolute path 
	//$readmemb("/Users/matthewalanlarkins/Desktop/machine_code.txt", inst_rom);
  end 
endmodule
