import os
import re
import sys

unrollPragma = "#pragma unroll(512)\n"

excludedPaths = ["header.c"]

assert len(sys.argv) == 3, "Expected [scanDir] [outputDir] arguments"
scanDir = sys.argv[1]
outputDir = sys.argv[2]

if not os.path.exists(outputDir):
    os.makedirs(outputDir)
    print(f"Created: '{outputDir}'")

for filepath in os.listdir(scanDir):
    
    fileBasename = os.path.basename(filepath)
    if not filepath.endswith(".c") or fileBasename in excludedPaths:
        print(f"Skipping '{filepath}'")
        continue

    # replace pragmas
    fullPath = os.path.join(scanDir, filepath)
    newFileContent = ""
    with open(fullPath, "r") as file:

        for line in file:
        
            if "#pragma" in line:
                print(f"In file: '{fullPath}' | replacing: '{line.strip()}' with: '{unrollPragma.strip()}'")
                newFileContent+= unrollPragma
            
            else:
                # Rename 'example0_foo' to 'example'
                processedLine = re.sub("example[A-z_0-9]*", "example", line)
                newFileContent+= processedLine

    # write new file
    with open(os.path.join(outputDir, fileBasename), "w") as file:
        file.write(newFileContent)

    # exit(0)

