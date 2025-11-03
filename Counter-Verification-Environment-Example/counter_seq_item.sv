`ifndef COUNTER_SEQ_ITEM
`define COUNTER_SEQ_ITEM

class counter_seq_item;

  // Input signals
  rand logic [3:0] data;
  rand logic reset;
  rand logic load;
  rand logic up_dwn;

  // Output signal
  logic [3:0] out;

endclass

`endif
