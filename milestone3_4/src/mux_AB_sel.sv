module mux_AB_sel (
input logic [31:0] a,b,
input logic select,
output logic [31:0] result 		
);
always_comb begin
case(select)
1'b0 : result = a;
1'b1 : result = b;
endcase
end
endmodule


