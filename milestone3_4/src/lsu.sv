 module lsu (
 input logic clk_i, 
 input logic [9:0] addr,
 input logic [31:0] st_data,
 input logic st_en,
 input logic rst_ni,
 input logic [31:0] io_sw,
 output logic [31:0] ld_data,
 output logic [31:0] io_hex0,
 output logic [31:0] io_hex1,
 //verilator lint_off unused
 output logic [31:0] io_hex2,
 output logic [31:0] io_hex3,
 output logic [31:0] io_hex4,
 output logic [31:0] io_hex5,
 output logic [31:0] io_hex6,
 output logic [31:0] io_hex7,
 output logic [31:0] io_ledr,
 output logic [31:0] io_ledg,
 output logic [31:0] io_lcd
 //verilator lint_on unused
 );
 logic [31:0] data_region_out;
 logic [31:0] output_peri_out;
 logic [31:0] sw_peri_out;
 logic data_we,out_we,sw_we;
 logic [8:0] daddr;
 logic [5:0] oaddr;
 logic [5:0] iaddr;
 assign data_we = (addr < 512 && st_en) ? 1 : 0;
 assign out_we = (addr > 511 && addr < 576 && st_en) ? 1 : 0;
 assign sw_we = (addr > 575 && addr < 640 && st_en) ? 1 : 0;
 assign daddr = addr[8:0];
 assign oaddr = addr[5:0];
 assign iaddr = addr[5:0];
 
 reg32 hex0 (.clk_reg(clk_i),

 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h200),
 .reg_in(st_data),
 .reg_out(io_hex0)
 );
 
 reg32 hex1 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h210),
 .reg_in(st_data),
 .reg_out(io_hex1)
 );
 
 reg32 hex2 (.clk_reg(clk_i),
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h220),
 .reg_in(st_data),
 .reg_out(io_hex2)
 );
 
 reg32 hex3 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h230),
 .reg_in(st_data),
 .reg_out(io_hex3)
 );
 
 reg32 hex4 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h240),
 .reg_in(st_data),
 .reg_out(io_hex4)
 );
 
 reg32 hex5 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h250),
 .reg_in(st_data),
 .reg_out(io_hex5)
 );
 
 reg32 hex6 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h260),
 .reg_in(st_data),
 .reg_out(io_hex6)
 );
 
 reg32 hex7 (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h270),
 .reg_in(st_data),
 .reg_out(io_hex7)
 );
 
 reg32 ledr (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h280),
 .reg_in(st_data),
 .reg_out(io_ledr)
 );
 
 reg32 ledg (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h290),
 .reg_in(st_data),
 .reg_out(io_ledg)
 );
 
 reg32 lcd (.clk_reg(clk_i),
 
 .reg_we(st_en),
 .rstn_reg(rst_ni),
 .operand_a(addr),
 .operand_b(10'h2A0),
 .reg_in(st_data),
 .reg_out(io_lcd)
 );
 data_region region_0 (.clk_d(clk_i),
 
 .d_addr(daddr),
 .wren(data_we),
 .data_in(st_data),
 .data_out(data_region_out)
 );
 
 output_peripherals region_1(.clk_o(clk_i),

 .o_addr(oaddr),
 .io_data_in(st_data),
 .o_wren(out_we),
 .io_data_out(output_peri_out)
 );
 
 switch_peripherals region_2 (.clk_sw(clk_i),
 .sw_addr(iaddr),
 
 .sw_wren(sw_we),
 .sw_data(io_sw),
 .sw_out(sw_peri_out)
 );
 
 final_mux output_select (.main_addr(addr),
 .a(data_region_out),
 .b(output_peri_out),
 .c(sw_peri_out),
 .mux_out(ld_data)
 );
 endmodule

