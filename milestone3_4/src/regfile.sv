module regfile (
  input logic clk_i,
  input logic rst_ni,
  input logic [4:0] rs1_addr,
  input logic [4:0] rs2_addr,
  input logic [4:0] rd_addr,
  input logic [31:0] rd_data,
  input logic rd_wren,
  output logic [31:0] rs1_data,
  output logic [31:0] rs2_data
  );
  
  reg [31:0] register[0:31];
  integer i;
  assign rs1_data = (rs1_addr != 0) ? register[rs1_addr] : 0;
  assign rs2_data = (rs2_addr != 0) ? register[rs2_addr] : 0;
  
  always@ (posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) 
	 begin
      for (i=0;i<32;i++) begin
	   register[i] <= 0;
	   end
	 end
    else begin
	 if (rd_wren)
	 begin
	 register[rd_addr] <= rd_data;
	 end
	 end
	 end
	 endmodule
