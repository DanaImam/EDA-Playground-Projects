// Code your testbench here
//Dana Imam --- Birzeit University --- CSE

module counter_up_dwn_tb;

  // port decleration
  reg clk_tb, reset_tb, load_tb, up_dwn_tb;
  reg [3:0] data_tb;
  wire [3:0] out_tb;
  //---------------------------------------

  // Intrernal Variables
  reg [3:0] expected_out_tb;
  //---------------------------------------

  // DUT Connection
  counter_up_dwn #(.SIZE(4)) counter_up_dwn_inst 
  (.clk		(clk_tb),
   .reset		(reset_tb),
   .data		(data_tb),
   .load		(load_tb),
   .up_dwn	(up_dwn_tb),
   .out		(out_tb)
  );
  //---------------------------------------

  // Port Initialization
  initial begin
    clk_tb = 0;
    reset_tb = 1;
    data_tb = 0;
    load_tb = 0;
    up_dwn_tb = 1;
  end // Port Initialization
  //---------------------------------------

  // Reset block
  initial begin
    @(posedge clk_tb)
    reset_tb = 1;
    @(posedge clk_tb)
    reset_tb = 0;
  end // Reset block
  //---------------------------------------

  // Driving data
  initial begin
   #10;
    @(posedge clk_tb)
    // Test Case 1: Count Up
    data_tb = 4'b0010; // Initial value
    load_tb = 1;
    @(posedge clk_tb);
    load_tb = 0;
    @(posedge clk_tb); // Additional clock cycle to ensure load is processed
    up_dwn_tb = 1; // Counting up
    repeat (5) @(posedge clk_tb);


    // Test Case 2: Reset During Counting Up
    reset_tb = 1;
    @(posedge clk_tb)
    reset_tb = 0; // Release reset
    data_tb = 4'b0100; // Set new value after reset
    load_tb = 1;
    @(posedge clk_tb)
    load_tb = 0;
    up_dwn_tb = 1; // Continue counting up
    repeat (5) @(posedge clk_tb);

    // Test Case 3: Count Down
    data_tb = 4'b0100; // Initial value
    load_tb = 1;
    @(posedge clk_tb)
    load_tb = 0;
    up_dwn_tb = 0; // Counting down
    repeat (5) @(posedge clk_tb);

    // Test Case 4: Reset During Counting Down
    reset_tb = 1;
    @(posedge clk_tb)
    reset_tb = 0; // Release reset
    data_tb = 4'b0010; // Set new value after reset
    load_tb = 1;
    @(posedge clk_tb)
    load_tb = 0;
    up_dwn_tb = 0; // Continue counting down
    repeat (5) @(posedge clk_tb);

    // Test Case 5: Changing up_dwn Signal Mid-Count
    data_tb = 4'b0000; // Initial value
    load_tb = 1;
    @(posedge clk_tb)
    load_tb = 0;
    up_dwn_tb = 1; // Start counting up
    repeat (3) @(posedge clk_tb);
    up_dwn_tb = 0; // Change to counting down
    repeat (5) @(posedge clk_tb);

    // Finish simulation
    #100;
    $finish;
  end // Driving data
  //---------------------------------------

  // Reference model & Checker

  always @(posedge clk_tb) begin
    if (reset_tb) begin
      expected_out_tb = 4'b0000;
    end else if (load_tb) begin
      expected_out_tb = data_tb;
    end else if (up_dwn_tb) begin
      expected_out_tb = expected_out_tb + 1;
    end else begin
      expected_out_tb = expected_out_tb - 1;
    end

    if (out_tb === expected_out_tb) begin
      $display("PASS: Time %t | out_tb = %b, expected_out_tb = %b", $time, out_tb, expected_out_tb);
    end else begin
      $display("FAIL: Time %t | out_tb = %b, expected_out_tb = %b", $time, out_tb, expected_out_tb);
    end
  end // Reference model & Checker
  //---------------------------------------


  //CLK GEN
  always begin
    #4 clk_tb = ! clk_tb; // 125 MHz clock
  end// CLK GEN
  //---------------------------------------

  initial begin
    #500;
    $finish;
  end
  //---------------------------------------

  // Dump wave
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end//Dump wave
  //---------------------------------------

endmodule //counter_up_dwn_tb
