`ifndef DIV_BY_3_SC
`define DIV_BY_3_SC

`include "div_by_3_seq_item.sv"

class div_by_3_sc;

  mailbox mon_sc_mb;
  mailbox rf_sc_mb;
  div_by_3_seq_item seq_item_act,seq_item_exp;

  function new (mailbox mon_sc_mb, mailbox rf_sc_mb);
    this.mon_sc_mb=mon_sc_mb;
    this.rf_sc_mb=rf_sc_mb;    
  endfunction
  
  task compare ();
    if (mon_sc_mb.num()>0) begin
      mon_sc_mb.get (seq_item_act);
      rf_sc_mb.get  (seq_item_exp);
      
      if (seq_item_act.divl === seq_item_exp.divl) begin
        $display ("Match!!! : seq_item_act.divl=%b  seq_item_exp.divl=%b ",seq_item_act.divl,seq_item_exp.divl);        
      end//compare
      else begin
        $display ("NOT Match!!! : seq_item_act.divl=%b  seq_item_exp.divl=%b ",seq_item_act.divl,seq_item_exp.divl);
      end
      
    end//if
    
  endtask
  
endclass

`endif
