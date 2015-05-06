
module CNT60(
	input CLK, RST,
	input CLR, CEN, INC,
	output reg [2:0] QH,
	output reg [3:0] QL,
	output CA
);

always @(posedge CLK, posedge RST)
begin
	if (RST)
		QL <= 4'd0;
	else if (CLR)
		QL <= 4'd0;
	else if (CEN == 1'b1 || INC == 1'b1)
	begin
		if (QL == 4'd9)
			QL <= 4'd0;
		else
			QL <= QL + 1'b1;
	end
end

always @(posedge CLK, posedge RST)
begin
	if (RST)
		QH <= 3'd0;
	else if (CLR)
		QH <= 3'd0;
	else if ((CEN == 1'b1 || INC == 1'b1) && QL == 4'd9)
	begin
		if (QH == 3'd5)
			QH <= 3'd0;
		else
			QH <= QH + 1'b1;
	end
end

assign CA = (QH == 3'd5 && QL == 4'd9 && CEN == 1'b1);

endmodule
