module bcd(in, ones, tens);

input [5:0] in;
output reg [3:0] ones;
output reg [3:0] tens;

always @(*) begin
    ones = in[3:0];
    tens = {2'b00,{in[5:4]}};
end

endmodule