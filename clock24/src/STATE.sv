
module STATE(
	input CLK, RST,
	input SIG2HZ,
	input MODE, SELECT, ADJUST,
	output SECCLR, MININC, HOURINC,
	output SECON, MINON, HOURON
);

typedef enum reg [1:0] {NORM, SEC, MIN, HOUR} state;
state cur, nxt;
//parameter NORM = 2'b00, SEC = 2'b01, MIN = 2'b10, HOUR = 2'b11;

assign SECCLR = (cur == SEC) & ADJUST;
assign MININC = (cur == MIN) & ADJUST;
assign HOURINC = (cur == HOUR) & ADJUST;

assign SECON = ~((cur == SEC) & SIG2HZ);
assign MINON = ~((cur == MIN) & SIG2HZ);
assign HOURON = ~((cur == HOUR) & SIG2HZ);

always_ff @(posedge CLK, posedge RST)
	cur <= RST ? NORM : nxt;

always_ff @* begin
	case (cur)
	NORM:
		nxt = MODE ? SEC : NORM;
	SEC:
		nxt = MODE ? NORM : SELECT ? HOUR : SEC;
	MIN:
		nxt = MODE ? NORM : SELECT ? SEC : MIN;
	HOUR:
		nxt = MODE ? NORM : SELECT ? MIN : HOUR;
	default:
		nxt = NORM;
	endcase
end

endmodule
