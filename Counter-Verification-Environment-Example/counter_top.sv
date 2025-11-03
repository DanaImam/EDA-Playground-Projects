`ifndef COUNTER_TOP
`define COUNTER_TOP

`include "counter_env.sv"

program counter_top (counter_if intf);
  counter_env counter_env_inst;

  initial begin
    counter_env_inst = new(intf);
    counter_env_inst.run();
  end
endprogram

`endif
