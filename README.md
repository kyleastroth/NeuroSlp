# Welcome to the [INSERT PROJECT NAME] Repo!
This project is aimed at creating a machine learning heuristics to enhance llvm's super word level parallelism (SLP).

**Table of contents:**
---
> 1. [Getting Started](#gettingStarted)  
>       1.1 [Building the Project](#buildingProject)  
>       1.2 [Running / Debugging Project](#runningProject)  
>       1.3 [Important Notes](#importantNotes)  
---

<br>

<a name="gettingStarted"></a>
## Section 1 - Getting Started
This section will instruct you on how to setup, build and debug the project. 

<br>

<a name="buildingProject"></a>
### Section 1.1 - Building the project
This project was designed to be built with [VSCode](https://code.visualstudio.com/) using Linux. In theory it should be possible to build this project using other operating systems with minor changes to the '.vscode' files, but doing so hasn't been tested.

To build the project you will need to have either downloaded or built the clang version 16.0.0 project from llvm. You can use [this](https://llvm.org/docs/CMake.html) guide if you plan on building clang which will need to be done if you want enable clang debugging symbols.

You will also need to install [CMake](https://cmake.org/). Assuming you are using a debian based Linux distribution this can be achieved with following command:
```bash
sudo apt-get install cmake
```

Finally, you need to install the following VSCode the [Command Variable](https://marketplace.visualstudio.com/items?itemName=rioj7.command-variable) VSCode extension in order to debug the project. The following extensions are also recommended, but not need:
-  [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [C/C++ Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
- [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)
- [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)

Once those dependencies have been installed. Clone the repo with the following command
```bash 
git clone https://github.com/samrg123/eecs583.git
```

Open `eecs583` folder in VSCode and build the project by pressing `Shift+CTRL+B` or running the default build command from the command pallet.

<br>

<a name="runningProject"></a>
### Section 1.2 - Running/Debugging the project
The project can then be launched by running `eecs583/build/launch.sh` or debugged via gdb and via the '(gdb) Launch' Command in VSCode 

<br>

<a name="importantNotes"></a>
### 1.3 -  Some important notes on debugging clang/llvm
If you would like to link clang's source code in the vscode project you can clone llvm in a folder next to the  `eecs583` and use the following script to build llvm.
```bash
#!/bin/bash 

nCores=6
skipCmake=0
useWerror=0

mountFolder=/mnt/eecs583

# Projects to build
llvmProjects=clang;lld;lldb;pstl;cross-project-tests

# Projects not built
## bolt
## llgo
## polly
## openmp
## libclc
## parallel-libs
## debuginfo-tests
## clang-tools-extra
## libc
## libcxx
## libcxxabi
## libunwind
## compiler-rt

# libraries to build with newly build clang compiler
llvmRuntimes=compiler-rt;libc;libcxx;libcxxabi;libunwind

# buildType=RelWithDebInfo
buildType=Debug

function error {
    echo $1
    exit 1
}

# Mount project file to non-whitespace path for build 
if [ ! "$(ls -A $mountFolder)" ]; then
    echo "Mounting Homework Folder to '$mountFolder'"
    sudo mount --bind "$(pwd)/../" /mnt/eecs583/
fi

rm -r build > /dev/null
mkdir build
cd build

if (($skipCmake == 0)); then

    cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=$buildType -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_ENABLE_PROJECTS="$llvmProjects" -DLLVM_ENABLE_RUNTIMES="$llvmRuntimes" -DLLVM_TARGETS_TO_BUILD="X86;ARM;AArch64" -DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_WERROR=$useWerror -DLLVM_USE_LINKER=bfd -DLLVM_PARALLEL_COMPILE_JOBS=$nCores -DLLVM_PARALLEL_LINK_JOBS=$nCores -G "Ninja" ../llvm | tee cmake.log

    result=${PIPESTATUS[0]}
fi

if (($result != 0)); then
    error "CMAKE BUILD FAILED"
fi

ninja install -j$nCores | tee ninja.log
```
 Or, if you've already built llvm, modify the `.vscode/c_cpp_cproperties.json` file and replace `${workspaceFolder}/../llvm-project/llvm/lib/**` with the path to llvm's source code lib folder.

