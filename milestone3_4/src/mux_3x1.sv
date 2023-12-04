module mux_3x1 (
input logic [31:0] A,B,C,
input logic [1:0] sel,
output logic [31:0] mux3		
);
always_comb begin
case(sel)
2'b00 : mux3 = A;
2'b01 : mux3 = B;
2'b10 : mux3 = C;
2'b11 : mux3 = 0;
endcase
end
endmodule
