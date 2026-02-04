`ifndef AXI_DPMEM_DEFINES__SVH
`define AXI_DPMEM_DEFINES__SVH

`ifndef AXI_ADDR_WIDTH 
`define AXI_ADDR_WIDTH 32
`endif

`ifndef AXI_DATA_WIDTH 
`define AXI_DATA_WIDTH 32
`endif

`ifndef AXI_STRB_WIDTH 
`define AXI_STRB_WIDTHB `AXI_DATA_WIDTH / 8
`endif

`ifndef AXI_SIZE_WIDTH 
`define AXI_SIZE_WIDTH 3
`endif

`ifndef AXI_BURST_WIDTH 
`define AXI_BURST_WIDTH 2
`endif

`ifndef AXI_LEN_WIDTH 
`define AXI_LEN_WIDTH 8
`endif

`ifndef MEM_DEPTH 
`define MEM_DEPTH (1 << `AXI_ADDR_WIDTH)
`endif

`endif