module WB_cycle (
input logic [1:0] ResultSrcW,
input logic [31:0] ALUResultW,
input logic [31:0] ReadDataW,
input logic [12:0] PCPlus4W,
output logic [31:0] ResultW
);
//WB select
mux_3x1 WBselect (
.A(ALUResultW),
.B(ReadDataW),
.C({19'b0,PCPlus4W}),
.sel(ResultSrcW),
.mux3(ResultW)
);
endmodule
