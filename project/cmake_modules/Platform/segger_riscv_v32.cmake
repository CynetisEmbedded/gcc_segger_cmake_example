set(TARGET_OPT
  -march=rv32i_zicsr_zifencei
  -mabi=ilp32
)
list(JOIN TARGET_OPT " " TARGET_OPT_STR )

# Quick-and-dirty approach. Set these options for all languages here and assume that the project is definitiely using C sources.
# This is just to demonstrate what is possible. The better approach is shown for the ARM target case.
string(APPEND CMAKE_C_FLAGS_INIT   " ${TARGET_OPT_STR}")
string(APPEND CMAKE_CXX_FLAGS_INIT " ${TARGET_OPT_STR}")
string(APPEND CMAKE_ASM_FLAGS_INIT " ${TARGET_OPT_STR}")
unset(TARGET_OPT)
