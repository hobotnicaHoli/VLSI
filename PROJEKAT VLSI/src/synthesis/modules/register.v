module register #(parameter DATA_WIDTH = 16)(clk, rst_n, cl, ld, in, inc, dec, sr, ir, sl, il, out);

input clk, rst_n, cl, ld;
input [DATA_WIDTH-1:0] in;
input inc, dec, sr, ir, sl, il;
output [DATA_WIDTH-1:0] out;

reg [DATA_WIDTH-1:0] out_reg, out_next;

assign out = out_reg;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        out_reg <= {DATA_WIDTH{1'b0}};
    end
    else begin
        out_reg <= out_next;
    end
end

always @(*) begin
    out_next = out_reg;
    if(cl == 1'b1) begin
        out_next = {DATA_WIDTH{1'b0}};
    end
    else if(ld == 1'b1) begin
        out_next = in;
    end
    else if(inc == 1'b1) begin
        out_next = out_reg + 1;
    end
    else if(dec == 1'b1) begin
        out_next = out_reg - 1;
    end
    else if(sr == 1'b1) begin
        out_next = (out_reg >> 1) | (ir << (DATA_WIDTH-1));
    end 
    else if(sl == 1'b1) begin
        out_next = (out_reg << 1) | (il);
    end
end

endmodule