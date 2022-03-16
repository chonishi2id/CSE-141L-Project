// Module Name:    InstRom 
// Description:    Instruction memory for a 3BC processor

module InstROM (
  input       [9:0] InstAddress,    // 10-bit addressing for instructions in case we have need for that many instructions
  output logic[8:0] InstOut);       // 9-bit instructions per project specification
	 
  logic[8:0] inst_rom[2**10];
  always_comb InstOut = inst_rom[InstAddress];

  // Load instruction memory from external file
  initial begin
	$readmemb("C:\\Users\\Matthew\\Desktop\\CSE-141L-Project\\WI22-cse141l-testbench-fixes\\basic_proc\\simulation\\machine_out_prog1_1.hex", inst_rom);
  end 
endmodule
