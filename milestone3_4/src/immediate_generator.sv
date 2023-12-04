module immediate_generator (
   input logic [31:0] instruction,
   output logic [31:0] immOut,
   input logic [6:0] opcode
	);

  
   always @(instruction) 
   case (opcode)
        7'b0010011: immOut  = { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // ADDI     -> I-Type
        7'b0100011: immOut  = { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};     // SW       -> S-Type
        7'b0010111: immOut  = { instruction[31], instruction[30:20], instruction[19:12], {12{1'b0}} };             // AUIPC    -> U-Type
        7'b0000011: immOut  = { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // LW       -> I-Type
        7'b1101111: immOut  = { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], {1{1'b0}}};  // JAL -> J-Type
        7'b1100011: immOut  = { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1{1'b0}}};  // BRANCH -> B-Type
        default: immOut = 32'b0;
		  endcase
		  endmodule 
