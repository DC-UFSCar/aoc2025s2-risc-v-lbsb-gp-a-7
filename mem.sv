module mem (
  input  logic        clk, we,
  input  logic [31:0] a, wd,
  output logic [31:0] rd,
  input  logic  [3:0] wm);

  logic  [31:0] RAM [0:255];

  // initialize memory with instructions or data
  initial
    $readmemh("riscv.hex", RAM);

  assign rd = RAM[a[31:2]]; // word aligned

 always_ff @(posedge clk)
    if (we)begin
      case (wm)
        4'b1100: RAM[a[31:2]][31:16] <= wd[15:0];
        4'b0011: RAM[a[31:2]][15:0] <= wd[15:0];
        4'b1000: RAM[a[31:2]][31:24] <= wd[7:0];
        4'b0100: RAM[a[31:2]][23:16] <= wd[7:0];
        4'b0010: RAM[a[31:2]][15:8] <= wd[7:0];
        4'b0001: RAM[a[31:2]][7:0] <= wd[7:0];
        default: RAM[a[31:2]] <= wd;
      endcase
    end
endmodule