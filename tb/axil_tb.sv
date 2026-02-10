`ifndef AXIL_TB__SV
`define AXIL_TB__SV 

`include "../inc/axil_pkg.sv"
`include "../src/axil_if.sv"
`include "../src/axil_dpmem.sv"

module axil_tb;

  import axil_pkg::*;

  bit clk;
  bit resetn;

  initial begin
    clk = 1;
    forever begin
      #5;
      clk = ~clk;
    end
  end

  initial begin
    resetn = 0;
    @(negedge clk);
    resetn = 1;
  end

  bit tb_AW_VALID;
  addr_t tb_AW_ADDR;

  bit tb_W_VALID;
  data_t tb_W_DATA;
  strb_t tb_W_STRB;

  bit tb_B_READY;

  bit tb_AR_VALID;
  addr_t tb_AR_ADDR;

  bit tb_R_VALID;

  bit tb_R_READY;

  axil_if intf (
      .ACLK(clk),
      .ARESETn(resetn)
  );

  axil_dpmem dut (.axi_slv(intf.slv_mp));

  assign intf.AW_VALID = tb_AW_VALID;
  assign intf.AW_ADDR  = tb_AW_ADDR;


  assign intf.W_VALID  = tb_W_VALID;
  assign intf.W_DATA   = tb_W_DATA;
  assign intf.W_STRB   = tb_W_STRB;

  assign intf.B_READY  = tb_B_READY;

  assign intf.AR_VALID = tb_AR_VALID;
  assign intf.AR_ADDR  = tb_AR_ADDR;

  assign intf.R_READY  = tb_R_READY;

  initial begin
    tb_AW_VALID = 0;

    tb_W_VALID  = 0;

    tb_B_READY  = 0;

    tb_AR_VALID = 0;
    
    tb_R_READY  = 0;

    // dummy directed test case # 1
    @(posedge clk);

    tb_AW_VALID = 1;
    tb_AW_ADDR  = 32'h8;

    tb_W_VALID  = 1;
    tb_W_DATA   = 32'hdeadbeef;
    tb_W_STRB   = 4'hc;

    tb_B_READY  = 1;

    tb_AR_VALID = 1;
    tb_AR_ADDR  = 32'h9;

    tb_R_READY  = 1;

    @(posedge clk);

    tb_AW_VALID = 0;

    tb_W_VALID  = 0;

    tb_B_READY  = 1;

    tb_AR_VALID = 0;

    tb_R_READY  = 1;

    @(posedge clk);
    tb_B_READY = 0;
    tb_R_READY = 0;

    // // dummy directed test case # 2
    // @(posedge clk);

    // tb_AW_VALID = 1;
    // tb_AW_ADDR  = 32'h8;

    // tb_W_VALID  = 1;
    // tb_W_DATA   = 32'hfedcba98;
    // tb_W_STRB   = 4'hc;

    // tb_AR_VALID = 1;
    // tb_AR_ADDR  = 32'h9;

    // tb_W_VALID  = 1;

    // tb_R_READY  = 0;

    // @(posedge clk);

    // tb_AW_VALID = 0;

    // tb_W_VALID  = 0;

    // tb_B_READY  = 1;

    // tb_AR_VALID = 0;

    // tb_R_READY  = 1;

    // @(posedge clk);
    // tb_B_READY = 0;
    // tb_R_READY = 0;

  end

  initial begin
    $dumpfile("axi_dpmem.vcd");
    $dumpvars(0, axil_tb.dut);

    for (int i = 0; i < `MEM_DEPTH; i++) begin  // First 16 locations
      $dumpvars(0, axil_tb.dut.MEM[i]);
    end

  end

  //   initalize the memory to 0
  initial begin
    for (int i = 0; i < `MEM_DEPTH; ++i) begin
      dut.MEM[i] = 32'h12dead34;
    end
  end

  initial begin
    #100;
    $finish;
  end

endmodule

`endif
