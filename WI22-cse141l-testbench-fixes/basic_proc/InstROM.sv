// Module Name:    InstRom 
// Description:    Instruction memory for a 3BC processor

module InstROM (
  input       [9:0] InstAddress,    // 10-bit addressing for instructions in case we have need for that many instructions
  output logic[8:0] InstOut);       // 9-bit instructions per project specification
	 
// Second option - read instructions from file machine_code.txt
// declare 2-dimensional array, W bits wide, 2**A words deep
  logic[8:0] inst_rom[2**10];
  always_comb InstOut = inst_rom[InstAddress];

  // Load instruction memory from external file
  initial begin
  	// NOTE: This may not work depending on your simulator
	//       e.g. Questa needs the file in path of the application .exe, it
	//       doesn't care where you project code is
	$readmemb("machine_out_prog1.hex", inst_rom);
	
	// So you are probably better off with an absolute path,
	// but you will have to change this example path when you
	// try this on your machine most likely:
	//$readmemb("/Users/matthewalanlarkins/Desktop/machine_code.txt", inst_rom);
  end 
endmodule
