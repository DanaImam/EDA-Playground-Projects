`ifndef COUNTER_MONITOR
`define COUNTER_MONITOR

`include "counter_seq_item.sv"
`include "counter_if.sv"

class counter_monitor;

    virtual counter_if intf;

    mailbox mon_rf_mb;
    mailbox mon_sc_mb;
    counter_seq_item seq_item_in, seq_item_out;

    function new(virtual counter_if intf, mailbox mon_rf_mb, mailbox mon_sc_mb);
        this.intf = intf;
        this.mon_rf_mb = mon_rf_mb;
        this.mon_sc_mb = mon_sc_mb;
    endfunction

    task mon_in();
        @ (posedge intf.clk) begin
            seq_item_in = new();
            seq_item_in.reset = intf.reset;
            seq_item_in.load = intf.load;
            seq_item_in.data = intf.data;
            seq_item_in.up_dwn = intf.up_dwn;
            mon_rf_mb.put(seq_item_in);
        end
    endtask

    task mon_out();
        @ (posedge intf.clk) begin
            seq_item_out = new();
            seq_item_out.out = intf.out;
            mon_sc_mb.put(seq_item_out);
        end
    endtask

endclass

`endif
