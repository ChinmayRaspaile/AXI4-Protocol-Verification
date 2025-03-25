# AXI4-Lite Slave Module and Testbench

## Overview
This project implements a simple **AXI4-Lite Slave** module with a SystemVerilog testbench to verify read and write transactions. The module supports:
- **16 registers (4-bit addressable)**
- **Write transactions** with valid handshaking
- **Read transactions** with valid response handling
- **Coverage tracking** for read/write accesses

## Files Included
- `axi4_lite_slave.sv` - RTL implementation of the AXI4-Lite slave.
- `tb_axi4_lite.sv` - Testbench with basic read/write tests and functional coverage tracking.

## Features Implemented (Part A)
- **Write Operation**: Stores data in a register based on `awaddr`.
- **Read Operation**: Reads stored data when `araddr` is given.
- **Write Response (`bvalid`) Handling**.
- **Read Response (`rvalid`) Handling**.
- **Testbench Tasks for Read/Write Operations**.
- **Coverage Metrics**: Tracks the number of transactions per register.

## Future Enhancements
### **Part B: Advanced Verification Features**
We will extend the testbench with:
- **SystemVerilog Assertions (SVA)** for read/write validity.
- **Scoreboard** for log matching between writes and reads.
- **Randomized Transactions** to improve test coverage.
- **Functional Coverage Reporting** for AXI operations.

### **Part C: Multi-Master Extension**
We will:
- Extend the current slave to interface with an **AXI4-Lite Master**.
- Implement **multiple masters** accessing the same slave.
- Verify multi-master arbitration and conflict resolution.

## Running the Simulation
1. Load the files into your **SystemVerilog simulator** (e.g., Vivado, VCS, Questa).
2. Run the testbench (`tb_axi4_lite.sv`).
3. Check the simulation log for read/write transactions and the **coverage report**.

Stay tuned for **Part B and Part C** as we enhance the design and verification! 🚀

