`ifndef DIV_BY_3_SEQ
`define DIV_BY_3_SEQ

`include "div_by_3_seq_item.sv"

class div_by_3_seq;
  
  div_by_3_seq_item seq_item;

  mailbox seq_driver_mb;
  
  function new (mailbox seq_driver_mb);

    this.seq_driver_mb=seq_driver_mb;
    
  endfunction
  
  task generate_trans();
    for (int i =0;i<2;i++) begin
      seq_item = new();
      seq_item.randomize();
//       $display ("bit_number = %b  res_n = %b",seq_item.bit_number,seq_item.res_n);
      seq_driver_mb.put(seq_item);
    end
    
  endtask

endclass

`endif
