interface adder_interface(
  input logic clk,
  input logic rst
);
  import types_pkg::*;
  import parameters_pkg::*;

  logic [ADDER_DATA_WIDTH-1:0] a, b, o;
  access_type_t access_type;

  clocking driver_cb @(posedge clk);
    default input #1step output #1ns;
    output a, b;
    output access_type;
    input  o;
  endclocking

  clocking monitor_cb @(posedge clk);
    default input #1step output #1ns;
    input a, b, o;
    input access_type;
  endclocking

  modport adder_dut(
    input  a, b,
    output o
  );

endinterface : adder_interface