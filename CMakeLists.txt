cmake_minimum_required(VERSION 3.4.3)

project("Final Project")

find_package(LLVM REQUIRED CONFIG)                  # This will find the shared LLVM build.
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")  # You don't need to change ${LLVM_CMAKE_DIR} since it is already defined.
include(AddLLVM)

add_definitions(${LLVM_DEFINITIONS})               # You don't need to change ${LLVM_DEFINITIONS} since it is already defined.
include_directories(${LLVM_INCLUDE_DIRS})          # You don't need to change ${LLVM_INCLUDE_DIRS} since it is already defined.

# TODO: These are needed to map to llvm source file dirs
#       make sure that we enforce this directory heiarchy somehow
#       or call out to it explicitly in the README
set(HW_ROOT_DIR  ${CMAKE_CURRENT_SOURCE_DIR}/..)
set(HW_MOUNT_DIR /mnt/eecs583)

macro(defaultHwBuild moduleName moduleArg testName)

    # Set global variables
    set(HW_MODULE_ARG    ${moduleArg})
    set(HW_MODULE_FILE   ${CMAKE_CURRENT_SOURCE_DIR}/modules/${moduleName}.cpp)    
    set(HW_MODULE_LIB    ${CMAKE_CURRENT_BINARY_DIR}/${moduleName}.so)    
    set(HW_TEST_FILE     ${CMAKE_CURRENT_SOURCE_DIR}/tests/${testName}.cpp) 
    set(HW_TEST_OBJ      ${CMAKE_CURRENT_BINARY_DIR}/${testName}.bc) 

    # Build Module
    message("\nBuilding HW {\n")    
    message("    HW_MODULE_ARG    = '${HW_MODULE_ARG}'")
    message("    HW_MODULE_FILE   = '${HW_MODULE_FILE}'")
    message("    HW_MODULE_LIB    = '${HW_MODULE_LIB}'\n")
    message("    HW_TEST_FILE     = '${HW_TEST_FILE}'")
    message("    HW_TEST_OBJ      = '${HW_TEST_OBJ}'")
    message("}\n")

    add_llvm_library(
        ${moduleName}   # Name of the shared library that you will generate

        MODULE          # create module (plugin) 
        PLUGIN_TOOL opt # the tool (cmake target) that this module will link against

        # source files
        ${HW_MODULE_FILE}
    )

    # Build test
    execute_process(
        COMMAND clang -emit-llvm ${HW_TEST_FILE} -c -o ${HW_TEST_OBJ}
    )     

endmacro(defaultHwBuild)

