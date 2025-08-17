// Simple adder

module adder #(
  parameter WIDTH = 8
)
(
  adder_interface.adder_dut ifc
);

assign ifc.o = WIDTH'(ifc.a + ifc.b);

endmodule : adder
