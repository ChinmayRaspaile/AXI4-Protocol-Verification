# AXI4-Lite Slave Verification

## Overview

This document describes the verification of an **AXI4-Lite Slave** module using a SystemVerilog testbench. The testbench performs **write and read transactions**, tracks coverage, and logs transaction details.

## Testbench Features

- **Write Transaction Handling**: Sends write requests and checks responses.
- **Read Transaction Handling**: Sends read requests and validates read data.
- **Coverage Metrics**: Tracks read/write operations per register.
- **Transaction Logging**: Logs all operations for debugging.

## Simulation Output

```
Time: 0 | awvalid: 0 | arvalid: 0 | rvalid: x | tb_rdata: 00000000
Reset Done!
Time: 15000 | awvalid: 0 | arvalid: 0 | rvalid: 0 | tb_rdata: 00000000
Time: 25000 | awvalid: 1 | arvalid: 0 | rvalid: 0 | tb_rdata: 00000000
Time: 35000 | awvalid: 0 | arvalid: 0 | rvalid: 0 | tb_rdata: 00000000
Write at 45000: Addr=2, Data=deadbeef
Time: 55000 | awvalid: 0 | arvalid: 1 | rvalid: 1 | tb_rdata: 00000000
Time: 65000 | awvalid: 0 | arvalid: 0 | rvalid: 0 | tb_rdata: deadbeef
Read at 75000: Addr=2, Data=deadbeef
Time: 85000 | awvalid: 1 | arvalid: 0 | rvalid: 0 | tb_rdata: deadbeef
Time: 95000 | awvalid: 0 | arvalid: 0 | rvalid: 0 | tb_rdata: deadbeef
Write at 105000: Addr=4, Data=cafebabe
Time: 115000 | awvalid: 0 | arvalid: 1 | rvalid: 1 | tb_rdata: deadbeef
Time: 125000 | awvalid: 0 | arvalid: 0 | rvalid: 0 | tb_rdata: cafebabe
Read at 135000: Addr=4, Data=cafebabe

==== Coverage Report ====
Total Writes: 2
Total Reads:  2
Address 00000002 accessed 2 times
Address 00000004 accessed 2 times
=========================
```

## Future Enhancements

- **Assertions (SVA)** for read/write validity.
- **Scoreboard** to verify read/write consistency.
- **Randomized Transactions** for better coverage.
- **Functional Coverage Reporting** for detailed test analysis.

This verification framework ensures the correct functionality of the **AXI4-Lite Slave** and provides a foundation for advanced verification techniques. 🚀

Happy Coding! 🚀

