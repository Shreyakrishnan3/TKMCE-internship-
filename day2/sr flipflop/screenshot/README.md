# Day 2: Gated SR Latch / Flip-Flop Architecture

## 1. System Overview
This project implements a synchronous, level-sensitive **Gated SR (Set-Reset) Storage Module**. The block acts as a fundamental sequential memory cell that captures and maintains a single bit of state based on the levels of its control inputs while gated by an enable/clock signal.

### Functional Behavior
The module evaluates its inputs exclusively when the gate/clock interface signal (`clk`) is driven high (`1`). 
* **Reset State**: A master system reset (`rst`) overrides all input configurations, clearing the internal memory to a safe initial condition.
* **Hold State ($S=0, R=0$)**: The outputs preserve their historical values stably.
* **Reset Mode ($S=0, R=1$)**: Directs the primary output `q` to `0` and inverted output `qbar` to `1`.
* **Set Mode ($S=1, R=0$)**: Directs the primary output `q` to `1` and inverted output `qbar` to `0`.
* **Invalid State ($S=1, R=1$)**: This is an illegal operating state for an SR architecture. The outputs pull into an undefined hardware condition (`'bx`), as both cross-coupled paths try to drive low simultaneously.

---

## 2. Structural RTL Schematic Mapping
The hardware configuration was compiled using Xilinx Vivado to map the conditional assignments into technology-specific FPGA primitives.

![SR Flip-Flop RTL Schematic Diagram](screenshot/sr_ff_schematic.png.png)
*Figure 1: Gate-level structural interconnect schema (`sr_ff_schematic.png.png`)*

### Design Implementation Details
* **Non-Blocking Logic (`<=`)**: Used across all sequential assignment paths to enforce deterministic evaluation and prevent dangerous race conditions during behavioral simulation.
* **Complementary Rails**: The module concurrently drives both the true state output (`q`) and its strictly inverted pair (`qbar`) to provide clean complementary control lines to downstream logic without routing extra inverters.

---

## 3. Interface Signal Dictionary

| Pin Name | Direction | Bit-Width | Functional Description |
| :--- | :---: | :---: | :--- |
| `clk` | Input | 1-bit | Level-Sensitive Gate Enable Activation Pulse |
| `rst` | Input | 1-bit | Synchronous Active-High State Clear Line |
| `s` | Input | 1-bit | Set Control Line (Forces output state high) |
| `r` | Input | 1-bit | Reset Control Line (Forces output state low) |
| `q` | Output | 1-bit | True Internal State Logic Monitor Bit |
| `qbar` | Output | 1-bit | Complementary Inverted State Logic Monitor Bit |

---

## 4. Testbench Stimulus and Waveform Profile
The verification file (`sr_flipflop_tb.v`) introduces an explicit 10ns clock cycle interval pulse sequence to validate state transitions across every key truth table intersection.

### 📊 Behavioral Waveform Output
The execution sequence matches the expected response patterns, verifying that data changes are securely locked out whenever the gate enable pulse falls low.

![Gated SR Simulation Waveform](screenshot/sr_ff.png.png)
*Figure 2: Timing graph showing Set, Reset, Hold, and Invalid operations (`sr_ff.png.png`)*

### Chronological Timing Evaluation
1. **Interval 0-10ns (Reset Phase)**: `rst_tb` is held high. The module forces `q` down to `0` and `qbar` up to `1` on the active phase.
2. **Interval 10-20ns (Hold Mode)**: Inputs are set to $S=0, R=0$. The storage elements hold their cleared values safely.
3. **Interval 20-30ns (Reset Test)**: Inputs move to $S=0, R=1$. The state remains cleared as instructed.
4. **Interval 30-40ns (Set Test)**: Input shifts to $S=1, R=0$. The true output line `q` transitions high cleanly while `qbar` drops low.
5. **Interval 40-50ns (Invalid Test)**: Inputs are driven to $S=1, R=1$. The simulator forces both outputs into the unknown state (`X`), confirming compliance with the theoretical design constraints.

---

## 5. Synthesis Compilation Summary
* **Tool Version**: Xilinx Vivado (v2023.2)
* **Compilation Metrics**: 0 Errors, 0 Critical Warnings
* **Hardware Safe Mode**: All combinational feedforward and feedback elements successfully map to LUT hardware cells, with structural default conditions keeping timing paths highly stable.

* **Tool Version**: Xilinx Vivado (v2023.2)
* **Compilation Metrics**: 0 Errors, 0 Critical Warnings
* **Hardware Safe Mode**: All combinational feedforward and feedback elements successfully map to LUT hardware cells, with structural default conditions keeping timing paths highly stable.

