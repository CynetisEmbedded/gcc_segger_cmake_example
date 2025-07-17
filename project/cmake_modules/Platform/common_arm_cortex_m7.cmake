# Use these settings for Cortex-M7
set(common_TARGET_OPTS_LIST
  -mcpu=cortex-m7
  -mfpu=fpv4-sp-d16
  -mfloat-abi=softfp
  -thumb
)

#-Cleanup-------------------------------------------------------------
list(JOIN common_TARGET_OPTS_LIST " " common_TARGET_OPTS_STR )
unset(common_TARGET_OPTS_LIST)
