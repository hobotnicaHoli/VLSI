module top; reg [2:0] dut_oc; reg [3:0] dut_a; reg [3:0] dut_b; wire [3:0] dut_f; reg clk, rst_n; reg cl, ld; reg [3:0] in; reg inc, dec, sr, ir, sl, il; wire [3:0] out; alu alu_inst(dut_oc,
                                                                                                                                                                                       dut_a,
                                                                                                                                                                                       dut_b,
                                                                                                                                                                                       dut_f);
register register_inst(clk, rst_n, cl, ld, in, inc, dec, sr, ir, sl, il, out);

integer i;

initial begin
    clk      = 1'b0;
    rst_n    = 1'b1;
    cl       = 1'b0;
    ld       = 1'b0;
    in       = 4'b0000;
    inc      = 1'b0;
    dec      = 1'b0;
    sr       = 1'b0;
    ir       = 1'b0;
    sl       = 1'b0;
    il       = 1'b0;
    #5 rst_n = 1'b0;
    #0 rst_n = 1'b1;
    for(i = 0; i < 2**11; i = i + 1) begin
        {dut_oc, dut_a, dut_b} = i;
        #5;
    end
    $stop;
    repeat(1000) begin
        #5 clk = ~clk;
        #10
        
        cl  = ($random) % 2;
        ld  = ($random) % 2;
        in  = ($random) % 16;
        inc = ($random) % 2;
        dec = ($random) % 2;
        sr  = ($random) % 2;
        ir  = ($random) % 2;
        sl  = ($random) % 2;
        il  = ($random) % 2;
        
    end
    #10 $finish;
end


always @(out) begin
    $strobe("time = %d, cl = %d, ld = %d, in = %d, inc = %d, dec = %d, sr = %d, ir = %d, sl = %d, il = %d, out = %d", $time, cl, ld, in, inc, dec, sr, ir, sl, il, out);
end

initial begin
    $monitor("time = %4d, oc = %d, a = %d, b = %d, f = %d", $time, dut_oc, dut_a, dut_b, dut_f);
    
end

endmodule
