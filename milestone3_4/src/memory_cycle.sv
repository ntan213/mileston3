module memory_cycle (
input logic clk, rst,
input logic [31:0] io_sw_M,
input logic RegWriteM,
input logic MemWriteM,
input logic [1:0] ResultSrcM,
input logic [31:0] ALUResultM,
input logic [31:0] WriteDataM,
input logic [4:0] rd_addr_M,
input logic [12:0] PCPlus4M,
output logic RegWriteW,
output logic [1:0] ResultSrcW,
output logic [31:0] ALUResultW,
output logic [31:0] ReadData_W,
output logic [4:0] rd_addr_W,
output logic [12:0] PCPlus4W,
output logic [6:0] io_hex0_M,
output logic [6:0] io_hex1_M,
output logic [31:0] io_hex2_M,
output logic [31:0] io_hex3_M,
output logic [31:0] io_hex4_M,
output logic [31:0] io_hex5_M,
output logic [31:0] io_hex6_M,
output logic [31:0] io_hex7_M, 
output logic [31:0] io_ledr_M,
output logic [31:0] io_ledg_M,
output logic [31:0] io_lcd_M
);
//declaring wires
logic [31:0] ReadData_M;
logic [31:0] hex0_o_M;
logic [31:0] hex1_o_M;

//declaring registers
reg RegWriteM_reg;
reg [1:0] ResultSrcM_reg;
reg [31:0] ALUResultM_reg;
reg [31:0] ReadDataM_reg;
reg [4:0] rd_addr_M_reg;
reg [12:0] PCPlus4M_reg;


//LSU
lsu DMEM(.clk_i(clk), 
.addr(ALUResultM[9:0]),
.io_sw(io_sw_M),
.st_data(WriteDataM),
.st_en(MemWriteM),
.rst_ni(rst),
.ld_data(ReadData_M),
.io_hex0(hex0_o_M),
.io_hex1(hex1_o_M),
.io_hex2(io_hex2_M),
.io_hex3(io_hex3_M),
.io_hex4(io_hex4_M),
.io_hex5(io_hex5_M),
.io_hex6(io_hex6_M),
.io_hex7(io_hex7_M),
.io_ledr(io_ledr_M),
.io_ledg(io_ledg_M),
.io_lcd(io_lcd_M)
);
//7 segment decoder
decoder_7seg hex0 (.data(hex0_o_M[3:0]),
.hexcode(io_hex0_M)
);
decoder_7seg hex1 (.data(hex1_o_M[3:0]),
.hexcode(io_hex1_M)
);
//declaring registers logic
always @(posedge clk or negedge rst) begin
if (rst == 1'b0) 
begin
RegWriteM_reg <= 1'b0;
ResultSrcM_reg <= 2'b0;
ALUResultM_reg <= 32'b0;
ReadDataM_reg <= 32'b0;
rd_addr_M_reg <= 5'b0;
PCPlus4M_reg <= 13'b0;
end
else begin
RegWriteM_reg <= RegWriteM;
ResultSrcM_reg <= ResultSrcM;
ALUResultM_reg <= ALUResultM;
ReadDataM_reg <= ReadData_M;
rd_addr_M_reg <= rd_addr_M;
PCPlus4M_reg <= PCPlus4M;
end
end
assign RegWriteW = RegWriteM_reg;
assign ResultSrcW = ResultSrcM_reg;
assign ALUResultW = ALUResultM_reg;
assign ReadData_W = ReadDataM_reg;
assign rd_addr_W = rd_addr_M_reg;
assign PCPlus4W = PCPlus4M_reg;
endmodule


