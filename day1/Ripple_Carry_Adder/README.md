# Day 1: 4-Bit Ripple Carry Adder (RCA)

## 1. System Overview
This project implements a structural **4-Bit Ripple Carry Adder (RCA)**. The module serves as a core arithmetic foundation block by taking two 4-bit parallel binary numbers along with an incoming carry bit, and computing their exact arithmetic sum.

### The Ripple Effect
The architecture is structured by cascading four independent **Full Adders** in series. The carry output (`carry`) of each lower-order bit stage is directly wired to feed the carry input (`cin`) of the next adjacent higher-order bit stage. The final output carry flag emerges when the carry bits have sequentially "rippled" from the least significant bit (LSB) to the most significant bit (MSB).

---

## 2. Structural Interconnection Architecture
The top-level structural design isolates the bit positions using internal net links (`wire c1, c2, c3`) to stitch the hardware primitives together:

*   **FA1 (Bit 0)**: Processes `A[0]` and `B[0]` with external system `cin`. Generates `S[0]` and internal carry net `c1`.
*   **FA2 (Bit 1)**: Processes `A[1]` and `B[1]` with internal carry `c1`. Generates `S[1]` and internal carry net `c2`.
*   **FA3 (Bit 2)**: Processes `A[2]` and `B[2]` with internal carry `c2`. Generates `S[2]` and internal carry net `c3`.
*   **FA4 (Bit 3)**: Processes `A[3]` and `B[3]` with internal carry `c3`. Generates final system `S[3]` and the ultimate overflow `cout`.

---

## 3. Interface Signal Dictionary

| Pin Name | Direction | Bit-Width | Functional Description |
| :--- | :---: | :---: | :--- |
| `A[3:0]` | Input | 4-bit | Parallel Binary Operand A Input Bus |
| `B[3:0]` | Input | 4-bit | Parallel Binary Operand B Input Bus |
| `cin` | Input | 1-bit | Incoming Carry-In Initialization Bit |
| `S[3:0]` | Output | 4-bit | Final Arithmetic Combined Sum Output Bus |
| `cout` | Output | 1-bit | Outgoing Overflow Carry Bit (MSB Carry Out) |

---

## 4. 📊 Simulation Waveform
Below is the output waveform screenshot verifying the 4-bit Ripple Carry Adder functionality across multiple test vectors:

![RCA Simulation Waveform](screenshot/rca.png)

---

## 5. Synthesis Compilation Status
*   **Tool Version**: Xilinx Vivado (v2023.2)
*   **Compilation Verification**: 0 Errors, 0 Critical Warnings
*   **Hardware Design Cleanliness**: Structural instantiation forms clear combinational data paths, mapping perfectly to standard FPGA LUT primitives without creating unexpected storage latch errors.

---

## 6. Conclusion
The functional verification of the 4-Bit Ripple Carry Adder confirms correct behavior. The propagation data paths correctly handle binary addition arrays, and the carry-out bits cascade accurately through the internal wires to deliver stable, synchronized final values.
