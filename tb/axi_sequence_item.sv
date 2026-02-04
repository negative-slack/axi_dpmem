`ifndef AXI_SEQUENCE_ITEM__SV
`define AXI_SEQUENCE_ITEM__SV 

class axi_sequence_item extends uvm_sequence_item;

  rand size_t AW_SIZE;
  rand size_t AR_SIZE;

  rand size_t AW_ADDR;
  rand size_t AR_ADDR;

  constraint awsize_arsize {AW_SIZE inside {ONE_BYTE, TWO_BYTES, FOUR_BYTES};}
  constraint arsize_arsize {AR_SIZE inside {ONE_BYTE, TWO_BYTES, FOUR_BYTES};}

  `uvm_object_utils_begin(axi_sequence_item);

  `uvm_object_utils_end

  function new(string name = "axi_sequence_item");
    super.new = (name);
  endfunction



endclass : axi_sequence_item



`endif
