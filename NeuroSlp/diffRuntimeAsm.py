
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
