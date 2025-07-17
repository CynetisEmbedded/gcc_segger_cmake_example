### Getting Started 


#### Compiling the project with GCC ARM cross compiler : 

- `cd project && mkdir build && cd build`
- `cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/gcc-arm-none-eabi.cmake ..`
- `cmake --build .`

- Add the following to the root `CMakeLists.txt` file to generate a .bin : 

```
# Path to objcopy (adjust if not in PATH)
set(OBJCOPY arm-none-eabi-objcopy)

# Add post-build step to generate .bin file from .elf
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${OBJCOPY} -O binary
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.elf
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin
  COMMENT "Converting ELF to BIN"

```

#### Compiling the project with Segger compiler : 

- Import the segger-toolchain-cmake as a submodule to the current project: https://github.com/SEGGERMicro/segger-toolchain-cmake.git

- Follow the instructions to add necessary toolchain files : 

Ex: 
  
- Create a new folder `$ProjectDir/segger`
- Copy `$StudioDir/samples/Cortex_M_Startup.s`to `$ProjectDir/segger/Cortex_M_Startup.s`
- Copy `$StudioDir/samples/SEGGER_THUMB_Startup.s `to `$ProjectDir/segger/SEGGER_THUMB_Startup.s`
- Copy `$StudioDir/samples/SEGGER_Flash.icf` to `$ProjectDir/segger/SEGGER_Flash.icf`
- Copy the folder `$ProjectDir/segger-toolchain-cmake/Samples/cmake_modules `to `$ProjectDir/cmake_modules`
- Copy/edit files under `$ProjectDir/cmake_modules/Platform/` and adapt to project needs.

*Note* : `$StudioDir` is whereever the Segger Embedded Studio is located

- Patch the CubeMX generated `CMakeLists.txt `file (the root `CMakeLists.txt`)
- Create a build directory (ex. `sbuild`)
- cd `sbuild`
- `cmake -DSEGGER=ON -G "Ninja Multi-Config" --toolchain ../segger-toolchain-cmake/segger-toolchain.cmake -S ..`
- `cmake --build . --config Debug`