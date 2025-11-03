`include "counter_if.sv"
`include "counter_top.sv"

module counter_tb;

    // Port declarations
    logic clk = 0;
    logic reset;
    logic [3:0] data;     // 4-bit data signal
    logic load;
    logic up_dwn;
    logic [3:0] out;      // 4-bit output signal

    // Clock Generation
    initial begin
        forever begin
            #4 clk = ~clk; // Clock with frequency of 125 MHz (8 ns period)
        end
    end

    // DUT Connection
    counter_up_dwn counter_dut (
        .clk (clk),
        .reset (reset),
        .data (data),
        .load (load),
        .up_dwn (up_dwn),
        .out (out)
    );

    // Interface Creation
    counter_if intf (
        .clk (clk),
        .reset (reset),
        .data (data),
        .load (load),
        .up_dwn (up_dwn),
        .out (out)
    );

    // Program Connection
    counter_top counter_top_ins (
        .intf (intf)
    );

    initial begin
        // Initialize signals
        reset = 1;
        load = 0;
        data = 4'b0000;
        up_dwn = 1;

        // Assert reset for 7 clock cycles
        #28;
        reset = 0;
        
        // Test Case 1: Count Up
        data = 4'b0000;
        load = 1;
        #8;
        load = 0;
        #32;  // Wait for several clock cycles to observe counting

        // Test Case 2: Count Down
        up_dwn = 0;
        data = 4'b1111;  // Start from maximum value
        load = 1;
        #8;
        load = 0;
        #32;  // Wait for several clock cycles to observe counting

        // Test Case 3: Reset During Count Up
        up_dwn = 1;
        data = 4'b0100;  // Arbitrary start value
        load = 1;
        #8;
        load = 0;
        #16;
        reset = 1;       // Assert reset
        #8;
        reset = 0;       // De-assert reset
        #32;  // Wait to observe the counter behavior after reset

        // Test Case 4: Change up_dwn Signal During Counting
        up_dwn = 1;
        data = 4'b0010;  // Arbitrary start value
        load = 1;
        #8;
        load = 0;
        #16;
        up_dwn = 0;      // Change direction to count down
        #32;  // Wait to observe the counter behavior

        // Finish simulation
        #200;
        $finish;
    end

    // Dump waveforms
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