macro(createLaunchFiles launchProgram launchArgs launchCode launchCwd)

    # Set global vars
    set(HW_LAUNCH_PROG   ${launchProgram})
    list(JOIN launchArgs "\\\" \\\"" HW_LAUNCH_ARGS)
    list(JOIN launchCode "; " HW_LAUNCH_CODE)
    set(HW_LAUNCH_CWD   ${launchCwd})

    set(HW_LAUNCH_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/launch.sh)
    set(HW_LAUNCH_INPUT  ${CMAKE_CURRENT_BINARY_DIR}/launchInput.json)

    message("\nCreating Launch Files {\n")    
    message("    HW_LAUNCH_PROG   = '${HW_LAUNCH_PROG}'")
    message("    HW_LAUNCH_PROG   = '${HW_LAUNCH_PROG}'")
    message("    HW_LAUNCH_ARGS   = '${HW_LAUNCH_ARGS}'")
    message("    HW_LAUNCH_SCRIPT = '${HW_LAUNCH_SCRIPT}'\n")
    message("    HW_LAUNCH_CODE   = '${HW_LAUNCH_CODE}'")
    message("    HW_LAUNCH_CWD    = '${HW_LAUNCH_CWD}'")
    message("    HW_LAUNCH_INPUT  = '${HW_LAUNCH_INPUT}'")
    message("}\n")

    # Create launch input file
    file(WRITE  ${HW_LAUNCH_INPUT} "{\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_PROG\": \"${HW_LAUNCH_PROG}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_ARGS\": \"${HW_LAUNCH_ARGS}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_SCRIPT\": \"${HW_LAUNCH_SCRIPT}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_CODE\": \"${HW_LAUNCH_CODE}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_CWD\": \"${HW_LAUNCH_CWD}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_LAUNCH_INPUT\": \"${HW_LAUNCH_INPUT}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_MODULE_ARG\": \"${HW_MODULE_ARG}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_MODULE_FILE\": \"${HW_MODULE_FILE}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_MODULE_LIB\": \"${HW_MODULE_LIB}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_TEST_FILE\": \"${HW_TEST_FILE}\",\n")
    file(APPEND ${HW_LAUNCH_INPUT} "\t\"HW_TEST_OBJ\": \"${HW_TEST_OBJ}\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "\t\"HW_ROOT_DIR\": \"${HW_ROOT_DIR}\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "\t\"HW_MOUNT_DIR\": \"${HW_MOUNT_DIR}\"\n")
    file(APPEND ${HW_LAUNCH_INPUT} "}\n")

    # Create launch script
    file(WRITE  ${HW_LAUNCH_SCRIPT} "#!/bin/bash\n\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "# Build Variables: {\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_PROG\": \"${HW_LAUNCH_PROG}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_ARGS\": \"${HW_LAUNCH_ARGS}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_SCRIPT\": \"${HW_LAUNCH_SCRIPT}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_CODE\": \"${HW_LAUNCH_CODE}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_CWD\": \"${HW_LAUNCH_CWD}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_LAUNCH_INPUT\": \"${HW_LAUNCH_INPUT}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_MODULE_ARG\": \"${HW_MODULE_ARG}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_MODULE_FILE\": \"${HW_MODULE_FILE}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_MODULE_LIB\": \"${HW_MODULE_LIB}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_TEST_FILE\": \"${HW_TEST_FILE}\",\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_TEST_OBJ\": \"${HW_TEST_OBJ}\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_ROOT_DIR\": \"${HW_ROOT_DIR}\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "#\t\"HW_MOUNT_DIR\": \"${HW_MOUNT_DIR}\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "# }\n\n")

    file(APPEND ${HW_LAUNCH_SCRIPT} "# Mount project file to non-whitespace path for llvm-build\n") 
    file(APPEND ${HW_LAUNCH_SCRIPT} "if [ ! \"$(ls -A '${HW_MOUNT_DIR}')\" ]; then\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "\techo Mounting Homework Folder to '${HW_MOUNT_DIR}'\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "\tsudo mount --bind '${HW_ROOT_DIR}' '${HW_MOUNT_DIR}' \n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "fi\n\n")

    file(APPEND ${HW_LAUNCH_SCRIPT} "echo \"Exectuting launch script command: { ${HW_LAUNCH_CODE} }\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "${HW_LAUNCH_CODE}\n")

    file(APPEND ${HW_LAUNCH_SCRIPT} "\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "echo -e \"\\n------\\n\"\n")
    file(APPEND ${HW_LAUNCH_SCRIPT} "echo -e \"\\nLAUNCH CODE DONE!\\n\"\n")

    execute_process(
        COMMAND chmod +x ${HW_LAUNCH_SCRIPT} 
        COMMAND_ERROR_IS_FATAL ANY
    )

endmacro(createLaunchScript)


set(launchCwd ${CMAKE_CURRENT_SOURCE_DIR}/tests)

defaultHwBuild(
    finalProjectPass # Module name 
    finalProject     # Module arg
    test0            # test name
)

set(launchProgram /usr/local/bin/opt)
set(launchArgs -enable-new-pm=0 -load ${HW_MODULE_LIB} -${HW_MODULE_ARG} ${HW_TEST_OBJ})

set(launchCode "")
list(APPEND launchCode "echo Launching Final Project")

createLaunchFiles("${launchProgram}" "${launchArgs}" "${launchCode}" "${launchCwd}")
