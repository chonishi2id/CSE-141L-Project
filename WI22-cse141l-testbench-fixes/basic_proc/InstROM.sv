// Create Date:    15:50:22 10/02/2019 
// Design Name: 
// Module Name:    InstROM 
// Project Name:   CSE141L
// Tool versions: 
// Description: Verilog module -- instruction ROM template	
//	 preprogrammed with instruction values (see case statement)
//
// Revision: 2020.08.08
//
module InstROM #(parameter A=10, W=9) (
  input       [A-1:0] InstAddress,
  output logic[W-1:0] InstOut);
	 
// Sample instruction format: 
//   {3bit opcode, 3bit rs or rt, 3bit rt, immediate, or branch target}
//   then use LUT to map 3 bits to 10 for branch target, 8 for immediate	 

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

/* Uncomment this part if reading from machine_code.txt
// Second option (usually recommended) alternative expression
//   need $readmemh or $readmemb to initialize all of the elements
// declare 2-dimensional array, W bits wide, 2**A words deep
  logic[W-1:0] inst_rom[2**A];
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
	//$readmemb("//vmware-host/Shared Folders/Downloads/basic_proc2/machine_code.txt", inst_rom);
  end 
*/
  
endmodule
