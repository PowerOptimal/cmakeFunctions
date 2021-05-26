# Set correct tuning fo the processor.
#

function(setTargetFlags processor)

  set(cortexM0 STM32F030x4 )
  set(cortexM3 STM32F103xB )
  set(cortexM4 STM32F334x8 STM32F429xx)
  if( processor IN_LIST cortexM0)
    message(STATUS "Cortext M0 found: ${processor}")
    SET(TARGET_FLAGS " -march=ARMv6-M -mtune=cortex-m0 -mthumb -mfloat-abi=soft  -mno-unaligned-access ${CMAKE_CXX_FLAGS}" PARENT_SCOPE)
    add_definitions(-DCORTEX_USE_FPU=0)
  elseif( processor IN_LIST cortexM3)
    message(STATUS "Cortext M3 found: ${processor}")
    SET(TARGET_FLAGS " -march=ARMv7-M -mcpu=cortex-m3 -mfloat-abi=soft -munaligned-access  ${CMAKE_CXX_FLAGS} " PARENT_SCOPE)
    add_definitions(-DCORTEX_USE_FPU=0)
  elseif( processor IN_LIST cortexM4)
    message(STATUS "Cortext M4 found: ${processor}")
    SET(TARGET_FLAGS " -march=ARMv7E-M -mtune=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16  -munaligned-access ${CMAKE_CXX_FLAGS} " PARENT_SCOPE)
    add_definitions(-DCORTEX_USE_FPU=1)
  else()
    message(STATUS "Processor not found: ${processor}")
  endif()
  add_definitions("-D${processor}")

  string(LENGTH processor len)
  string(SUBSTRING ${processor} 0 ${len} PROC_TYPE)
  message(STATUS "Adding Processor defines: [${processor}][${PROC_TYPE}]")
  add_definitions("-D${PROC_TYPE}")

endfunction()

