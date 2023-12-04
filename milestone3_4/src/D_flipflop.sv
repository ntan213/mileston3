module D_flipflop (
input logic [12:0] D, 
input logic clk, rst, en,
output logic [12:0] Q
);
always_ff@ (posedge clk or negedge rst) begin
if (!rst)
begin
Q <= 0;
end
else begin
if (!en)
begin
Q <= D;
end
else if (en)
begin
Q <= Q;
end 
end
end
endmodule
