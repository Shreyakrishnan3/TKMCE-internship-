# Day 2: Edge-Triggered D Flip-Flop (DFF)

## 1. System Overview
This project implements a standard **Positive Edge-Triggered D Flip-Flop (DFF)**. The D Flip-Flop is the fundamental building block for sequential logic circuits, registers, and finite state machines (FSMs). 

### Functional Behavior
The module captures the value of the synchronous data input (`d`) exactly at the rising edge of the clock signal (`posedge clk`). The captured value is then transferred to the output register (`q`). Between active clock edges, any transitions or noise on the input data line are completely ignored, allowing the device to store 1 bit of information stably.

---

## 2. Behavioral Implementation Logic
The hardware is described behaviorally using an edge-sensitive procedural block. By tracking the clock edge, Vivado maps this logic directly to physical storage primitives rather than combinational logic gates:

*   **Non-Blocking Assignment (`<=`)**: The code utilizes the `<=$` operator (`q <= d;`) inside the sequential `always` block. This prevents dangerous simulation-synthesis mismatches and race conditions, ensuring that state transitions mirror real physical hardware timing accurately.

---

## 3. Interface Signal Dictionary

| Pin Name | Direction | Bit-Width | Functional Description |
| :--- | :---: | :---: | :--- |
| `clk` | Input | 1-bit | Global Master System Clock Input (Positive Edge Triggered) |
| `d` | Input | 1-bit | Synchronous Serial Data Input Line |
| `q` | Output | 1-bit | Registered Structural State Data Output Bit |

---

## 4. Testbench Stimulus and Loop Profiling
The verification file (`D_flipflop_tb.v`) sets up a procedural `for` loop to drive varying test vectors directly against the clock edges. It dynamically slices bits from an integer variable `m` to alternate data states:

*   **Clock Handshaking**: The loop cleanly forces the clock low (`clk_tb = 0`), sets up the target bit value (`d_tb = m[0]`), waits for a 1ns stabilization period, and drives the clock high (`clk_tb = 1`) to trigger the internal logic.
*   **Monitored Values**: An internal `$monitor` function logs output variations dynamically inside the Vivado simulation terminal window.

---

## 5. 📊 Simulation Results
The behavioral simulation was performed using Vivado Simulator. The waveform below demonstrates accurate synchronization between the clock transitions and output tracking, verifying correct functionality against the theoretical truth table.

![D Flip-Flop Simulation Waveform](screenshot/dff.png)

---

## 6. Synthesis and Hardware Status
*   **Tool Version**: Xilinx Vivado (v2023.2)
*   **Compilation Metrics**: 0 Errors, 0 Critical Warnings
*   **Hardware Primitive Target**: Successfully synthesized. The architecture infers exactly one physical FDRE (Flip-Flop with Clock Enable and Synchronous Reset) primitive cell from the FPGA fabric library.

---

## 7. 🔍 Conclusion
The verification of the edge-triggered D Flip-Flop is successful. The simulation output confirms that the output `Q` updates dynamically only on the active clock edge and holds its value stably between clock cycles, validating the timing metrics.
