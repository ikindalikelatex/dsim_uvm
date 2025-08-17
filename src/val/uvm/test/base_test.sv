// Base test

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  environment env;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    base_sequence seq;

    phase.raise_objection(this);

    seq = base_sequence::type_id::create("base_sequence");
    if (!seq.randomize())
      `uvm_fatal("RANDOMIZE_FAIL", "Failed to randomize sequence")
    
    seq.print();
    seq.start(env.agent.sequencer);
    
    phase.drop_objection(this);
  endtask

endclass : base_test