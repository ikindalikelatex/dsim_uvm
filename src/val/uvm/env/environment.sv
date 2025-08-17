// Basic env

class environment extends uvm_env;
  `uvm_component_utils(environment)

  agent agent;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = agent::type_id::create("agent", this);
  endfunction

  function void end_of_elaboration(uvm_phase phase);
    uvm_root::get().print_topology();
  endfunction

endclass : environment