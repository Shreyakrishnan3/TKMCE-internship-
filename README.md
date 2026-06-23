# Portfolio — TKMCE Summer Internship 2026

## Overview
This repository serves as a structured archive of Verilog HDL hardware designs, verification testbenches, and simulation results compiled during the 15-day industrial internship program hosted by TKM College of Engineering.

**Trainee Profile**
* **Name:** Shreya Krishnan
* **Discipline:** Electronics and Communication Engineering
* **Institution:** TKM College of Engineering (TKMCE)
* **Development Environment:** Xilinx Vivado Design Suite
* **Target Language:** Verilog HDL

---

## Program Timeline & Milestones

### Core Details

| Parameter | Description |
| :--- | :--- |
| **Program Title** | 15-Day Hardware Description Language Internship |
| **Host Institution** | TKMCE Department of ECE |
| **Commencement Date** | June 08, 2026 |

### Daily Laboratory Logs

#### 📂 Day 1: Combinational Logic Foundations
* **4-Bit Ripple Carry Adder (RCA):** Modular adder logic implementation and structural optimization.
* **Binary Coded Decimal (BCD) Counter:** Synchronous decade counting sequence verification.

#### 📂 Day 2: Sequential Logic & Modern Registers
* **Combinational Encoder & Decoder Subsystems:** Behavioral description modeling.
* **Universal Shift Register (USR):** Multi-mode (SISO, SIPO, PISO, PIPO) shifting and loading array logic.
* **SR Flip-Flop Array:** Standard memory bistable cell simulation.
* **D Flip-Flop Array:** Edge-triggered state element block processing.

#### 📂 Day 3: Finite State Machines & RTL Synthesis
* **Sequence Detector:** Synchronous finite state machine (FSM) pattern matcher architecture verified via behavioral simulation.
* **Face Scan System:** RTL synthesis, timing optimization, and gate-level hardware mapping for biometric authentication control logic.

#### 📂 Day 4: Memory IP Cores & Subsystems
* **Block Memory Generator (8x8):** Configuration, instantiation, and timing verification of dual-port/single-port block RAM IP blocks within Xilinx Vivado.

#### 📂 Day 5: Standard Communication & Interface Busses
* **BCD Interface:** Design and simulation of binary-coded decimal hardware interfacing and display modules.
* **FIFO Interface:** First-In, First-Out memory buffering interface logic for clock domain boundaries and data rate matching.

#### 📂 Day 6: SystemVerilog Verification Foundations
* **FIFO Transaction:** Implementation of transaction-level modeling (TLM) data packets for advanced FIFO testbench environments.
* **Task Add Class Methods:** Object-Oriented Programming (OOP) construct deployment, utilizing classes, methods, and tasks for verification infrastructure.

#### 📂 Day 8: Advanced Peripheral Bus Protocols
* **APB (Advanced Peripheral Bus) Design:** Implementation of AMBA APB protocol-compliant peripheral slave interfaces, including state machine tracking.
* **Simulation & Screenshots:** Operational waveform analysis and structural hardware schematic validation for APB transaction states.

#### 📂 Integrated Internship Project
* **System Design & Integration:** Full-scale logic architecture mapping combining data processing paths with control logic blocks.
* **Testbench Environment:** Comprehensive verification suite for functional coverage and timing validation under diverse operational corner-cases.

---

## Directory Infrastructure Layout

```text
TKMCE-internship/
├── README.md
├── day1/
│   ├── Ripple_Carry_Adder/
│   │   ├── Design/
│   │   └── Testbench/
│   └── BCD_Counter/
│       ├── Design/
│       └── Testbench/
├── day2/
│   ├── decoder/
│   │   ├── design/
│   │   └── testbench/
│   ├── usr/
│   │   ├── design/
│   │   └── testbench/
│   ├── SR flipflop/
│   │   ├── design/
│   │   └── testbench/
│   └── D flipflop/
│       ├── design/
│       └── testbench/
├── day3/
│   ├── sequence_detector/
│   │   ├── design/
│   │   └── testbench/
│   └── facescansystem/
│       └── design/
├── Day4/
│   ├── Block memory generator(8x8)/
│   └── README.md
├── Day5/
│   ├── BCD inteface/
│   └── fifo interface/
├── Day6/
│   ├── fifo transaction/
│   └── task_add_class_methods/
├── Day 8/APB/
│   ├── design/
│   ├── screenshot/
│   └── simulation/
└── Project/
    ├── Design/
    ├── Screenshots/
    └── testbench/
```

---

## Core Toolchain & Competencies
* **HDL Modeling:** Behavioral, Dataflow, and Structural Verilog descriptions.
* **FSM Design:** Algorithmic State Machine mapping for control unit logic blocks.
* **Logic Synthesis:** Translating register-transfer level (RTL) descriptions into gate-level netlists using Vivado Synthesis.
* **EDA Simulation:** Vivado Behavioral Simulator waveform validation.
* **Version Control:** Git repository structuring and branch workspace management.

---
*This portfolio is actively curated to track academic laboratory progression, architectural code verification, and design metrics.*
