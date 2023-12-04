module pipelined (
input logic clk_i,
input logic rst_ni,
input logic [31:0] io_sw_i,
output logic [12:0] pc_debug_o,
output logic [31:0] io_lcd_o,
output logic [31:0] io_ledr_o,
output logic [31:0] io_ledg_o,
output logic [6:0] io_hex0_o,
output logic [6:0] io_hex1_o,
  /* verilator lint_off UNUSED */
output logic [31:0] io_hex2_o,
output logic [31:0] io_hex3_o,
output logic [31:0] io_hex4_o,
output logic [31:0] io_hex5_o,
output logic [31:0] io_hex6_o,
output logic [31:0] io_hex7_o
  /* verilator lint_on UNUSED */
);
//declaration of wires
logic PCSrcE;
logic [12:0] PCTargetE;
logic [31:0] InstrD;
logic [12:0] PCD;
logic [12:0] PCE;
logic [12:0] PCPlus4D;
logic [12:0] PCPlus4E;
logic [12:0] PCPlus4M;
logic [12:0] PCPlus4W;
logic RegWriteW;
logic [4:0] rd_addr_W;
logic [31:0] ResultW;
logic RegWriteE;
logic MemWriteE;
logic BrE;
logic JumpE;
logic ALUControlE;
logic [1:0] ResultSrcE;
logic op_b_sel_E;
logic [31:0] rs1_E;
logic [31:0] rs2_E;
logic [31:0] immOut_E;
logic [4:0] rd_addr_E;
logic RegWriteM;
logic MemWriteM;
logic [1:0] ResultSrcM;
logic [31:0] ALUResultM;
logic [31:0] WriteDataM;
logic [4:0] rd_addr_M;
logic [1:0] ResultSrcW;
logic [31:0] ALUResultW;
logic [31:0] ReadData_W;
logic [4:0] rs1_addr_E;
logic [4:0] rs2_addr_E;
logic [4:0] rs1_addr_D;
logic [4:0] rs2_addr_D;
logic [1:0] ForwardAE;
logic [1:0] ForwardBE;
logic StallF;
logic StallD;
logic FlushD;
logic FlushE;

//Fetch Cycle
fetch_cycle fetch (.clk(clk_i),
.rst(FlushD),
.PCSrcE(PCSrcE),
.StallF(StallF),
.StallD(StallD),
.PCTargetE(PCTargetE),
.InstrD(InstrD),
.PCD(PCD), 
.PCPlus4D(PCPlus4D)
);
//Decode Cycle
decode_cycle decode (.clk(clk_i), 
.rst(FlushE),
.RegWriteW(RegWriteW),
.InstrD(InstrD),
.ResultW(ResultW),
.PCD(PCD),
.PCPlus4D(PCPlus4D),
.rd_addr_W(rd_addr_W),
.RegWriteE(RegWriteE),
.MemWriteE(MemWriteE),
.BrE(BrE),
.JumpE(JumpE),
.ALUControlE(ALUControlE),
.ResultSrcE(ResultSrcE),
.op_b_sel_E(op_b_sel_E),
.rs1_E(rs1_E),
.rs2_E(rs2_E),
.immOut_E(immOut_E),
.rd_addr_E(rd_addr_E),
.PCE(PCE),
.PCPlus4E(PCPlus4E),
.rs1_addr_E(rs1_addr_E),
.rs2_addr_E(rs2_addr_E),
.rs1_addr_D_out(rs1_addr_D),
.rs2_addr_D_out(rs2_addr_D)
);
//execute cycle
execute_cycle execute (.clk(clk_i), 
.rst(rst_ni),
.RegWriteE(RegWriteE),
.MemWriteE(MemWriteE),
.BrE(BrE),
.JumpE(JumpE),
.ALUControlE(ALUControlE),
.ResultSrcE(ResultSrcE),
.op_b_sel_E(op_b_sel_E),
.rs1_E(rs1_E),
.rs2_E(rs2_E),
.immOut_E(immOut_E),
.rd_addr_E(rd_addr_E),
.PCE(PCE),
.PCPlus4E(PCPlus4E),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.ResultW(ResultW),
.PCTargetE(PCTargetE),
.PCSrcE(PCSrcE),
.RegWriteM(RegWriteM),
.MemWriteM(MemWriteM),
.ResultSrcM(ResultSrcM),
.ALUResultM(ALUResultM),
.WriteDataM(WriteDataM),
.rd_addr_M(rd_addr_M),
.PCPlus4M(PCPlus4M)
);
//memory cycle
memory_cycle memory (.clk(clk_i), 
.rst(rst_ni),
.io_sw_M(io_sw_i),
.RegWriteM(RegWriteM),
.MemWriteM(MemWriteM),
.ResultSrcM(ResultSrcM),
.ALUResultM(ALUResultM),
.WriteDataM(WriteDataM),
.rd_addr_M(rd_addr_M),
.PCPlus4M(PCPlus4M),
.RegWriteW(RegWriteW),
.ResultSrcW(ResultSrcW),
.ALUResultW(ALUResultW),
.ReadData_W(ReadData_W),
.rd_addr_W(rd_addr_W),
.PCPlus4W(PCPlus4W),
.io_hex0_M(io_hex0_o),
.io_hex1_M(io_hex1_o),
.io_hex2_M(io_hex2_o),
.io_hex3_M(io_hex3_o),
.io_hex4_M(io_hex4_o),
.io_hex5_M(io_hex5_o),
.io_hex6_M(io_hex6_o),
.io_hex7_M(io_hex7_o), 
.io_ledr_M(io_ledr_o),
.io_ledg_M(io_ledg_o),
.io_lcd_M(io_lcd_o)
);
//writeback cycle
WB_cycle writeback (.ResultSrcW(ResultSrcW),
.ALUResultW(ALUResultW),
.ReadDataW(ReadData_W),
.PCPlus4W(PCPlus4W),
.ResultW(ResultW)
);
//hazard unit
hazard_unit hazard_handler (.rst(rst_ni), 
.RegWriteM(RegWriteM), 
.RegWriteW(RegWriteW),
.ResultSrcEb0(ResultSrcE[0]),
.PCSrcE(PCSrcE),
.rd_addr_M(rd_addr_M), 
.rd_addr_W(rd_addr_W), 
.rd_addr_E(rd_addr_E),
.rs1_addr_E(rs1_addr_E), 
.rs2_addr_E(rs2_addr_E),
.rs1_addr_D(rs1_addr_D),
.rs2_addr_D(rs2_addr_D),
.ForwardAE(ForwardAE), 
.ForwardBE(ForwardBE),
.StallF(StallF),
.StallD(StallD),
.FlushD(FlushD),
.FlushE(FlushE)
);

assign pc_debug_o = PCD;
endmodule



							  




