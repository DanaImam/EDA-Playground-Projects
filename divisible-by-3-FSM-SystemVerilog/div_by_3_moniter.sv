`ifndef DIV_BY_3_MONITER
`define DIV_BY_3_MONITER

`include "div_by_3_seq_item.sv"
`include "div_by_3_if.sv"

class div_by_3_moniter;

  virtual div_by_3_if intf;

  mailbox 			mon_rf_mb;
  mailbox 			mon_sc_mb;
  div_by_3_seq_item seq_item_in,seq_item_out;

  function new (virtual div_by_3_if intf,mailbox mon_rf_mb, mailbox mon_sc_mb);

    this.intf=intf;
    this.mon_rf_mb=mon_rf_mb;    
    this.mon_sc_mb=mon_sc_mb;
    
  endfunction
  
  task mon_in ();
     @ (posedge intf.clock) begin
       seq_item_in = new();
       seq_item_in.bit_number	= intf.bit_number;
       seq_item_in.res_n		= intf.res_n;
       mon_rf_mb.put (seq_item_in);       
     end//clk        
  endtask // mon_in
  
  task mon_out ();
     @ (posedge intf.clock) begin
       seq_item_out = new();
       seq_item_out.divl	= intf.divl;
       mon_sc_mb.put (seq_item_out);       
     end//clk        
  endtask // mon_out

endclass

`endif
