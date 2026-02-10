`ifndef AXI_SEQUENCE_ITEM__SV
`define AXI_SEQUENCE_ITEM__SV 

class axi_sequence_item extends uvm_sequence_item;

  // WRITE ADDRESS (AW) CHANNEL SIGNALS
  rand bit AW_VALID;
  rand addr_t AW_ADDR;
  rand logic [2:0] AW_PROT;

  // WRITE DATA (W) CHANNEL SIGNALS
  rand bit W_VALID;
  rand data_t W_DATA;
  rand strb_t W_STRB;

  // WRITE RESPONSE (B) CHANNEL SIGNALS
  rand bit B_READY;

  // READ ADDRESS CHANNEL SIGNALS
  rand bit AR_VALID;
  rand addr_t AR_ADDR;
  rand logic [2:0] AR_PROT;

  // READ DATA CHANNEL SIGNALS
  rand bit R_READY;


  `uvm_object_utils_begin(axi_sequence_item);

    `uvm_object_field(AW_VALID, UVM_ALL_ON)
    `uvm_object_field(AW_ADDR, UVM_ALL_ON)
    `uvm_object_field(AW_PROT, UVM_ALL_ON)

    `uvm_object_field(W_VALID, UVM_ALL_ON)
    `uvm_object_field(W_DATA, UVM_ALL_ON)
    `uvm_object_field(W_STRB, UVM_ALL_ON)

    `uvm_object_field(B_READY, UVM_ALL_ON)

    `uvm_object_field(AR_VALID, UVM_ALL_ON)
    `uvm_object_field(AR_ADDR, UVM_ALL_ON)
    `uvm_object_field(AR_PROT, UVM_ALL_ON)

    `uvm_object_field(R_READY, UVM_ALL_ON)

  `uvm_object_utils_end

  function new(string name = "axi_sequence_item");
    super.new = (name);
  endfunction


endclass : axi_sequence_item



`endif

