`ifndef COUNTER_REF_MODEL
`define COUNTER_REF_MODEL

`include "counter_seq_item.sv"

class counter_ref_model;

  mailbox mon_rf_mb;
  mailbox rf_sc_mb;
  counter_seq_item seq_item_in, seq_item_exp;

  logic [3:0] temp;
  bit [3:0] out_exp;

  function new(mailbox mon_rf_mb, mailbox rf_sc_mb);
    this.mon_rf_mb = mon_rf_mb;
    this.rf_sc_mb = rf_sc_mb;
  endfunction

  function void ref_model();
    if (mon_rf_mb.num() > 0) begin
      mon_rf_mb.try_get(seq_item_in);
      seq_item_exp = new();

      // Initialize temp on reset
      if (seq_item_in.reset === 1) begin
        temp = 4'b0000;
      end else begin
        if (seq_item_in.load) begin
          temp = seq_item_in.data;
        end else if (seq_item_in.up_dwn) begin
          temp = temp + 1;
        end else begin
          temp = temp - 1;
        end
      end

      // Expected output
      seq_item_exp.out = temp;

      $display("Time = %t : reset = %b  data = %b  load = %b  up_dwn = %b  out_exp = %b", $time, seq_item_in.reset, seq_item_in.data, seq_item_in.load, seq_item_in.up_dwn, out_exp);
      rf_sc_mb.try_put(seq_item_exp);
    end
  endfunction
endclass

`endif
