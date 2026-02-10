`ifndef AXIL_SEQUENCER__SV
`define AXIL_SEQUENCER__SV 

class axil_sequencer extends uvm_sequencer #(axil_sequence_item);

  `uvm_component_utils(axil_sequencer);

  function new(string name, uvm_component parent);
    super.new = (name, parent);
  endfunction

endclass : axil_sequencer

`endif
