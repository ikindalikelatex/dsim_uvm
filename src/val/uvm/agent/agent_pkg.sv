`include "uvm_macros.svh"

package agent_pkg;
  import uvm_pkg::*;
  import types_pkg::*;
  import parameters_pkg::*;
  import sequence_item_pkg::*;
  import dpi_scoreboard_pkg::*;

  `uvm_analysis_imp_decl(_adder_transaction)

  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "scoreboard.sv"
  `include "coverage_collector.sv"
  `include "agent.sv"

endpackage : agent_pkg