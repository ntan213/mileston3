module switch_peripherals (
 input logic clk_sw,
 input logic sw_wren,
 input logic [5:0] sw_addr,
 input logic [31:0] sw_data,
 output logic [31:0] sw_out
 );
 
 reg[31:0] sw_mem[0:63];
 assign sw_out = (sw_wren == 0) ? sw_mem[sw_addr] : 0;
 
 always@(posedge clk_sw) begin
 if(sw_wren)
 begin
 sw_mem[sw_addr] <= sw_data;
 end
 end
 endmodule
