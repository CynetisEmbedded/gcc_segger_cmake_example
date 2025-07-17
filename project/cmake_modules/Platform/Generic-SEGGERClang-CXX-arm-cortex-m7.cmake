message(DEBUG "[${CMAKE_CURRENT_LIST_FILE}]:\n\tCMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}, SEGGER_CMAKE_BUILTIN_COMPILER_ID=${SEGGER_CMAKE_BUILTIN_COMPILER_ID}")

# Get common_TARGET_OPTS_STR
include(${CMAKE_CURRENT_LIST_DIR}/common_arm_cortex_m7.cmake)
string(APPEND CMAKE_CXX_FLAGS_INIT ${common_TARGET_OPTS_STR})

# Depending on the content of CMAKE_C_FLAGS_INIT, the following switches aimed at the linker may appear 
# multiple times on the final command-line, since for SEGGER the same compiler driver is used for compilation as well as for linking.
# Furthermore, it depends on the project setup, whether CMAKE_C_FLAGS or CMAKE_CXX_FLAGS or CMAKE_ASM_FLAGS get passed to the compiler driver for the link stage.
# Cmake appears to consider the settings in this order of decreasin preference CMAKE_C_FLAGS, CMAKE_CXX_FLAGS, CMAKE_ASM_FLAGS. If the project language settings
# define C, then CMake will use the driver as a "C" linker etc.
if(NOT CMAKE_EXE_LINKER_FLAGS_INIT MATCHES " -mcpu=cortex-m7")
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -mcpu=cortex-m7")
endif()
unset(common_TARGET_OPTS_STR)

# -- START: Only for internal testing: -- #
execute_process(COMMAND cmake -E echo "${CMAKE_CURRENT_LIST_FILE} has been read." OUTPUT_FILE dump_arch_module_cxx.txt WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
# -- END: Only for internal testing: -- #
