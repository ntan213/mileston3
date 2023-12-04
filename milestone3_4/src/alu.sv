  module alu (
  input logic [31:0] operand_a,
  input logic [31:0] operand_b,
  input logic [3:0] alu_op,
  output logic [31:0] alu_data,
  output logic br_less,
  output logic br_equal,
  output logic br_not_equal
  );

  logic [31:0] a_xor_b;
  logic [31:0] a_or_b;
  logic [31:0] a_and_b;
  logic [31:0] sll;
  logic [31:0] srl;
  logic [31:0] sra;
  logic [31:0] not_b;
  logic [31:0] sum_or_sub;
  logic [31:0] mux_2x1;
 
  logic [31:0] compare_signed;
  logic [31:0] compare_unsigned;
  logic [31:0] sub_signed;
  logic [31:0] sub_unsigned;
  logic slt;
  logic sltu;
  
  
  
  assign sub_signed   = compare_signed   & 32'h80000000;
  assign sub_unsigned = compare_unsigned & 32'h10000000;
  assign a_xor_b = operand_a ^ operand_b;
  assign a_or_b = operand_a | operand_b;
  assign a_and_b = operand_a & operand_b;
  assign sll = operand_a << operand_b[4:0];
  assign srl = operand_a >> operand_b[4:0];
  assign sra = operand_a >>> operand_b[4:0];
  assign not_b = ~operand_b;
  assign mux_2x1 = (alu_op[0] == 1'b0) ? operand_b:not_b;
  assign sum_or_sub = operand_a + mux_2x1 + {31'b0,alu_op[0]};
  assign compare_unsigned = operand_a + not_b + 1;
  assign compare_signed = $signed(operand_a) + $signed(not_b) + 1;
  assign br_less = slt | sltu;
  assign br_equal = (alu_data == 32'b0) ? 1 : 0;
  assign br_not_equal = (alu_data != 32'b0) ? 1 : 0;
  
 
  
 
  
  always_latch begin 
  case (alu_op)
  4'b0000 : alu_data = sum_or_sub; //sum
  4'b0001 : alu_data = sum_or_sub; //sub
  4'b0010 : 
  if (sub_signed == 32'h80000000)  
  begin 
  slt = 1;
  alu_data = {31'b0,slt};
  end
  else begin
  slt = 0;
  alu_data = {31'b0,slt};
  end
  4'b0011 : 
   if  ((operand_a[31] ^ operand_b[31] == 0) && (sub_unsigned == 32'h10000000)) 
	begin  
	sltu = 1;
	alu_data = {31'b0,sltu};
	end
   else if ((operand_a[31] ^ operand_b[31] == 1) && (sub_unsigned == 32'b0))
	begin
	sltu =1;
	alu_data = {31'b0,sltu};
	end
	else begin		     
	sltu = 0;
	alu_data = {31'b0,sltu};
   end 
  4'b0100 : alu_data = a_xor_b;
  4'b0101 : alu_data = a_or_b;
  4'b0110 : alu_data = a_and_b;
  4'b0111 : alu_data = sll;
  4'b1000 : alu_data = srl;
  4'b1001 : alu_data = sra;
  default : alu_data = 32'b0;
  endcase
  end
  endmodule
  
			
  
  
  
  
  
