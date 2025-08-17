// Base transaction class for UVM sequences
// This class represents a simple transaction item that can be used in UVM sequences.

class base_transaction extends uvm_sequence_item;

  rand bit           [ADDER_DATA_WIDTH-1:0] a, b;
       bit           [ADDER_DATA_WIDTH-1:0] o;
  rand access_type_t                        access_type;

  // Constructor
  function new(string name = "base_transaction");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(base_transaction)
    `uvm_field_enum(access_type_t, access_type, UVM_ALL_ON)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(o, UVM_ALL_ON)
  `uvm_object_utils_end

  // Additional methods and properties can be defined here
endclass : base_transaction