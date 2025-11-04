`ifndef DIV_BY_3_ENV
`define DIV_BY_3_ENV

`include "div_by_3_agent.sv"
`include "div_by_3_ref_model.sv"
`include "div_by_3_sc.sv"

class div_by_3_env ;

  div_by_3_agent 		div_by_3_agent_ins;
  div_by_3_ref_model 	div_by_3_ref_model_ins;
  div_by_3_sc 			div_by_3_sc_ins;
  
  mailbox seq_driver_mb;
  mailbox mon_rf_mb;
  mailbox mon_sc_mb;
  mailbox rf_sc_mb;

  function new (virtual div_by_3_if intf);
    seq_driver_mb 	= new();
    mon_rf_mb 		= new();
    mon_sc_mb 		= new();
    rf_sc_mb 		= new();

    div_by_3_agent_ins 		= new(intf,seq_driver_mb,mon_rf_mb,mon_sc_mb);
    div_by_3_ref_model_ins 	= new(mon_rf_mb,rf_sc_mb);
    div_by_3_sc_ins 		= new(mon_sc_mb,rf_sc_mb);

  endfunction

  task run ();
    forever begin

      fork
        begin
          div_by_3_agent_ins.div_by_3_seq_ins.generate_trans();
        end//seq
        begin
          div_by_3_agent_ins.div_by_3_driver_ins.drive_trans();
        end//driver
        begin
          div_by_3_agent_ins.div_by_3_moniter_ins.mon_in ();
        end//monitor_in
        begin
          div_by_3_agent_ins.div_by_3_moniter_ins.mon_out ();
        end//monitor_out
        begin
          div_by_3_ref_model_ins.ref_model();
        end//ref_model
        begin
          div_by_3_sc_ins.compare();
        end//scoreboard
      join

    end//forever

  endtask

endclass

`endif
