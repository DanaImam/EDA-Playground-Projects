# 4-bit Up/Down Counter with Testbench

**Author:** Dana Imam – Birzeit University – CSE

## Description
This project implements a 4-bit up/down counter in SystemVerilog. 
The counter can:
- Count up or down based on the `up_dwn` signal
- Load a specific value with the `load` signal
- Reset to zero with the `reset` signal

A comprehensive **testbench** is included to verify the functionality of the counter, covering:
- Counting up
- Counting down
- Reset during counting
- Loading a value
- Changing counting direction mid-count

## How to Run
- Open the design and testbench in any SystemVerilog simulator (EDA Playground, Icarus Verilog, or ModelSim)
- Run the simulation to see the `out` signal change according to the test cases
- Waveform output (`dump.vcd`) is provided for visual verification

## Skills Demonstrated
- SystemVerilog coding
- Digital design concepts (counters, reset, load, control signals)
- Verification with testbench
