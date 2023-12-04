module instruction_memory 
  (
  input  logic [12:0]       paddr_i ,
  output logic [31:0]       prdata_o,

  /* verilator lint_off UNUSED */
  input  logic              clk_i   ,
  input  logic              rst_ni
  /* verilator lint_on UNUSED */
);

  /* verilator lint_off UNUSED */
  logic unused;
  assign unused = |paddr_i[1:0];
  /* verilator lint_on UNUSED */


  reg [31:0] imem [0:2047];


  initial begin
    $readmemh("mem/instmem.data.kit", imem);
  end


  always_comb begin : proc_data
    prdata_o = imem[paddr_i[12:2]];
  end

endmodule : instruction_memory
