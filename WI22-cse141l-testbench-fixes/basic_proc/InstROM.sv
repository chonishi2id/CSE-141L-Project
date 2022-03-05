// Module Name:    InstRom 
// Description:    Instruction memory for a 3BC processor
//
module InstROM (
  input       [9:0] InstAddress,    // 10-bit addressing for instructions in case we have need for that many instructions
  output logic[8:0] InstOut);       // 9-bit instructions per project specification
	 
// Sample branch-type instruction format: 
//   {4-bit opcode, 2-bit register index, 2 bit registe index, 1 don't care}
//   use one register to store the index to the LUT
//   then use LUT to map the index to the appropriate label's absolute address
// We have 31 total labels. Therefore, we could use the 8-bit register to index the LUT (allowing indexing of up 
// to 2^8 = 256 data addresses, though we only need 31). 

/*
// First option - manually populating instructions
  always_comb begin 
	InstOut = 'b0000_00_00_0;        // default
	case (InstAddress)
//opcode = 5 load, rd = 1, rs = 0, reg[rd] = mem[reg[rs]]
      0 : InstOut = 'b0101_01_00_0;  // load from address at reg 1 to reg 0  

// opcode = 6 store, rd = 2, rs = 1, mem[reg[rd]] = reg[rs]
      1 : InstOut = 'b0110_10_01_0;  // write reg 1 into address at reg 2
		
// opcode = 10 add, rd = 1, rs = 2, reg[rd] = reg[rd]+reg[rs]
      2 : InstOut = 'b1011_01_10_1;  // add reg 1 and reg 2
		
// opcode = 8 equals, rd = 0, rs = 1, reg[rd] == reg[rs]
      3 : InstOut = 'b1001_00_01_0;  // compare rd to rs for equality
		
// opcode = 15 halt
      4 : InstOut = '1;  // equiv to 10'b1111111111 or 'b1111111111    halt
// (default case already covered by opening statement)
    endcase
  end
*/

// Second option - read instructions from file machine_code.txt
// declare 2-dimensional array, W bits wide, 2**A words deep
  logic[8:0] inst_rom[2**10];
  always_comb InstOut = inst_rom[InstAddress];

  // Load instruction memory from external file
  initial begin
  	// NOTE: This may not work depending on your simulator
	//       e.g. Questa needs the file in path of the application .exe, it
	//       doesn't care where you project code is
	//$readmemb("machine_code.txt",inst_rom);
	
	// So you are probably better off with an absolute path,
	// but you will have to change this example path when you
	// try this on your machine most likely:
	$readmemb("/Users/matthewalanlarkins/Desktop/machine_code.txt", inst_rom);
  end 
endmodule
