# Day 2: 4-Bit Universal Shift Register (USR)

## 1. System Overview
This project implements a multi-functional **4-Bit Universal Shift Register (USR)**. A Universal Shift Register is a highly versatile sequential logic device capable of storing and manipulating data in multiple operational configurations based on mode control selection pins.

### Multi-Mode Data Interfacing
The hardware transitions between four distinct serial/parallel operational combinations by evaluating a 2-bit routing selection vector (`mod[1:0]`) alongside structural enablement flags (`shift`, `load`, `enb`):

*   **Mode `2'b00` (SISO - Serial-In Serial-Out)**: Data bits are sequentially shifted in from a single-bit input line (`sin`) when `enb == 0` and shifted out sequentially on a single-bit output line (`sout`) when `enb == 1`.
*   **Mode `2'b01` (SIPO - Serial-In Parallel-Out)**: Data stream values are fed into the system serially via `sin` and broadcast concurrently across a 4-bit parallel out-bus array (`p_out`).
*   **Mode `2'b10` (PISO - Parallel-In Serial-Out)**: Captures a 4-bit parallel broadside data packet input (`p_in`) into an internal shadow storage array (`temp`), then reads it out sequentially bit-by-bit via `sout`.
*   **Mode `2'b11` (PIPO - Parallel-In Parallel-Out)**: Intercepts an external 4-bit parallel data packet (`p_in`) on one clock cycle and mirrors it cleanly onto the output bus line (`p_out`) during processing.

---

## 2. Behavioral Implementation Matrix
The hardware architecture is driven inside a synchronous `always @(posedge clk)` block which implements nested conditional branching to decode user operational priorities:

*   **Master Gating Controls**: Shifting and loading routines are globally gated by active high `shift` and `load` overrides.
*   **Synchronous State Operations**: The internal 4-bit register vector array (`reg [3:0] temp`) uses non-blocking assignments (`<=`) to achieve stable tracking parameters, ensuring zero timing race conditions during sequential bit-slicing concatenations like `{sin, temp[3:1]}`.

---

## 3. Interface Signal Dictionary

| Pin Name | Direction | Bit-Width | Functional Description |
| :--- | :---: | :---: | :--- |
| `clk` | Input | 1-bit | Global System Master Clock Trigger Line (Positive Edge Sensitive) |
| `rst` | Input | 1-bit | Active-High Synchronous Internal Register Clear Signal |
| `sin` | Input | 1-bit | Serial Input Line for Serial Shifting Routines |
| `p_in[3:0]` | Input | 4-bit | Broadside Parallel Input Target Vector Bus |
| `shift` | Input | 1-bit | Master Shifting Activation Enable Control |
| `load` | Input | 1-bit | Master Memory Load Overlap Activation Control |
| `enb` | Input | 1-bit | Multiplexed Flag (0: Data Loading/Shifting Mode, 1: Data Output Phase) |
| `mod[1:0]` | Input | 2-bit | Architecture Configuration Selector (00: SISO, 01: SIPO, 10: PISO, 11: PIPO) |
| `sout` | Output | 1-bit | Serial Monitored State Output Bit |
| `p_out[3:0]` | Output | 4-bit | Broadside Parallel Mapped State Output Bus |

---

## 4. Testbench Stimulus Sequence Execution
The verification file (`usr_tb.v`) dynamically routes sequential vector stimulus variations over 10ns intervals to exhaustively sweep across every single operating permutation:

1. **0ns - 10ns (Initialization)**: Asserts `rst_tb = 1` to force the internal registers down to a safe initial value (`4'b0000`).
2. **10ns - 50ns (SISO Testing)**: Activates mode `00`. Streams an alternating bit sequence (`1`, `0`, `1`, `0`) serially inside the shifting registers, then toggles `enb_tb = 1` to dump the array out bitwise.
3. **50ns - 100ns (SIPO Testing)**: Activates mode `01`. Drives serial inputs (`1`, `1`, `0`, `1`), then asserts `enb_tb = 1` to snapshot the full result as a parallel 4-bit bundle on `p_out_tb`.
4. **100ns - 150ns (PISO Testing)**: Activates mode `10`. Loads parallel value `4'b1101`, then drives `enb_tb = 0` to shift it out step-by-step into a serial stream.
5. **150ns - 170ns (PIPO Testing)**: Activates mode `11`. Directly mirrors parallel input packet `4'b1011` over to `p_out_tb`.

---

## 5. 📊 Simulation Waveform
The behavioral simulation was performed using Vivado Simulator. The waveform below demonstrates immediate execution transitions, validating correct functionality across all modes.

![USR Simulation Output](screenshot/usr.png)

---

## 6. Synthesis and Compilation Status
*   **Tool Version**: Xilinx Vivado (v2023.2)
*   **Compilation Results**: 0 Errors, 0 Critical Warnings
*   **Hardware Extraction**: Successfully synthesized. The logic synthesizes perfectly into a compact structure of synchronized flip-flops and mux networks without generating transparent storage latch vulnerabilities.

---

## 7. 🔍 Conclusion
The functional verification of the 4-Bit Universal Shift Register is successful. The simulation records show exact timing matches between mode transitions, bit concatenation operations, and parallel bus assignment phases.


