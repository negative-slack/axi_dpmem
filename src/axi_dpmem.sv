module axi_dpmem (
    axi_if.slv_mp axi_slv
);

  data_t MEM[0:`MEM_DEPTH-1];

  typedef enum logic [2:0] {
    IDLE,
    AW_CHANNEL,
    W_CHANNEL,
    B_CHANNEL,
    AR_CHANNEL,
    R_CHANNEL
  } fsm_enum_t;

  fsm_enum_t write_state, read_state;

  addr_t reg_aw_addr;
  bit reg_aw_size;
  bit reg_aw_burst;
  bit reg_aw_len;

  bit reg_w_data;
  bit reg_w_strb;
  bit reg_w_last;

  addr_t reg_ar_addr;
  bit reg_ar_size;
  bit reg_ar_burst;
  bit reg_ar_len;

  always_ff @(posedge axi_slv.ACLK or negedge axi_slv.APRESETn) begin
    if (!axi_slv.APRESETn) begin
      axi_slv.AW_READY <= 0;
      axi_slv.W_READY  <= 0;
      axi_slv.B_VALID  <= 0;
      axi_slv.B_RESP   <= 0;

      write_state      <= IDLE;
    end else begin
      case (write_state)

        IDLE: begin
          if (axi_slv.APRESETn) begin
            axi_slv.AW_READY <= 1;
            axi_slv.W_READY  <= 1;
            write_state      <= AW_CHANNEL;
          end else begin
            write_state <= IDLE;
          end
        end

        AW_CHANNEL: begin
          if (axi_slv.AW_VALID && axi_slv.AW_READY) begin
            reg_aw_addr  <= axi_slv.AW_ADDR;
            reg_aw_size  <= axi_slv.AW_SIZE;
            reg_aw_burst <= axi_slv.AW_BURST;
            reg_aw_len   <= axi_slv.AW_LEN;
            if (axi_slv.W_VALID) begin
              axi_slv.AW_READY <= 1;  // READY FOR THE NEXT AW CHANNEL TRANSACTION
              write_state <= AW_CHANNEL;
              axi_slv.bvalid <= 1;
            end else begin
              axi_slv.AW_READY <= 0;  // NOT READY FOR THE NEXT AW CHANNEL TRANSACTION
              write_state <= W_CHANNEL;
              if (axi_slv.B_READY && axi_slv.bvalid) begin
                axi_slv.bvalid <= 0;
              end
            end
          end else begin
            write_state <= AW_CHANNEL;
            if (axi_slv.B_READY && axi_slv.bvalid) begin
              axi_slv.bvalid <= 0;
            end
          end
        end

        W_CHANNEL: begin
          if (axi_slv.W_VALID && axi_slv.W_READY) begin
            reg_w_data <= axi_slv.W_DATA;
            reg_w_strb <= axi_slv.W_STRB;
            reg_w_last <= axi_slv.W_LAST;
          end
        end

        default: begin
        end

      endcase
    end
  end

endmodule : axi_dpmem

// wave: 'x.365x|=.x', data: ['head', 'body', 'tail', 'data']},
