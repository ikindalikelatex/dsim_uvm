cmake_minimum_required(VERSION 3.20)
project(uvm_practical_guide LANGUAGES C CXX)

# ---- User options ----
set(DSIM_EXECUTABLE dsim                               CACHE FILEPATH "Path to dsim binary")
set(DSIM_TOP        tb_top                             CACHE STRING   "Top-level module for DSim")
set(DSIM_FLAGS      ""                                 CACHE STRING   "Extra DSim flags (e.g. +define+... -sv_seed random)")
set(DSIM_FILELIST   ${CMAKE_SOURCE_DIR}/src/filelist.f CACHE FILEPATH ".f file for DSim")
set(DSIM_UVM_VER    1.2                                CACHE STRING   "UVM version for DSIM")
set(DSIM_HOME       $ENV{DSIM_HOME}                    CACHE PATH     "DSim installation root")
set(UVM_TESTNAME    base_test                          CACHE STRING   "UVM test name for DSIM")

if(NOT DSIM_HOME)
  message(FATAL_ERROR "DSIM_HOME is not set.")
endif()

# ---- CPP lib ----
add_subdirectory(src/cpp)

# ---- Track SV changes via GLOB (rebuild triggers only) ----
file(GLOB_RECURSE SV_SOURCES
     CONFIGURE_DEPENDS
     ${CMAKE_SOURCE_DIR}/src/*.sv
     ${CMAKE_SOURCE_DIR}/src/*.svh)

# ---- Track all .f filelists as dependencies ----
file(GLOB_RECURSE FILELISTS
     CONFIGURE_DEPENDS
     ${CMAKE_SOURCE_DIR}/src/*.f)

if(NOT EXISTS "${DSIM_FILELIST}")
  message(FATAL_ERROR "DSIM_FILELIST not found: ${DSIM_FILELIST}")
endif()

# ---- DSim image build ----
set(DSIM_IMG   sim_image)
set(DSIM_STAMP ${CMAKE_BINARY_DIR}/.dsim_built.stamp)

add_custom_command(
  OUTPUT ${DSIM_STAMP}
  COMMAND ${DSIM_EXECUTABLE}
          -work ${CMAKE_BINARY_DIR}
          -show-ld
          -genimage ${DSIM_IMG}
          -top ${DSIM_TOP}
          -uvm ${DSIM_UVM_VER} 
          -F "${DSIM_FILELIST}"
          ${DSIM_FLAGS}
  COMMAND ${CMAKE_COMMAND} -E touch ${DSIM_STAMP}
  DEPENDS ${DSIM_FILELIST} ${FILELISTS} ${SV_SOURCES} cpp_lib
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "DSim: compiling+elaborating TOP:[${DSIM_TOP}] using [${DSIM_FILELIST}]"
  VERBATIM
)

add_custom_target(dsim_build ALL DEPENDS ${DSIM_STAMP})

# ---- Run simulation ----
add_custom_target(dsim_run
  COMMAND ${DSIM_EXECUTABLE}
          -image ${DSIM_IMG}
          -work ${CMAKE_BINARY_DIR}
          -show-ld
          -uvm ${DSIM_UVM_VER} 
          -sv_lib cpp_lib
          -trace-dpi
          -sv_seed random
          ${DSIM_FLAGS}
          +UVM_TESTNAME=${UVM_TESTNAME}

  COMMAND dcreport -out_dir cov metrics.db
  DEPENDS dsim_build
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "DSim: running TOP:[${DSIM_TOP}] with image:[${DSIM_IMG}]"
  VERBATIM
)
