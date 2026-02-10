`ifndef AXIL_DPMEM__SV
`define AXIL_DPMEM__SV 

`include "../inc/axil_pkg.sv"

module axil_dpmem
  import axil_pkg::*;
(
    axil_if.slv_mp axi_slv
);

  data_t MEM[0:`MEM_DEPTH-1];

  // this is the only way I found to get surfur waveform to print the memory ! wtf ! 
  generate
    genvar idx;
    for (idx = 0; idx < `MEM_DEPTH; idx = idx + 1) begin
      data_t tmp;
      assign tmp = MEM[idx];
    end
  endgenerate

  logic aw_received, w_received, ar_received;

  // AW channel
  always_ff @(posedge axi_slv.ACLK or negedge axi_slv.ARESETn) begin
    if (!axi_slv.ARESETn) begin
      axi_slv.AW_READY <= 1'b0;  // can't accept any new addresses now
      aw_received <= 1'b0;
    end else begin
      if (!aw_received) begin
        axi_slv.AW_READY <= 1'b1;  // now ready to accept address
        if (axi_slv.AW_VALID && axi_slv.AW_READY) begin
          aw_received <= 1'b1;
          axi_slv.AW_READY <= 1'b0;  // Stop accepting new addresses
        end
      end else if (axi_slv.B_VALID && axi_slv.B_READY) begin
        // After response completes, reset for next transaction
        aw_received <= 1'b0;
        axi_slv.AW_READY <= 1'b1;
      end
    end
  end

  // W channel
  always_ff @(posedge axi_slv.ACLK or negedge axi_slv.ARESETn) begin
    if (!axi_slv.ARESETn) begin
      axi_slv.W_READY <= 1'b0;
      w_received <= 1'b0;
    end else begin
      if (!w_received) begin
        axi_slv.W_READY <= 1'b1;  // now ready to accept data
        if (axi_slv.W_VALID && axi_slv.W_READY) begin
          w_received <= 1'b1;
          axi_slv.W_READY <= 1'b0;  // Stop accepting new data
          for (int i = 0; i < `AXIL_STRB_WIDTH; i++) begin  // start writing now
            if (axi_slv.W_STRB[i]) begin
              MEM[axi_slv.AW_ADDR][i*8+:8] <= axi_slv.W_DATA[i*8+:8];
            end
          end
        end
      end else if (axi_slv.B_VALID && axi_slv.B_READY) begin
        // After response completes, reset for next transaction
        w_received <= 1'b0;
        axi_slv.W_READY <= 1'b1;
      end
    end
  end

  // B channel
  always_comb begin
    if (!axi_slv.ARESETn) begin
      axi_slv.B_VALID = 1'b0;
      axi_slv.B_RESP  = 2'b10;  // SLVERR response
    end else begin
      if (aw_received && w_received) begin
        axi_slv.B_VALID = 1'b1;
        axi_slv.B_RESP  = 2'b00;  // OKAY response
      end else begin
        axi_slv.B_VALID = 1'b0;
        axi_slv.B_RESP  = 2'b10;  // SLVERR response
      end
    end
  end

  // AR channel
  always_ff @(posedge axi_slv.ACLK or negedge axi_slv.ARESETn) begin

    if (!axi_slv.ARESETn) begin
      axi_slv.AR_READY <= 0;
      ar_received <= 0;
    end else begin
      if (!ar_received) begin
        axi_slv.AR_READY <= 1;
        if (axi_slv.AR_VALID && axi_slv.AR_READY) begin
          ar_received <= 1;
          axi_slv.AR_READY <= 0;
        end
      end else if (axi_slv.R_VALID && axi_slv.R_READY) begin
        ar_received <= 0;
        axi_slv.AR_READY <= 1;
      end
    end
  end

  always_comb begin
    if (!axi_slv.ARESETn) begin
      axi_slv.R_VALID = 0;
      axi_slv.R_DATA  = 0;
      axi_slv.R_RESP  = 2'h2;  // SLVERR
    end else begin
      if (ar_received) begin
        axi_slv.R_VALID = 1;
        axi_slv.R_DATA  = MEM[axi_slv.AR_ADDR];  // read now
        axi_slv.R_RESP  = 0;
      end else begin
        axi_slv.R_VALID = 0;
        axi_slv.R_DATA  = '0;
        axi_slv.R_RESP  = 2'h2;
      end
    end
  end

endmodule : axil_dpmem

`endif
