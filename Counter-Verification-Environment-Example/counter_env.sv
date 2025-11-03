`ifndef COUNTER_ENV
`define COUNTER_ENV

`include "counter_agent.sv"
`include "counter_ref_model.sv"
`include "counter_sc.sv"

class counter_env;

  counter_agent counter_agent_inst;
  counter_ref_model counter_ref_model_inst;
  counter_sc counter_sc_inst;

  mailbox seq_driver_mb, mon_rf_mb, mon_sc_mb, rf_sc_mb;

  function new (virtual counter_if intf);
    seq_driver_mb = new();
    mon_rf_mb = new();
    mon_sc_mb = new();
    rf_sc_mb = new();

    counter_agent_inst = new(intf, seq_driver_mb, mon_rf_mb, mon_sc_mb);
    counter_ref_model_inst = new(mon_rf_mb, rf_sc_mb);
    counter_sc_inst = new(mon_sc_mb, rf_sc_mb);
  endfunction

  task run();
    forever begin
      fork
        begin
          counter_agent_inst.counter_seq_inst.generate_trans();
        end//seq
        begin
          counter_agent_inst.counter_driver_inst.drive_trans();
        end//driver
        begin
          counter_agent_inst.counter_monitor_inst.mon_in();
        end//monitor_in
        begin
          counter_agent_inst.counter_monitor_inst.mon_out();
        end//monitor_out
        begin
          counter_ref_model_inst.ref_model();
        end//ref_model
        begin
          counter_sc_inst.compare();
        end//scoreboard
      join
    end
  endtask
endclass

`endif

