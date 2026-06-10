# Day 2: 2-to-4 Binary Decoder

## 1. System Overview
This project implements a standard combinational **2-to-4 Binary Decoder**. A decoder is a fundamental digital logic block that translates an $n$-bit coded input into a maximum of $2^n$ unique outputs. 

### Functional Behavior
The module takes a 2-bit parallel binary selection input (`b`) and decodes it into a 4-bit active-high output vector (`D`). For each unique combination of the input bits, exactly one corresponding output line is asserted high (`1`), while all other remaining output lines are driven low (`0`). This hardware structure is widely used for address decoding, memory mapping, and data routing controls.

---

## 2. Combinational Implementation Logic
The hardware is described behaviorally using an all-inclusive combinational execution block. Because the logic is entirely combinational, it reacts instantly to any input change without a clock dependency:

*   **Sensitivity List (`@*`)**: The block uses the wildcard sensitivity keyword to ensure the synthesizer maps the conditional statements into a pure look-up structure.
*   **Default Assignments**: A complete case coverage scheme including a `default` state is maintained to ensure the synthesis tool safely constructs pure combinational logic paths without accidentally creating transparent storage latches.

---

## 3. Interface Signal Dictionary

| Pin Name | Direction | Bit-Width | Functional Description |
| :--- | :---: | :---: | :--- |
| `b[1:0]` | Input | 2-bit | Parallel Binary Input Select Code lines |
| `D[3:0]` | Output | 4-bit | Active-High Decoded One-Hot Output Bus |

---

## 4. Testbench Stimulus and Verification Profiles
The verification file (`decoder_tb.v`) exhaustively sweeps through every possible permutation of the input interface to validate complete logic coverage across fixed time intervals:

*   **Vector 1 (`2'b00`)**: Evaluates to `4'b0001` (Output line 0 active).
*   **Vector 2 (`2'b01`)**: Evaluates to `4'b0010` (Output line 1 active).
*   **Vector 3 (`2'b10`)**: Evaluates to `4'b0100` (Output line 2 active).
*   **Vector 4 (`2'b11`)**: Evaluates to `4'b1000` (Output line 3 active).

---

## 5. 📊 Simulation Waveform
The behavioral simulation was performed using Vivado Simulator. The waveform below demonstrates immediate execution transitions, validating correct functionality against the theoretical truth table.

![Decoder Waveform Output](screenshot/decoder_png.png)

---

## 6. Synthesis and Hardware Status
*   **Tool Version**: Xilinx Vivado (v2023.2)
*   **Compilation Quality**: 0 Errors, 0 Critical Warnings
*   **Hardware Architecture**: Successfully compiled. The logical assignments collapse completely down into pure combinational Lookup Tables (LUTs), ensuring tight propagation pathways with zero clock delays.

---

## 7. 🔍 Conclusion
The functional verification of the 2-to-4 Decoder is successful. The timing graphs verify that output transitions match input state shifts without race conditions, proving the operational reliability of the combinational design matrix.

