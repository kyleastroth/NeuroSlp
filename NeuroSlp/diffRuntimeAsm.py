
import os
import re
import sys


assert len(sys.argv) == 2, f"Expected [executableDir] argument"
executableDir = sys.argv[1]

tmpFilePath = os.path.join(executableDir, "tmp")


files = []
for file in os.listdir(executableDir):
    asmPath = os.path.join(executableDir, file)

    if not asmPath.endswith(".s") or asmPath.endswith("_None_None.s"):
        continue

    files.append(asmPath)

files = [
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s12n_512_sa_assign1_256_-20.s'  ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s13_128_add_5_128_-15.s'        ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s15_256_4096_add_2_256_-20.s'   ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s16_2048_16384_2_3_64_15.s'     ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s16_512_4096_2_1_64_15.s'       ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s18_16384_in_res_256_-15.s'     ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s1_1024_sub_0_256_5.s'          ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s1_128_add_3_256_5.s'           ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s1_512_add_4_256_5.s'           ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s1_64_add_1_256_5.s'            ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s1_64_mul_2_256_5.s'            ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s6_16384_sub_0_256_-15.s'       ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s9n_64_1024_0_x_128_-5.s'       ,
    '/mnt/eecs583/FinalProject/neuro-vectorizer/slpBinCache/s9n_8192_256_3_z_128_-5.s'      ,
]

for asmPath in files:

    O3AsmPath = re.sub("(.*)(_[0-9]*_-?[0-9]*.s)", "\\g<1>_None_None.s", asmPath)

    with open(O3AsmPath, "r") as file:
        O3Conent = file.read()

    with open(asmPath) as file:
        asmContent = file.read()


    exampleSearchStr = "(<example[^>]*>:((.|\n)(?!>:))*)"
    O3Example  = re.search(exampleSearchStr, O3Conent).groups()
    asmExample = re.search(exampleSearchStr, asmContent).groups()

    # print(O3Example)
    # print("---\n")
    # print(newExample)
    # print("\n\n---\n\n")


    if O3Example != asmExample:
        print(f"'{asmPath}' != '{O3AsmPath}'")
        # exit(0)
        
    else:
        print(f"'{asmPath}' == '{O3AsmPath}'")
        

    # os.system(f'diff -sq "{O3AsmPath}" "{fullPath}"')

    # print(O3AsmPath)
    # exit(0)
