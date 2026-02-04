`ifndef AXI_IF__SV
`define AXI_IF__SV 

interface axi_if
  import axi_pkg::*;
(
    bit ACLK,    // Global Clock Signal
    bit ARESETn  // Global Reset Signal
);

  ////////////////////////////////////////////
  // Write Channel Signals
  ////////////////////////////////////////////

  // WRITE ADDRESS (AW) CHANNEL SIGNALS
  bit AW_VALID;
  bit AW_READY;
  addr_t AW_ADDR;
  size_t AW_SIZE;
  burst_t AW_BURST;
  logic [7:0] AW_LEN;  // up to 256 transfers in the one transaction
  // logic [3:0] AWCACHE;
  // logic [2:0] AWPROT;
  // logic [$:0] AWID;
  // logic AWLOCK;
  // logic [3:0] AWQOS;
  // logic [3:0] AWREGION;
  // logic [$:0] AWUSER;

  // WRITE DATA (W) CHANNEL SIGNALS
  bit W_VALID;
  bit W_READY;
  data_t W_DATA;
  strb_t W_STRB;
  bit W_LAST;
  // logic [$:0] WUSER;

  // WRITE RESPONSE (B) CHANNEL SIGNALS
  bit B_VALID;
  bit B_READY;
  bit [1:0] B_RESP;
  // logic [$:0] BID;
  // logic [$:0] BUSER;

  ////////////////////////////////////////////
  // Read Channel Signals
  ////////////////////////////////////////////

  // READ ADDRESS CHANNEL SIGNALS
  bit AR_VALID;
  bit AR_READY;
  addr_t AR_ADDR;
  size_t AR_SIZE;
  burst_t AR_BURST;
  logic [7:0] AR_LEN;  // up to 256 transfers in the one transaction
  // logic [3:0] ARCACHE;
  // logic [2:0] ARPROT;
  // logic [$:0] ARID;
  // logic AWLOCK;
  // logic [3:0] ARQOS;
  // logic [3:0] ARREGION;
  // logic [$:0] ARUSER;

  // READ DATA CHANNEL SIGNALS
  bit R_VALID;
  bit R_READY;
  bit R_LAST;
  data_t R_DATA;
  strb_t R_RESP;
  // logic [$:0] RID;
  // logic [$:0] RUSER;

  modport slv_mp(
      input  // each channel will be in a sepearte line for better visualization

      ACLK, ARESETn,  // system

      AW_VALID, AW_ADDR, AW_SIZE, AW_BURST, AW_LEN,  // WRITE ADDRESS CHANNEL SIGNALS

      W_VALID, W_DATA, W_STRB, W_LAST,  // WRITE DATA CHANNEL SIGNALS

      B_READY,  // WRITE RESPONSE CHANNEL SIGNALS

      AR_VALID, AR_ADDR, AR_SIZE, AR_BURST, A_RLEN,  // READ ADDRESS CHANNEL SIGNALS

      R_READY,  // READ DATA CHANNEL SIGNALS


      output  // each channel will be in a sepearte line for better visualization

      AW_READY,  // WRITE ADDRESS CHANNEL SIGNALS

      W_READY,  // WRITE DATA CHANNEL SIGNALS

      B_VALID, B_RESP,  // WRITE RESPONSE CHANNEL SIGNALS

      AR_READY,  // READ ADDRESS CHANNEL SIGNALS

      R_VALID, R_DATA, R_RESP, R_LAST  // READ DATA CHANNEL SIGNALS

  );

endinterface : axi4_if

`endif
