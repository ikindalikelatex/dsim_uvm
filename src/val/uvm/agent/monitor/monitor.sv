// Monitor

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  virtual adder_interface adder_interface;

  uvm_analysis_port#(base_transaction) analysis_port;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    bit interface_get_success;
    super.build_phase(phase);

    interface_get_success = uvm_config_db#(virtual adder_interface)::get(
      .cntxt(null),
      .inst_name(""),
      .field_name("adder_interface"),
      .value(adder_interface)
    );

    if (!interface_get_success)
      `uvm_fatal("MONITOR", "Failed to get adder_interface")
    
    analysis_port = new("analysis_port", this);
  endfunction

  // Main task to monitor transactions
  virtual task run_phase(uvm_phase phase);
    forever begin
      base_transaction tx;
      @(adder_interface.monitor_cb);

      tx = base_transaction::type_id::create("tx");
      tx.access_type = adder_interface.monitor_cb.access_type;
      tx.a           = adder_interface.monitor_cb.a;
      tx.b           = adder_interface.monitor_cb.b;
      tx.o           = adder_interface.monitor_cb.o;

      analysis_port.write(tx);
    end
  endtask

endclass : monitor