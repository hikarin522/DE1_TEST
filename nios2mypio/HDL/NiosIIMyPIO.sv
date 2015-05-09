
module NiosIIMyPIO (
	input CLOCK_50,
	input [3:0] KEY,
	input [9:0] SW,
	output [9:0] LEDR,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

Qsys u0 (
	.clk_clk                    (CLOCK_50),                    //               clk.clk
	.mypio_conduit_end_readdata (LEDR[7:0]), // mypio_conduit_end.readdata
	.reset_reset_n              (1'b1)               //             reset.reset_n
);


endmodule
