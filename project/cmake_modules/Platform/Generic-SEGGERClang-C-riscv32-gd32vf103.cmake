message(DEBUG "[${CMAKE_CURRENT_LIST_FILE}]:\n\tCMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}, SEGGER_CMAKE_BUILTIN_COMPILER_ID=${SEGGER_CMAKE_BUILTIN_COMPILER_ID}")
include(${CMAKE_CURRENT_LIST_DIR}/segger_riscv_v32.cmake)

# Depending on the content of CMAKE_C_FLAGS_INIT, the following switches aimed at the linker may appear 
# multiple times on the final command-line, since for SEGGER the same compiler driver is used for compilation as well as for linking.
# Furthermore, it depends on the project setup, whether CMAKE_C_FLAGS or CMAKE_CXX_FLAGS or CMAKE_ASM_FLAGS get passed to the compiler driver for the link stage.
# Cmake appears to consider the settings in this order of decreasin preference CMAKE_C_FLAGS, CMAKE_CXX_FLAGS, CMAKE_ASM_FLAGS. If the project language settings
# define C, then CMake will use the driver as a "C" linker etc.
if(NOT CMAKE_EXE_LINKER_FLAGS_INIT MATCHES " -mcpu=rv32i")
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -mcpu=rv32i")
endif()

# -- START: Only for internal testing: -- #
execute_process(COMMAND cmake -E echo "${CMAKE_CURRENT_LIST_FILE} has been read." OUTPUT_FILE dump_arch_module_c.txt WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
# -- END: Only for internal testing: -- #
