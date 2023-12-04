module next_PC_calculator (
input logic [12:0] number_a, number_b, 
output logic [12:0] sum
);
assign sum = number_a + number_b;
endmodule
