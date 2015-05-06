
module HOURCNT(
	input CLK, RST,
	input EN, INC,
	output reg [1:0] QH,
	output reg [3:0] QL
);

reg [4:0] cnt24;

always_ff @(posedge CLK, posedge RST) begin
	if (RST)
		cnt24 <= 5'd0;
	else if (EN | INC)
		cnt24 <= (cnt24 == 5'd23 ? 5'd0 : cnt24 + 1'b1);
end

logic [3:0] ql;
logic c;
always_ff @* begin
	ql = (cnt24[3:0] + ({1'b0, cnt24[4], cnt24[4], 1'b0}));
	c = (ql > 4'd9);
end

always_ff @* begin
	QL <= c ? ql - 4'd10 : ql;
	QH <= {1'b0, cnt24[4]} + {1'b0, c};
end

endmodule
