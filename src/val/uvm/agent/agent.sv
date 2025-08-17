// Agent

class agent extends uvm_agent;
  `uvm_component_utils(agent)

  driver     driver;
  sequencer  sequencer;
  monitor    monitor;
  scoreboard scoreboard;

  coverage_collector coverage_collector;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    driver     = driver::type_id::create("driver", this);
    sequencer  = sequencer::type_id::create("sequencer", this);
    monitor    = monitor::type_id::create("monitor", this);
    scoreboard = scoreboard::type_id::create("scoreboard", this);

    coverage_collector = coverage_collector::type_id::create("coverage_collector", this);
  endfunction

  // Connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Driver to Sequencer
    driver.seq_item_port.connect(sequencer.seq_item_export);

    // Monitor to scoreboard
    monitor.analysis_port.connect(scoreboard.adder_transaction_port);

    // Monitor to coverage collector
    monitor.analysis_port.connect(coverage_collector.analysis_export);
  endfunction

endclass : agent