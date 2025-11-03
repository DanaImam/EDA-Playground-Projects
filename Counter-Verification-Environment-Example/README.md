# Counter Verification Environment Example

This folder contains example SystemVerilog/UVM files provided 
by my instructor for learning purposes.

> Note: These files are instructor-provided examples and not my own work.

## Project Overview

- Demonstrates how to verify an up/down counter module using a UVM-like environment.
- Introduces key verification concepts: Sequence, Driver, Monitor, Agent, Reference Model, Scoreboard, and Environment.
- Allows simulation of counter functionality and automatic checking of expected vs actual outputs.

## Project Components

1. **counter_up_dwn.sv** - The DUT (Device Under Test), a simple up/down counter.
2. **counter_if.sv** - Interface between the DUT and verification environment.
3. **counter_seq_item.sv** - Defines transactions with input and output signals.
4. **counter_seq.sv** - Generates transactions to drive the DUT.
5. **counter_driver.sv** - Applies the transactions to the DUT signals.
6. **counter_monitor.sv** - Observes DUT signals and forwards them to the reference model and scoreboard.
7. **counter_ref_model.sv** - Computes expected outputs for verification.
8. **counter_sc.sv** - Scoreboard that compares expected vs actual outputs.
9. **counter_agent.sv** - Combines sequence, driver, and monitor for easy management.
10. **counter_env.sv** - The environment that instantiates agent, reference model, and scoreboard.
11. **counter_top.sv** - Top program that runs the environment simulation.
12. **counter_tb.sv** - Testbench for simple direct simulation of the DUT.

## How to Use

1. Compile all files in a SystemVerilog simulator (EDA, ModelSim, Vivado, etc.).
2. Run the simulation via `counter_top` or `counter_tb`.
3. Observe matches/mismatches on the console or waveform viewer.

> This project is primarily for learning verification concepts in SystemVerilog.
