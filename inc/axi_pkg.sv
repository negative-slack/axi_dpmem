`ifndef AXI_PKG__SV
`define AXI_PKG__SV 

`include "axi_dpmem_defines.svh"

package axi_pkg;

  typedef logic [`AXI_ADDR_WIDTH-1:0] addr_t;

  typedef logic [`AXI_DATA_WIDTH-1:0] data_t;

  // *SIZE : describes the maximum number of bytes to transfer in each data transfer 
  // e.g., 1, 2, 4, 8, 16, 32, 64 128
  typedef logic [`AXI_SIZE_WIDTH-1:0] size_t;

  // *BURST : describes the burst type of the transaction: fixed, incrementing, or wrapping.
  typedef logic [`AXI_BURST_WIDTH-1:0] burst_t;

  // describes the length of the transaction in the number of transfers.
  // For AXI4, AxLEN[7:0] has 8 bits, which specifies a range of 1-256 data transfers in a transaction.
  typedef logic [`AXI_LEN_WIDTH-1:0] len_t;

  typedef logic [`AXI_STRB_WIDTH-1:0] strb_t;

  typedef enum size_t {
    ONE_BYTE               = 3'b000,
    TWO_BYTES              = 3'b001,
    FOUR_BYTES             = 3'b010,
    EIGHT_BYTES            = 3'b011,
    SIXTEEN_BYTES          = 3'b100,
    THIRTY_TWO_BYTES       = 3'b101,
    SIXTY_FOUR_BYTES       = 3'b110,
    ONE_TWENTY_EIGHT_BYTES = 3'b111
  } size_enum_t;

  typedef enum burst_t {
    /* Reads the same address repeatedly.
    Useful for FIFOs. */
    FIXED = 2'b00,

    /* Incrementing burst.
    The slave increments the address for
    each transfer in the burst from the
    address for the previous transfer.
    The incremental value depends on the
    size of the transfer, as defined by the
    AxSIZE attribute.
    Useful for block transfers. */
    INCR = 2'b01,

    /* Wrapping burst.

    Similar to an incrementing burst,
    except that if an upper address limit is
    reached, the address wraps around to a
    lower address.
    Commonly used for cache line
    accesses.*/
    WRAP = 2'b10,

    // NOT FOR USE !
    RESERVED = 2'b11
  } burst_enum_t;

endpackage : axi_pkg

`endif
