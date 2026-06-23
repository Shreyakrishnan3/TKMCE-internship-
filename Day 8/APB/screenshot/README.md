# APB Slave Memory Verification Environment

An AMBA APB 3/4 compliant memory slave design with a complete, layered SystemVerilog verification environment utilizing constraint-driven generation, monitors, and scoreboards.

---

## 🗺️ System Topology

```text
                     +-----------------------------------------------+

                     |                  ENVIRONMENT                  |
                     |                                               |
+-----------+        | +-----------+     +--------+     +----------+ |     +------------+

|           |        | |           |     |        |     |          | |     |            |
| GENERATOR |=======>| |  DRIVER   |====>|  DUT   |====>| MONITOR  |====>| SCOREBOARD |
|           | Mailbox| |           | VIF | (top)  | VIF |          ||Mbox|            |
+-----------+        | +-----------+     +--------+     +----------+ |     +------------+
                     +-----------------------------------------------+
```

---

## 🛠️ System Architecture

### Hardware Components
* **`apb_slave`**: Core design containing a 32-bit wide, 256-word deep memory array (`mem [0:256]`). It uses word-aligned indexing by stripping address bits `paddr[9:2]`.
* **`top`**: The top-level hardware wrapper routing interface connections to the slave module.

### Verification IP Infrastructure
* **Transaction (`apb_transaction`)**: Encapsulates bus data. Constrained to enforce 32-bit word alignment (`addr[1:0] == 2'b00`) and boundaries between `0x0000_0000` and `0x0000_03FC`.
* **Generator**: Generates 10 sequence loops of back-to-back randomized write and read transaction pairs targeting matching addresses.
* **Monitor**: Captures structural bus activity from the virtual interface (`apb_if`) and streams completed transaction blocks to checking nodes.
* **Scoreboard**: Implements a SystemVerilog associative array golden model (`internal_mem`) to compare read results against expected data values dynamically.

---

## ⚠️ Protocol Flaw & Verification Impact

The original design updates `prdata` inside a sequential `always_ff` block. This adds a **one-clock-cycle delay** before read data is updated on the bus. 

### Why the Current Monitor Workaround Fails
The provided `monitor.sv` uses an extra clock delay (`@(posedge vif.clk); #1;`) to capture this delayed data. While this works for isolated transfers, **it breaks APB protocol standard specifications and causes data loss or scoreboard mismatch errors** during continuous, back-to-back cycles.

### Recommended Fix

#### 1. Convert `apb_slave.sv` to use Combinational Reads:
```systemverilog
// Assign read data combinations dynamically to eliminate the 1-cycle latency gap
assign prdata = (psel && penable && !pwrite) ? mem[paddr[9:2]] : 32'h0;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    // Reset sequential logic here if necessary
  end else if (psel && penable && pwrite) begin
    mem[paddr[9:2]] <= pwdata;
  end
end
```

#### 2. Revert `monitor.sv` to Standard Zero-Wait Sampling:
```systemverilog
task main();
  forever begin
    @(posedge vif.clk);
    #1; 
    if (vif.psel && vif.penable && vif.pready) begin
      apb_transaction tr = new();
      tr.addr  = vif.paddr;
      tr.write = vif.pwrite;
      if (vif.pwrite) begin
        tr.wdata = vif.pwdata;
      end else begin
        tr.rdata = vif.prdata; // Gathers data immediately on the exact access cycle
      end
      mon2scb.put(tr);
    end
  end
endtask
```

---

## ⏱️ Standard Zero-Wait APB Protocol Execution

Once the fix above is applied, your saved waveform file (`apb_waveform.png`) will reflect a clean, standard 2-cycle protocol format without overlapping clock phase offsets:

| Signal | Setup Cycle (Phase 1) | Access Cycle (Phase 2) |
| :--- | :--- | :--- |
| **`clk`** | ↗️ Rising Edge | ↗️ Rising Edge |
| **`paddr` / `pwrite`** | Driven to stable value | Maintained stable |
| **`psel`** | Asserted (`1'b1`) | Maintained stable |
| **`penable`** | Deasserted (`1'b0`) | Asserted (`1'b1`) |
| **`pwdata` / `prdata`** | Prepared / Tri-stated | Sampled safely on clock edge |

---

## 🚀 Simulation Run Guide

Compile and run the testbench manifest using any standard IEEE 1800 SystemVerilog simulator:

```bash
# Example compilation command using Questa/ModelSim
vlog +incdir+. tb.sv
vsim work.tb -c -do "run -all; quit"
```

### Expected Console Output
```text
[SCB] WRITE: Addr=0x000000a4, Data=0xbeefcafe
[SCB] READ : Addr=0x000000a4
[SCB] MATCH: Expected=0xbeefcafe, Got=0xbeefcafe (SUCCESS)
```

