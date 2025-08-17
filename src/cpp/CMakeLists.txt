# cpp/CMakeLists.txt
cmake_minimum_required(VERSION 3.20)

# Sources
file(GLOB CPP_SOURCES CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
)

# Build the DPI shared library: cpp_lib.so
add_library(cpp_lib SHARED ${CPP_SOURCES})

# Produce "cpp_lib.so" (no "lib" prefix) and ensure PIC
set_target_properties(cpp_lib PROPERTIES
  PREFIX ""
  POSITION_INDEPENDENT_CODE ON
  BUILD_RPATH "${DSIM_HOME}/lib"
  INSTALL_RPATH "${DSIM_HOME}/lib"
)

target_include_directories(cpp_lib PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${DSIM_HOME}/include
)

# Link against DSim runtime import library
target_link_directories(cpp_lib PRIVATE
  ${DSIM_HOME}/lib
)

# Warnings for this target
target_compile_options(cpp_lib PRIVATE -Wall -Wextra -Wpedantic)

set_target_properties(cpp_lib PROPERTIES
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
)
