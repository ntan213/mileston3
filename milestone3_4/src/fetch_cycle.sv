module fetch_cycle (
input logic clk, rst,
input logic PCSrcE,
input logic StallF,
input logic StallD,
input logic [12:0] PCTargetE,
output logic [31:0] InstrD,
output logic [12:0] PCD, PCPlus4D
);
//declaring wires
logic [12:0] PCF;
logic [12:0] PCPlus4F;
//declare registers
reg [31:0] InstrF_reg;
reg [12:0] PCF_reg;
reg [12:0] PCPlus4F_reg; 
//declare PC 
program_counter PC_module (.clk_i(clk),
.enable(StallF),
.rst_ni(rst),
.selPC(PCSrcE),
.PC_branch(PCTargetE),
.current_PC(PCF),
.PC_plus_4(PCPlus4F)
);
//declare instruction memory
logic [31:0] InstrF;
instruction_memory IMEM_module (.paddr_i(PCF),
.prdata_o(InstrF)
);
//fetch cycle registers logic
always@ (posedge clk or negedge rst) begin
if (rst == 1'b0)
begin
InstrF_reg <= 32'h00000000;
PCF_reg <= 13'b0;
PCPlus4F_reg <= 13'b0;
end
else begin
if (StallD == 1'b0)
begin
InstrF_reg <= InstrF;
PCF_reg <= PCF;
PCPlus4F_reg <= PCPlus4F;
end
else if (StallD == 1'b1)
begin
InstrF_reg <= InstrF_reg;
PCF_reg <= PCF_reg;
PCPlus4F_reg <= PCPlus4F_reg;
end
end
end

assign InstrD = InstrF_reg;
assign PCD = PCF_reg;
assign PCPlus4D = PCPlus4F_reg;
endmodule
