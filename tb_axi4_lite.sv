`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 20:54:17
// Design Name: 
// Module Name: tb_axi4_lite
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_axi4_lite;
    logic clk, reset_n;
    logic [3:0] awaddr, araddr;
    logic awvalid, arvalid, wvalid, wready, awready, arready, rvalid, bvalid, rready, bready;
    logic [31:0] wdata, rdata, tb_rdata;
    logic [3:0] wstrb;
    logic [1:0] bresp, rresp;

    // Instantiate AXI4-Lite Slave DUT
    axi4_lite_slave dut (
        .clk(clk), .reset_n(reset_n),
        .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
        .wdata(wdata), .wstrb(wstrb), .wvalid(wvalid), .wready(wready),
        .bresp(bresp), .bvalid(bvalid), .bready(bready),
        .araddr(araddr), .arvalid(arvalid), .arready(arready),
        .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready));

    // Clock Generation: 10ns Period
    always #5 clk = ~clk;

    // Coverage Counters (Manual Approach)
    int write_count = 0;
    int read_count = 0;
    int addr_coverage[16] = '{default: 0};

    // AXI Write Task
    task axi_write(input [3:0] addr, input [31:0] data);
        begin
            @(posedge clk);
            awaddr  = addr;
            wdata   = data;
            awvalid = 1;
            wvalid  = 1;
            wstrb   = 4'b1111;

            // Wait for handshake
            wait (awready && wready);
            @(posedge clk);
            awvalid = 0;
            wvalid  = 0;

            // Wait for write response
            wait (bvalid);
            bready = 1;
            @(posedge clk);
            bready = 0;

            // Increment coverage metrics
            write_count++;
            addr_coverage[addr]++;

            // Log Write Operation
            $display("Write at %0t: Addr=%h, Data=%h", $time, addr, data);
        end
    endtask

    // AXI Read Task
    task axi_read(input [3:0] addr, output logic [31:0] data_out);
        begin
            @(posedge clk);
            araddr  = addr;
            arvalid = 1;

            // Wait for address handshake
            wait (arready);
            @(posedge clk);
            arvalid = 0;

            // Wait for valid data
            wait (rvalid);
            tb_rdata = rdata;
            data_out = rdata;
            rready = 1;
            @(posedge clk);
            rready = 0;

            // Increment coverage metrics
            read_count++;
            addr_coverage[addr]++;

            // Log Read Operation
            $display("Read at %0t: Addr=%h, Data=%h", $time, addr, data_out);
        end
    endtask

    // Test Sequence
    initial begin
        clk = 0;
        reset_n = 0;
        awaddr = 0;
        araddr = 0;
        awvalid = 0;
        wvalid = 0;
        arvalid = 0;
        rready = 0;
        bready = 0;
        tb_rdata = 32'h00000000;

        // Reset Phase
        #10 reset_n = 1;
        $display("Reset Done!");

        // Write & Read Transactions
        #10 axi_write(4'h2, 32'hDEADBEEF);
        #10 axi_read(4'h2, tb_rdata);

        #10 axi_write(4'h4, 32'hCAFEBABE);
        #10 axi_read(4'h4, tb_rdata);

        // Print Coverage Report
        $display("\n==== Coverage Report ====");
        $display("Total Writes: %0d", write_count);
        $display("Total Reads:  %0d", read_count);
        for (int i = 0; i < 16; i++) begin
            if (addr_coverage[i] > 0) 
                $display("Address %h accessed %0d times", i, addr_coverage[i]);
        end
        $display("=========================");

        #20;
        $finish;
    end

    // Monitor Signals
    initial begin
        $monitor("Time: %0t | awvalid: %b | arvalid: %b | rvalid: %b | tb_rdata: %h", 
                 $time, awvalid, arvalid, rvalid, tb_rdata);
    end

endmodule

