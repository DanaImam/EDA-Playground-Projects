`ifndef COUNTER_IF
`define COUNTER_IF

interface counter_if(input logic clk);

  // Inputs
  logic reset;
  logic load;
  logic [3:0] data;
  logic up_dwn;

  // Outputs
  logic [3:0] out;

endinterface

`endif

