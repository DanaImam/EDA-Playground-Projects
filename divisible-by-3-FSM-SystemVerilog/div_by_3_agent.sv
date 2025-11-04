`ifndef DIV_BY_3_AGENT
`define DIV_BY_3_AGENT

`include "div_by_3_seq.sv"
`include "div_by_3_driver.sv"
`include "div_by_3_moniter.sv"

class div_by_3_agent;

  div_by_3_seq 		div_by_3_seq_ins;
  div_by_3_driver 	div_by_3_driver_ins;
  div_by_3_moniter 	div_by_3_moniter_ins;

  function new (virtual div_by_3_if intf ,mailbox seq_driver_mb,mailbox mon_rf_mb,mailbox mon_sc_mb);

    div_by_3_seq_ins 		= new(seq_driver_mb);
    div_by_3_driver_ins 	= new (intf,seq_driver_mb);
    div_by_3_moniter_ins 	= new (intf,mon_rf_mb,mon_sc_mb);


  endfunction

endclass

`endif
