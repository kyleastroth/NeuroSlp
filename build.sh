#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CLEAR='\033[0m'

# clean build dir
if [[ $1 == "--clean" ]]; then 
    echo -e "${YELLOW}Cleaning Build...${CLEAR}"
    rm -r build 2> /dev/null
fi

mkdir build 2> /dev/null 
cd build

# build
echo -e "${YELLOW}Build Code...${CLEAR}"
cmake -DCMAKE_BUILD_TYPE=Debug .. && make -j12
buildResult=$?

if (($buildResult != 0)); then
    echo -e "${RED}BUILD ERROR!${CLEAR}"
else
    echo -e "${GREEN}BUILD SUCCESS!${CLEAR}"
fi
