`ifndef COUNTER_SC
`define COUNTER_SC

`include "counter_seq_item.sv"

class counter_sc;

  mailbox mon_sc_mb;
  mailbox rf_sc_mb;
  counter_seq_item seq_item_act, seq_item_exp;

  function new(mailbox mon_sc_mb, mailbox rf_sc_mb);
    this.mon_sc_mb = mon_sc_mb;
    this.rf_sc_mb = rf_sc_mb;
  endfunction

  task compare();
    if (mon_sc_mb.num() > 0) begin
      mon_sc_mb.get(seq_item_act);
      rf_sc_mb.get(seq_item_exp);

      if (seq_item_act.out === seq_item_exp.out) begin
        $display("Match!!! : seq_item_act.out = %b  seq_item_exp.out = %b", seq_item_act.out, seq_item_exp.out);
      end else begin
        $display("Mismatch!!! : seq_item_act.out = %b  seq_item_exp.out = %b", seq_item_act.out, seq_item_exp.out);
      end
    end
  endtask

endclass

`endif
