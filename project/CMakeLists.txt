cmake_minimum_required(VERSION 3.22)

#
# This file is generated only once,
# and is not re-generated if converter is called multiple times.
#
# User is free to modify the file as much as necessary
#

# Setup compiler settings
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

# Define the build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# Set the project name
set(CMAKE_PROJECT_NAME project)

if(SEGGER)
    set(CMAKE_SYSTEM_PROCESSOR arm-cortex-m7)
    if(NOT "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules" IN_LIST CMAKE_MODULE_PATH)
        list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules")
    endif()
    project(${CMAKE_PROJECT_NAME})
else()
    project(${CMAKE_PROJECT_NAME})
endif()

# Enable compile command to ease indexing with e.g. clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

# Core project settings
message("Build type: " ${CMAKE_BUILD_TYPE})

# Enable CMake support for ASM and C languages
enable_language(C ASM)

# Create an executable object type
add_executable(${CMAKE_PROJECT_NAME})

# Add STM32CubeMX generated sources
add_subdirectory(cmake/stm32cubemx)

# Link directories setup
target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined library search paths
)

# Add sources to executable
target_sources(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user sources here
)

# Add include paths
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined include paths
)

# Add project symbols (macros)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
    # Add user defined symbols
)

# Remove wrong libob.a library dependency when using cpp files
list(REMOVE_ITEM CMAKE_C_IMPLICIT_LINK_LIBRARIES ob)

# Add linked libraries
target_link_libraries(${CMAKE_PROJECT_NAME}
    stm32cubemx

    # Add user defined libraries
)

if(SEGGER)

set_target_properties(${PROJECT_NAME} PROPERTIES
  LINK_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/segger/SEGGER_Flash.icf)

target_link_options(${PROJECT_NAME} PRIVATE
  -T${CMAKE_CURRENT_SOURCE_DIR}/segger/SEGGER_Flash.icf
  # Set memory regions of device
  -Wl,--add-region:FLASH1=0x200000@0x8000000
  -Wl,--add-region:RAM1=0x80000@0x20000000
  # Application-specific configuration
  -Wl,--defsym=__STACKSIZE__=2048
  -Wl,--defsym=__HEAPSIZE__=2048
  # I/O Configuration
  -Wl,--defsym=__SEGGER_RTL_vfprintf=__SEGGER_RTL_vfprintf_int_nwp
  -Wl,--defsym=__SEGGER_RTL_vfscanf=__SEGGER_RTL_vfscanf_int
  -io=rtt
  # Entry Point
  -e_start
  # Optional settings
  --full-section-headers
  --merge-sections
  --merge-strings
  --map-text
  --map-standard
  --no-outline
  --relax
  --no-springboard
  --no-tail-merge
  --tp-model=auto
  --list-all-undefineds
)

endif()

if(NOT SEGGER)
# Path to objcopy (adjust if not in PATH)
set(OBJCOPY arm-none-eabi-objcopy)

# Add post-build step to generate .bin file from .elf
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${OBJCOPY} -O binary
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.elf
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin
  COMMENT "Converting ELF to BIN")
endif()
