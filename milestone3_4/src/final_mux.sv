 module final_mux (
 input [11:0] main_addr,
 input [31:0] a, b, c,
 output [31:0] mux_out
 );
 
 assign mux_out = (main_addr < 2048) ? a :
 (main_addr > 2047 && main_addr < 2304) ? b :
 (main_addr > 2303 && main_addr < 2560) ? c : 0;
 endmodule
 
 
 
 
