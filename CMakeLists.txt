cmake_minimum_required(VERSION 3.30.3)
project(yoga-wrap NONE)

# Package configuration
set(PACKAGE_NAME "yoga")
set(PACKAGE_URL "https://github.com/facebook/yoga.git")
set(PACKAGE_VERSION "v3.2.1")
set(PACKAGE_FOUND_VAR "${PACKAGE_NAME}_FOUND")

# Setup ccache if available
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
   set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
endif()

# Check if yoga is already installed
# to warn the user if they wish to
# reinstall the package
find_package(${PACKAGE_NAME})

if(NOT ${PACKAGE_FOUND_VAR})
  message(STATUS "${PACKAGE_NAME} not found")
else()
  message(WARNING "${PACKAGE_NAME} already installed in the system! Make sure you wish to continue!")
endif()

# Fetch yoga
include(FetchContent)

FetchContent_Declare(
  ${PACKAGE_NAME}
  GIT_REPOSITORY ${PACKAGE_URL}
  GIT_TAG        ${PACKAGE_VERSION}
)

FetchContent_MakeAvailable(${PACKAGE_NAME})

FetchContent_GetProperties(${PACKAGE_NAME})

set(PACKAGE_POPULATED_VAR  "${PACKAGE_NAME}_POPULATED")
set(PACKAGE_SOURCE_DIR_VAR "${PACKAGE_NAME}_SOURCE_DIR")
set(PACKAGE_BINARY_DIR_VAR "${PACKAGE_NAME}_BINARY_DIR")

if(NOT ${PACKAGE_POPULATED_VAR})
  FetchContent_Populate(${PACKAGE_NAME})
  add_subdirectory(${${PACKAGE_SOURCE_DIR_VAR}} ${${PACKAGE_BINARY_DIR_VAR}})
endif()
