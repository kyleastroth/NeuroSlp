

import os
import random
import sys

externalDir = "externalFiles"
externalFiles = ["header.h", "header.c", "obs_encodings.pkl"]

assert len(sys.argv) == 4, "Expected [size] [scanDir] [outputDir] arguments"
size = int(sys.argv[1])
scanDir = sys.argv[2]
outputDir = sys.argv[3]

if not os.path.exists(outputDir):
    os.makedirs(outputDir)
    print(f"Created: '{outputDir}'")

# Copy over external files
for externalFile in externalFiles:
    externalPath = os.path.join(externalDir, externalFile)
    newPath = os.path.join(outputDir, externalFile)
    os.system(f"cp -v '{externalPath}' '{newPath}'")


files = []
for filepath in os.listdir(scanDir):
    
    fileBasename = os.path.basename(filepath)
    if not filepath.endswith(".c") or fileBasename in externalFiles:
        print(f"Skipping '{filepath}'")
        continue

    files.append(os.path.join(scanDir, filepath))


numFiles = len(files)
if size > numFiles:
    print(f"size: {size} > numFiles in '{scanDir}' [{numFiles}] - using all files")
    size = numFiles

sampleFiles = random.sample(files, size)

# Copy over dataset
for file in sampleFiles:
    basename = os.path.basename(file)
    newFile = os.path.join(outputDir, basename)
    
    os.system(f'cp -v "{file}" "{newFile}"')

print(f"Created test set of {size} samples")