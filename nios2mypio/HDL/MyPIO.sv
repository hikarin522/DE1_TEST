
`default_nettype none

module MyPIO(
  input wire reset,
  input wire clk,
  input wire[1:0] address,
  input wire read,
  output reg[31:0] readdata,
  input wire write,
  input wire [31:0] writedata,
  output wire[7:0] led
);

reg [7:0] led_value;

//Avalon bus write
always@(posedge clk,posedge reset) begin
  if (reset) begin
    led_value <= 8'd0;
  end
  else begin
    if (write) begin
      case (address)
        2'b00:
          led_value <= writedata[7:0];
      endcase
    end
  end
end

//Avalon bus read
always @* begin
  readdata[31:8] = 24'd0;
  case (address)
    2'b00:
      readdata[7:0] <= led_value;
  endcase
end

assign led = led_value;

endmodule
