`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 20:53:22
// Design Name: 
// Module Name: axi4_lite_slave
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


module axi4_lite_slave (
    input  logic        clk,
    input  logic        reset_n,
    input  logic [3:0]  awaddr,
    input  logic        awvalid,
    output logic        awready,
    input  logic [31:0] wdata,
    input  logic [3:0]  wstrb,
    input  logic        wvalid,
    output logic        wready,
    output logic [1:0]  bresp,
    output logic        bvalid,
    input  logic        bready,
    input  logic [3:0]  araddr,
    input  logic        arvalid,
    output logic        arready,
    output logic [31:0] rdata,  // <- Make sure this is properly assigned
    output logic [1:0]  rresp,
    output logic        rvalid,
    input  logic        rready );

    logic [31:0] reg_mem [0:15]; // 16 registers
    logic write_enable, read_enable;

    assign awready = awvalid;
    assign wready  = wvalid;
    assign bvalid  = write_enable;
    assign arready = arvalid;
    assign rvalid  = read_enable;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            bresp <= 2'b00;
            rresp <= 2'b00;
            rdata <= 32'h00000000;  // <- Initialize rdata to prevent it from being 'XXX'
        end else begin
            if (awvalid && wvalid) begin
                reg_mem[awaddr] <= wdata;
                write_enable <= 1'b1;
            end else begin
                write_enable <= 1'b0;
            end

            if (arvalid) begin
                rdata <= reg_mem[araddr];  // <- Ensure rdata is assigned
                read_enable <= 1'b1;
            end else begin
                read_enable <= 1'b0;
            end
        end
    end
endmodule
