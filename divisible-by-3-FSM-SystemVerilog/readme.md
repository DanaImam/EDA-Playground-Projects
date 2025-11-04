# Divisible-by-3 FSM (SystemVerilog)

This project implements a **Finite State Machine (FSM)** that checks whether a binary number
(bitstream input) is **divisible by 3**, one bit at a time.  
The design is written in **SystemVerilog RTL**, and verified using a **structured testbench** 
including Driver, Monitor, Sequencer, Reference Model, and Scoreboard.


This folder contains example SystemVerilog/UVM files provided by my instructor for learning purposes.

Note: These files are instructor-provided examples and not my own work.

---

## 🧠 Design Overview

The FSM has three states:

| State | Meaning                           |
|------|-----------------------------------|
| A    | Remainder = 0 (divisible by 3)    |
| B    | Remainder = 1                     |
| C    | Remainder = 2                     |

The input stream (`bit_number`) is applied bit-by-bit on every clock cycle.
The output (`divl`) is asserted when the number so far is divisible by 3.

---

## 🏗 RTL Module

File: `src/div_by_3.sv`

- Input: `bit_number` (1-bit incoming binary digit)
- Input: `res_n` (active-low reset)
- Output: `divl` (1 = divisible by 3)
- State transitions occur on the rising edge of `clk`.

---

## ✅ Verification Environment

Located in `tb/`

It includes:

| Component | Role |
|----------|------|
| `Sequence` | Generates random input bits |
| `Driver` | Drives signals to DUT |
| `Monitor` | Captures input/output |
| `Reference Model` | Computes expected output |
| `Scoreboard` | Compares DUT vs expected behavior |
| `Environment` | Connects everything together |


