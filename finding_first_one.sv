module dut #(parameter N = 32) (
  input clk,
  input rstb,
  input [N-1:0] data,
  output reg [$clog2(N)-1:0] out
);


genvar i;
integer j;

wire [N-1:0] first_one;

generate
  assign first_one[N-1] = data[N-1];
  for (i = N-2; i >= 0; i--) begin
    assign first_one[i] = data[i] & ~{|data[N-1:i+1]};
  end
endgenerate

always_ff @(posedge clk or negedge rstb) 
  if (!rstb) begin
    out <= 'b0;
  end else begin
    for (j = N-1; j >=0; j--) begin
      if (first_one[j]) out <= j;
    end
  end
    
endmodule
  

