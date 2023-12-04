module alu_dec(
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic instr30,
    output logic [3:0] alucontrol
	);
    
    always_latch begin
	 if(func7 == 7'b1100011 && func3 == 3'b001) //bne
	 begin
	 alucontrol = 4'b0001; //sub
	 end
	 else if(func7 == 7'b1100011 && func3 == 3'b000) //beq
	 begin
	 alucontrol = 4'b0001; //sub
	 end
	 else if(func7 == 7'b1100011 && func3 == 3'b100) //blt
	 begin
	 alucontrol = 4'b0010; //slt
	 end
	 else if(func7 == 7'b1100011 && func3 == 3'b110) //bltu
	 begin
	 alucontrol = 4'b0011; //sltu
	 end
	 //J-Type, U-Type, S-Type the ALU op is always add
	 else if (func7 == 7'b1101111 || func7 == 7'b0010111 || func7 == 7'b0100011 || func7 == 7'b0110111 ) 
	 begin
	 alucontrol = 4'b0000; //add
	 end
	 //I-Type
	 else if (func7 == 7'b0010011)
	 begin
	 case(func3)
	 3'b000 : alucontrol = 4'b0000; //addi
	 3'b010 : alucontrol = 4'b0010; //slti
	 3'b011 : alucontrol = 4'b0011; //sltiu
	 3'b100 : alucontrol = 4'b0100; //xori
	 3'b110 : alucontrol = 4'b0101; //ori
	 3'b111 : alucontrol = 4'b0110; //andi
	 3'b001 : alucontrol = 4'b0111; //slli
	 3'b101 : case(instr30)
	        1'b0 : alucontrol = 4'b1000; //srli
			  1'b1 : alucontrol = 4'b1001; //srai
			  endcase
	 endcase
	 end
	 //R-Type
	 else if (func7 == 7'b0110011)
	 begin
	 case(func3)
	 3'b000 : case(instr30)
	        1'b0 : alucontrol = 4'b0000; //add
			  1'b1 : alucontrol = 4'b0001; //sub
			  endcase
	 3'b001 : alucontrol = 4'b0111; //sll
	 3'b010 : alucontrol = 4'b0010; //slt
	 3'b011 : alucontrol = 4'b0011; //sltu
	 3'b100 : alucontrol = 4'b0100; //xor
	 3'b101 : case(instr30)
	        1'b0 : alucontrol = 4'b1000; //srl
			  1'b1 : alucontrol = 4'b1001; //sra
			  endcase
	 3'b110 : alucontrol = 4'b0101; //or
	 3'b111 : alucontrol = 4'b0110; //and
	 endcase
	 end
	 //LW and JALR
	 else if (func7 == 7'b0000011 || func7 == 7'b1100111)
	 begin
	 alucontrol = 4'b0000; //add
	 end
	 end
	 endmodule
