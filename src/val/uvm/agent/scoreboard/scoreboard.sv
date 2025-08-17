// Basic scoreboard that uses DPI C++ 'model' to get the actual check

class scoreboard extends uvm_component;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp_adder_transaction#(base_transaction, scoreboard) adder_transaction_port;

  function void write_adder_transaction(base_transaction tx);
    bit [ADDER_DATA_WIDTH-1:0] model_o;

    model_o = ADDER_DATA_WIDTH'(dpi_get_sum(tx.a, tx.b));

    `uvm_info("ADDER_CHECKER", 
      $sformatf("Expected %h, got %h", model_o, tx.o),
      UVM_MEDIUM
    );

    if (model_o != tx.o)
      `uvm_error("ADDER_CHECKER", 
        $sformatf("Mismatch: Expected %h, got %h", tx.o, model_o)
      );
  endfunction

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    adder_transaction_port = new("adder_transaction_port", this);
  endfunction

endclass : scoreboard
