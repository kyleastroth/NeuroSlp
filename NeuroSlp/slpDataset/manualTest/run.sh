#! /bin/bash

source ../preprocess/configure.sh

commonCl="-O3 -march=native -fno-unroll-loops -mllvm -slp-min-reg-size=512 -mllvm -slp-max-reg-size=512 --save-temps=obj"

file=s1_64_sub_2.unroll.c
# ${CLANG_BIN_PATH} $commonCl -fno-vectorize -fno-slp-vectorize $file header.c -o $file.noslp.o
# mv `basename -s .c $file`.s $file.noslp.s

${CLANG_BIN_PATH} $commonCl -fno-vectorize -fslp-vectorize $file header.c -o $file.slp.o
mv `basename -s .c $file`.s $file.slp.s

# file=s1_64_sub_2.c
# ${CLANG_BIN_PATH} $commonCl -fno-vectorize -fno-slp-vectorize $file header.c -o $file.noslp.o
# mv `basename -s .c $file`.s $file.noslp.s

# ${CLANG_BIN_PATH} $commonCl -fno-vectorize -fslp-vectorize $file header.c -o $file.slp.o
# mv `basename -s .c $file`.s $file.slp.s
