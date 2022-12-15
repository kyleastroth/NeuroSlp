#! /bin/bash 

clang-14 -O3 -march=native -fno-unroll-loops -fno-vectorize -fslp-vectorize s9_2048_1024_4.c -S -o - | llvm-mca > s9_2048_1024_4_None_None.mcaOut
clang-14 -O3 -march=native -fno-unroll-loops -fno-vectorize -fslp-vectorize -mllvm -slp-max-reg-size=128 -mllvm -slp-threshold=-15 s9_2048_1024_4.c -S -o - | llvm-mca > s9_2048_1024_4_128_-15.mcaOut

