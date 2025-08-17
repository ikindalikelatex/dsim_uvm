// Driver

class driver extends uvm_driver #(base_transaction);
  `uvm_component_utils(driver)

  virtual adder_interface adder_interface;

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
      `uvm_fatal("DRIVER", "Failed to get adder_interface")
  endfunction

  // Main task to drive transactions
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(adder_interface.driver_cb);

      seq_item_port.get_next_item(req);
      //`uvm_info("DRIVER", "Driving transaction", UVM_HIGH)
      //req.print();

      // Drive the values
      adder_interface.driver_cb.a           <= req.a;
      adder_interface.driver_cb.b           <= req.b;
      adder_interface.driver_cb.access_type <= req.access_type;

      seq_item_port.item_done();
    end
  endtask

endclass : driver