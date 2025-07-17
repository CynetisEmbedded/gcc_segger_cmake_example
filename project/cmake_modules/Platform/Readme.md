# Processor Specific Files
## Background
From the [CMake Documentation](https://cmake.org/cmake/help/book/mastering-cmake/chapter/Cross%20Compiling%20With%20CMake.html) we read this:
> CMAKE_SYSTEM_PROCESSOR
> 
>     This variable is optional; it sets the processor or hardware name of the target system. It is used in CMake for one purpose, to load the ${CMAKE_SYSTEM_NAME}-COMPILER_ID-${CMAKE_SYSTEM_PROCESSOR}.cmake file. This file can be used to modify settings such as compiler flags for the target. You should only have to set this variable if you are using a cross-compiler where each target needs special build settings. The value can be chosen freely, so it could be, for example, i386 IntelPXA255, or MyControlBoardRev42.

## Implementation
We can use the behaviour of CMake as documented above to move cpu/architecture specific toolchain settings into the files within this folder. By appending this folder to `CMAKE_MODULE_PATH` in the project `CMakeLists.txt`, we make sure that
these files get processed accordingly during cmakes compiler detection phase.
```CMake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules")
```
**NOTE:** the `COMPILER_ID` as mentioned in the documentation is actually a combination of the compiler ID + compiler language. Therefore for GNU/gcc `COMPILER_ID` may be `GNU-C` and for SEGGER `COMPILER_ID` may be `SEGGERClang-C` or `SEGGERClang-CXX` etc.
