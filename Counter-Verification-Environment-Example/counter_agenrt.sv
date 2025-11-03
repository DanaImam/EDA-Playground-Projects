`ifndef COUNTER_AGENT
`define COUNTER_AGENT

`include "counter_seq.sv"
`include "counter_driver.sv"
`include "counter_monitor.sv"

class counter_agent;

  counter_seq seq_inst;
  counter_driver driver_inst;
  counter_monitor monitor_inst;

  function new(virtual counter_if intf, mailbox seq_driver_mb, mailbox mon_rf_mb, mailbox mon_sc_mb);
    seq_inst = new(seq_driver_mb);
    driver_inst = new(intf, seq_driver_mb);
    monitor_inst = new(intf, mon_rf_mb, mon_sc_mb);
  endfunction

endclass

`endif
