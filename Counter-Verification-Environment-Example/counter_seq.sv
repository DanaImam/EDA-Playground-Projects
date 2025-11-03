`ifndef COUNTER_SEQ
`define COUNTER_SEQ

`include "counter_seq_item.sv"

class counter_seq;

    counter_seq_item seq_item;
    mailbox seq_driver_mb;

    function new(mailbox seq_driver_mb);
        this.seq_driver_mb = seq_driver_mb;
    endfunction

    task generate_trans();
        // Generate transactions for different test cases
        for (int i = 0; i < 10; i++) begin
            seq_item = new();

            // Randomize all inputs
            seq_item.randomize();

            // Display the generated transaction
            $display("Generated transaction: reset=%b, load=%b, data=%b, up_dwn=%b",
                     seq_item.reset, seq_item.load, seq_item.data, seq_item.up_dwn);

            // Put the transaction into the driver mailbox
            seq_driver_mb.put(seq_item);
        end
    endtask

endclass

`endif
