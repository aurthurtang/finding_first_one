module tb;

localparam N = 64;
reg clk;
reg rstb;
reg [N:0] data;

initial begin
 clk <= 1'b0;
 forever #10 clk = ~clk;
end

initial begin
  $timeformat(-9,2,"ps",10);
  $recordfile("tb.trn");
  $recordvars();

  data = 0;
  rstb = 0;
  #5000
  rstb = 1;
  
  repeat(30) @(posedge clk) data = $random;
  
  #1000
  $finish;
end

dut #(N) DUT (
  .clk (clk),
  .rstb (rstb),
  .data (data),
  .out ()
);

endmodule
