// Code your design here

module counter_up_dwn( clk,reset,data,load,up_dwn,out);  
  parameter SIZE= 2;
  input clk;
  input reset;
  input up_dwn;
  input [SIZE-1:0]data;
  output [SIZE-1:0]out;
  input load;
  reg [SIZE-1:0]out;
  
  initial
    out = 'b0;

  always@(posedge clk)
    if(reset) begin
      out = 'b0;
    end
  else if(load) begin
    out = data[SIZE-1:0];
  end
  else if (up_dwn) begin
    out = out+ 1;
  end
  else begin
    out = out- 1;
  end

endmodule
