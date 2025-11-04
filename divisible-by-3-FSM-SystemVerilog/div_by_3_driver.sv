`ifndef DIV_BY_3_DRIVER
`define DIV_BY_3_DRIVER

`include "div_by_3_seq_item.sv"
`include "div_by_3_if.sv"

class div_by_3_driver;

  virtual 			div_by_3_if intf;
  mailbox 			seq_driver_mb;
  div_by_3_seq_item seq_item;

  function new (virtual div_by_3_if intf,mailbox seq_driver_mb);
    this.intf=intf;
    this.seq_driver_mb=seq_driver_mb;

  endfunction

  task drive_trans ();

    @ (posedge intf.clock) begin
      seq_item = new();
      if (seq_driver_mb.try_get(seq_item)) begin
        intf.bit_number <= seq_item.bit_number;
        intf.res_n 		<= seq_item.res_n;
      end//try_get
    end//clk

  endtask

endclass

`endif
