
module CNT1SEC(
	input CLK, RST,
	output EN1HZ
);

reg [25:0] cnt;

always @(posedge CLK, posedge RST)
begin
	if (RST)
		cnt <= 26'b0;
	else if (EN1HZ)
		cnt <= 26'b0;
	else
		cnt <= cnt + 1'b1;
end

assign EN1HZ = (cnt == 26'd49999999);

endmodule
