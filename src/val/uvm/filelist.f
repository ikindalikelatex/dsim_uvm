### UVM filelist
### Must keep order of compilation

# Sequence
+incdir+sequence/items
+incdir+sequence/sequences
sequence/items/sequence_item_pkg.sv
sequence/sequences/sequences_pkg.sv

# Agent (Driver+Sequencer+Monitor)
+incdir+agent/sequencer
+incdir+agent/driver
+incdir+agent/monitor
+incdir+agent/scoreboard
+incdir+agent/coverage
+incdir+agent
agent/scoreboard/dpi_scoreboard_pkg.sv
agent/agent_pkg.sv

# Environment
+incdir+env
env/env_pkg.sv

# Test
+incdir+test
test/test_pkg.sv

