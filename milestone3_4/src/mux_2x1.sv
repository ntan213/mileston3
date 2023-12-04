module mux_2x1 (
input logic [12:0] a,b,
input logic sel,
output logic [12:0] mux_out
);
always_comb begin
case(sel)
1'b0: mux_out = a;
1'b1: mux_out = b;
endcase
end 
endmodule
