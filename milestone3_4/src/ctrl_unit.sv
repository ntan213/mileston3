module ctrl_unit (
   input logic [6:0] funct7,
   input logic [2:0] funct3,
	input logic inst30,
   output logic jump_sel,
   output logic br_sel,
   output logic rd_wren,
	output logic mem_wren,
	output logic op_b_sel,
	output logic [6:0] imm_sel,
	output logic [1:0] wb_sel,
   output logic [3:0] alu_sel
	);
	
	
	alu_dec alu_decoder0 (.func7(funct7), .func3(funct3), .instr30(inst30),
	.alucontrol(alu_sel)
	);
   
  // assign {br_sel, br_unsigned, op_a_sel, op_b_sel, mem_wren, rd_wren}
	always_latch begin
	//R_Type 
	if (funct7 == 7'b0110011) //add,sub,xor,srl,sra,or,and,slt,sltu
   begin
//	controls = 6'b000001;
	wb_sel = 2'b00;
	br_sel = 0;
	jump_sel = 0;
	op_b_sel = 0;
	mem_wren = 0;
	rd_wren = 1;
	end
	//I-Type
	else if (funct7 == 7'b0010011) //addi,slti,sltiu,xori,ori,andi,slli,srli
	begin
//	controls = 6'b000101;
	wb_sel = 2'b00;
	imm_sel = funct7;
	br_sel = 0;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end
	
	//LW
	else if (funct7 == 7'b0000011)
	begin
//	controls = 6'b000101;
	wb_sel = 2'b01;
	imm_sel = funct7;
	br_sel = 0;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end

	//S-Type
	else if(funct7 == 7'b0100011)
	begin
//	controls = 6'b000110;
	imm_sel = funct7;
	br_sel = 0;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 1;
	rd_wren = 0;
	end

	//B-Type
	else if(funct7 == 7'b1100011 && funct3 == 3'b001) //bne
	begin
//	controls = 6'b101100;
	imm_sel = funct7;
	br_sel = 1;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 0;
	end


	
	else if(funct7 == 7'b1100011 && funct3 == 3'b000) //beq
	begin
//	controls = 6'b101100;
	imm_sel = funct7;
	br_sel = 1;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 0;
	end

	
	else if(funct7 == 7'b1100011 && funct3 == 3'b100) //blt
	begin
	//controls = 6'b101100;
	imm_sel = funct7;
	br_sel = 1;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 0;
	end

	

	
	else if(funct7 == 7'b1100011 && funct3 == 3'b110) //bltu
	begin
	//controls = 6'b111100;
	imm_sel = funct7;
	br_sel = 1;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 0;
	end

	

	//J-Type
	else if (funct7 == 7'b1101111) //jal
	begin
	//controls = 6'b101101;
	imm_sel = funct7;
	wb_sel = 2'b10;
	br_sel = 1;
	jump_sel = 1;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end

	else if (funct7 == 7'b1100111) //jalr
	begin
	//controls = 6'b100101;
	imm_sel = 7'b0010011;
	wb_sel = 2'b10;
	br_sel = 1;
	jump_sel = 1;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end

	//U-Type
	else if (funct7 == 7'b0010111) //AUIPC
	begin 
	// controls = 6'b001101;
	imm_sel = funct7;
	wb_sel = 2'b00;
	br_sel = 0;
	jump_sel = 0;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end

	else if (funct7 == 7'b0110111) //LUI
	begin
	// controls = 6'b101101;
	imm_sel = 7'b0010111; //U-Type imm
	wb_sel = 2'b00;
	br_sel = 1;
	jump_sel = 1;
	op_b_sel = 1;
	mem_wren = 0;
	rd_wren = 1;
	end
end
	endmodule
