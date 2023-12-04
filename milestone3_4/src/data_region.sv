 module data_region (
 input logic clk_d,
 input logic [8:0] d_addr,
 input logic wren,
 input logic [31:0] data_in,
 output logic [31:0] data_out
 );
 reg[31:0] data_mem[0:511];
 assign data_out = (wren == 0) ? data_mem[d_addr] : 0;
 always@(posedge clk_d) begin
 if(wren)
 begin
 data_mem[d_addr] <= data_in;
 end
 end
 endmodule
