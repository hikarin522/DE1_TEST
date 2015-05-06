
module MINCNT(
	input CLK, RST,
	input EN, INC,
	output reg [2:0] QH,
	output reg [3:0] QL,
	output CA
);

always_ff @(posedge CLK, posedge RST) begin
	if (RST)
		QL <= 4'd0;
	else if (EN == 1'b1 || INC == 1'b1)
		QL <= QL == 4'd9 ? 4'd0 : QL + 1'b1;
end

always_ff @(posedge CLK, posedge RST) begin
	if (RST)
		QH <= 3'd0;
	else if ((EN == 1'b1 || INC == 1'b1) && QL == 4'd9)
		QH <= QH == 3'd5 ? 3'd0 : QH + 1'b1;
end

assign CA = (QH == 3'd5 && QL == 4'd9 && EN == 1'b1);

endmodule
