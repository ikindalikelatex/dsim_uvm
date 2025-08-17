// Testbench TOP
`include "uvm_macros.svh"

module tb_top ();
  import uvm_pkg::*;
  import test_pkg::*;
  import parameters_pkg::*;

  bit clk = '0;
  bit rst = '0;

  adder_interface adder_interface (
    .clk(clk),
    .rst(rst)
  );

  adder #(
    .WIDTH(ADDER_DATA_WIDTH) 
  ) adder_dut (
    .ifc(adder_interface)
  );

  // clkgen
  initial forever #1 clk = ~clk;

  // UVM
  initial begin
    uvm_config_db#(virtual adder_interface)::set(
      .cntxt(null),
      .inst_name("*"),
      .field_name("adder_interface"),
      .value(adder_interface)
    );

    run_test();
  end

endmodule : tb_top