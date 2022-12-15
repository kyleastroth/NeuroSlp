#! /bin/bash

files=(
    s12n_512_sa_assign1.c
    s13_128_add_5.c
    s15_256_4096_add_2.c
    s16_2048_16384_2_3.c
    s16_512_4096_2_1.c
    s18_16384_in_res.c
    s1_1024_sub_0.c
    s1_128_add_3.c
    s1_512_add_4.c
    s1_64_add_1.c
    s1_64_mul_2.c
    s6_16384_sub_0.c
    s9n_64_1024_0_x.c
    s9n_8192_256_3_z.c
)

for file in ${files[@]}; do 
    cp -v unrollLoops/$file small/
done

