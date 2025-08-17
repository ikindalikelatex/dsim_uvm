// Coverage collector, connects to an analysis port from the Monitor

class coverage_collector extends uvm_subscriber#(base_transaction);
  `uvm_component_utils(coverage_collector)

  base_transaction tx;

  covergroup adder_transaction_cg;
    a_input : coverpoint tx.a {
      bins groups[COVERAGE_NUM_AUTO_BINS] = { [0:$] };
    }
    b_input : coverpoint tx.b {
      bins groups[COVERAGE_NUM_AUTO_BINS] = { [0:$] };
    }
    sum : coverpoint tx.o {
      bins groups[COVERAGE_NUM_AUTO_BINS] = { [0:$] };
    }

    option.per_instance = 1;
  endgroup

  // Analysis port to connect to the monitor
  uvm_analysis_port#(base_transaction) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    adder_transaction_cg = new();
  endfunction

  // Method to collect coverage
  virtual function void write(base_transaction t);
    tx = t;
    adder_transaction_cg.sample();
  endfunction

endclass : coverage_collector