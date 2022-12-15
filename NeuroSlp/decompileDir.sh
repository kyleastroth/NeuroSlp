#! /bin/bash

decompileDir=$1

for file in "$decompileDir"/*.o; do

    asmName=${file%.o}.s
    objdump -S "$file" > "$asmName"

    echo "Decompiled: '$file'"

done