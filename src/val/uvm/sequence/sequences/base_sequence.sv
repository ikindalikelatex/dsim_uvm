
class base_sequence extends uvm_sequence #(base_transaction);
  rand int tx_count;

  `uvm_object_utils_begin(base_sequence)
    `uvm_field_int(tx_count, UVM_ALL_ON)
  `uvm_object_utils_end


  constraint tx_count_c { tx_count inside { [300:3000] }; }

  // Constructor
  function new(string name = "base_sequence");
    super.new(name);
  endfunction

  // Method to execute the sequence
  virtual task body();
    repeat (tx_count) begin
      req = base_transaction::type_id::create("req");
      start_item(req);

      if (!req.randomize())
        `uvm_fatal("RANDOMIZE_FAIL", "Failed to randomize request")
      finish_item(req);
    end
  endtask

endclass : base_sequence