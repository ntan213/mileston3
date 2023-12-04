module hazard_unit (
input logic rst, RegWriteM, RegWriteW,
input logic PCSrcE, ResultSrcEb0,
input logic [4:0] rd_addr_M, rd_addr_W, rd_addr_E, rs1_addr_E, rs2_addr_E, rs1_addr_D, rs2_addr_D, 
output logic [1:0] ForwardAE, ForwardBE,
output logic StallF, StallD, FlushD, FlushE
);
//forward outputs
assign ForwardAE = (rst == 1'b0) ? 2'b00 : 
((RegWriteM == 1'b1) && (rs1_addr_E != 5'b0) && (rd_addr_M == rs1_addr_E)) ? 2'b10 :
((RegWriteW == 1'b1) && (rs1_addr_E != 5'b0) && (rd_addr_W == rs1_addr_E)) ? 2'b01 : 2'b00;
assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
((RegWriteM == 1'b1) && (rs2_addr_E != 5'b0) && (rd_addr_M == rs2_addr_E)) ? 2'b10 :
((RegWriteW == 1'b1) && (rs2_addr_E != 5'b0) && (rd_addr_W == rs2_addr_E)) ? 2'b01 : 2'b00;
//stalls and flushes
logic lwStallD;
assign lwStallD = ResultSrcEb0 & ((rs1_addr_D == rd_addr_E) | (rs2_addr_D == rd_addr_E));
assign StallD = lwStallD;
assign StallF = lwStallD;
assign FlushD = ~PCSrcE;
assign FlushE = ~(lwStallD | PCSrcE);
endmodule
