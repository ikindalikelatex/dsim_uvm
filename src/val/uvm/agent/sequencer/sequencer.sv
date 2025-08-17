// Sequencer

class sequencer extends uvm_sequencer #(base_transaction);

  `uvm_component_utils(sequencer)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass : sequencer