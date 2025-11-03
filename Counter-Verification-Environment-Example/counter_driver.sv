`ifndef COUNTER_DRIVER
`define COUNTER_DRIVER

`include "counter_seq_item.sv"
`include "counter_if.sv"

class counter_driver;

    // The driver interacts with the DUT via the interface and mailbox
    virtual counter_if intf;
    mailbox seq_driver_mb;
    counter_seq_item seq_item;

    function new(virtual counter_if intf, mailbox seq_driver_mb);
        this.intf = intf;
        this.seq_driver_mb = seq_driver_mb;
    endfunction
    
    // Drive transactions to the DUT
    task drive_trans();
        forever begin
            @ (posedge intf.clk) begin
                if (seq_driver_mb.try_get(seq_item)) begin
                    // Drive the DUT inputs from the sequence item
                    intf.data <= seq_item.data;
                    intf.load <= seq_item.load;
                    intf.up_dwn <= seq_item.up_dwn;
                    intf.reset <= seq_item.reset;
                end
            end
        end
    endtask

endclass

`endif
