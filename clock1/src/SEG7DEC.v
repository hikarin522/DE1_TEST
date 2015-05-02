
module SEG7DEC(
	input [3:0]DIN,
	output reg [6:0]nHEX
);

always @*
begin
	case (DIN)
	4'h0:
		nHEX = 7'b1000000;	
	4'h1:
		nHEX = 7'b1111001;
	4'h2:
		nHEX = 7'b0100100;
	4'h3:
		nHEX = 7'b0110000;
	4'h4:
		nHEX = 7'b0011001;
	4'h5:
		nHEX = 7'b0010010;
	4'h6:
		nHEX = 7'b1000010;
	4'h7:
		nHEX = 7'b1011000;
	4'h8:
		nHEX = 7'b0000000;
	4'h9:
		nHEX = 7'b0010000;
	default:
		nHEX = 7'b1111111;
	endcase
end

endmodule
