// synthesis VERILOG_INPUT_VERSION SYSTEMVERILOG_2005

typedef logic [7:0] seg7_t;

module CLOCK1(
	input CLOCK_50,
	input [2:0] KEY,
	output seg7_t HEX0, HEX1, HEX2, HEX3
);

logic RST = 1'b0;
_CLOCK1 _CLOCK1(CLOCK_50, RST, KEY, HEX0, HEX1, HEX2, HEX3);

endmodule

module _CLOCK1(
	input CLK, RST,
	input [2:0] nBUTTON,
	output seg7_t nHEX0, nHEX1, nHEX2, nHEX3
);

wire clr, minup, secup;
BTN_IN b0 (CLK, RST, nBUTTON, {clr, minup, secup});

wire en1hz;

CNT1SEC CNT1SEC(CLK, RST, en1hz);

wire [3:0] min1, sec1;
wire [2:0] min10, sec10;
wire cout, dummy;

CNT60 SECCNT(CLK, RST, clr, en1hz, secup, sec10, sec1, cout);
CNT60 MINCNT(CLK, RST, clr, cout, minup, min10, min1, dummy);

SEG7DEC d0(sec1, nHEX0[6:0]);
SEG7DEC d1(sec10, nHEX1[6:0]);
SEG7DEC d2(min1, nHEX2[6:0]);
SEG7DEC d3(min10, nHEX3[6:0]);

assign nHEX0[7] = 1'b1;
assign nHEX1[7] = 1'b1;
assign nHEX2[7] = 1'b0;
assign nHEX3[7] = 1'b1;

endmodule
