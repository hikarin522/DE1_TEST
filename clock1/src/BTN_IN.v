
module BTN_IN (
	input CLK, RST,
	input [2:0] nBIN,
	output reg [2:0]BOUT
);

reg [20:0]cnt;

wire en40hz = (cnt == 1250000 - 1);

always @(posedge CLK, posedge RST)
begin
	if (RST)
		cnt <= 21'b0;
	else if (en40hz)
		cnt <= 21'b0;
	else
		cnt <= cnt + 21'b1;
end

reg [2:0]ff1, ff2;

always @(posedge CLK, posedge RST)
begin
	if (RST)
	begin
		ff2 <= 3'b0;
		ff1 <= 3'b0;
	end
	else if (en40hz)
	begin
		ff2 <= ff1;
		ff1 <= nBIN;
	end
end

wire [2:0]temp = ff1 & ff2 & {3{en40hz}};

always @(posedge CLK, posedge RST)
begin
	if (RST)
		BOUT <= 3'b0;
	else
		BOUT <= temp;
end

endmodule
