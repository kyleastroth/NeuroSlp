import subprocess

def GetRuntime(executablePath, numSamples = 10):

    totalRuntime = 0
    for i in range(numSamples):

        runtimeStr = subprocess.Popen(executablePath, executable='/bin/bash', shell=True, stdout=subprocess.PIPE).stdout.read()
        totalRuntime+= int(runtimeStr)

    avgRuntime = totalRuntime/numSamples
    print(f"Average Runtime for: '{executablePath}' over {numSamples} samples is {avgRuntime}ms")

GetRuntime("./s9_2048_1024_4_None_None.o")
GetRuntime("./s9_2048_1024_4_128_-15.o")