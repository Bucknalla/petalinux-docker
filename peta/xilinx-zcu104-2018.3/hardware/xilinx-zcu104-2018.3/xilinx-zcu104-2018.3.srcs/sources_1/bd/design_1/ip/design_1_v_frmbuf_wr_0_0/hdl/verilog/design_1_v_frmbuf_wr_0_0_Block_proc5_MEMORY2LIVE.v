// ==============================================================
// File generated on Thu Dec 06 04:26:07 MST 2018
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2018.3 (64-bit)
// SW Build 2404976 on Wed Dec  5 18:13:43 MST 2018
// IP Build 2404404 on Wed Dec  5 20:35:07 MST 2018
// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module design_1_v_frmbuf_wr_0_0_Block_proc5_MEMORY2LIVE_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 3;
parameter AWIDTH = 5;
parameter MEM_SIZE = 30;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("./design_1_v_frmbuf_wr_0_0_Block_proc5_MEMORY2LIVE_rom.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) 
    begin
        q0 <= ram[addr0];
    end
end



endmodule

`timescale 1 ns / 1 ps
module design_1_v_frmbuf_wr_0_0_Block_proc5_MEMORY2LIVE(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd3;
parameter AddressRange = 32'd30;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



design_1_v_frmbuf_wr_0_0_Block_proc5_MEMORY2LIVE_rom design_1_v_frmbuf_wr_0_0_Block_proc5_MEMORY2LIVE_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

