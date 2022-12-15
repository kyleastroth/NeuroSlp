'''
Copyright (c) 2019, Ameer Haj Ali (UC Berkeley), and Intel Corporation
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
'''
import os
import re
import pickle
import subprocess
from extractor_c import CExtractor
import logging
import copy

logger = logging.getLogger(__name__)

#the maximum number of leafs in the LLVM abstract sytnax tree
MAX_LEAF_NODES = os.environ['MAX_LEAF_NODES'] if 'MAX_LEAF_NODES' in os.environ else str(48)
TEST_SHELL_COMMAND_TIMEOUT = os.environ['TEST_SHELL_COMMAND_TIMEOUT'] if 'TEST_SHELL_COMMAND_TIMEOUT' in os.environ else str(12)

if "CLANG_PATH" not in os.environ:
    os.environ["CLANG_PATH"] = "/usr/local/lib/libclang.so"

if "CLANG_BIN_PATH" not in os.environ:
    os.environ["CLANG_BIN_PATH"] = "/usr/local/bin/clang"

pragma_line = "#pragma unroll"
commonLlvmArgs = "-O3 -march=native -fno-unroll-loops -fno-vectorize -fslp-vectorize"

def init_runtimes_dict(files, num_loops, param1, param2):
    '''Used to initialize runtimes dict that stores 
    runtimes for all the files and loops for 
    different param1/param2 during training to save time.'''
    runtimes = {}
    one_program_runtimes = [[None]*param2 for vf in range(param1)]
    for f in files:
        runtimes[f] = {}
        for l in range(num_loops[f]):
            runtimes[f][l] = copy.deepcopy(one_program_runtimes)
    return runtimes

def rename_contents(rundir, contents):
    '''Takes in a run directory, and the contents of the pkl file, renames the directory of the contents
    of the pkl file based on the new rundir specified. It is useful when the user reuses the provided pkl
    file with new rundir.'''
    new_contents = {} 
    for key in contents.keys():
        value = contents[key] 
        suffix_filename = key.split('/')[-1]  # extracts the file name 
        new_path = os.path.join(rundir, suffix_filename)
        new_contents[new_path] = value
    return new_contents 

def get_snapshot_from_code(code,loop_idx=None):
    ''' take snapshot of the loop code and encapsulate
     in a function declaration so the parser can output
     AST tree.'''
    new_code =[]
    if loop_idx:
        new_code.append('__attribute__((noinline))\n')
        new_code.append('void example() {\n')
        new_code.extend(code[loop_idx[0]:loop_idx[1]+1])
        new_code.extend('}\n')
        return new_code
    found = False
    for line in code:
        if '__attribute__' in line:
            found = True
        if 'int main(' in line:
            break
        if found:
            new_code.append(line)
    return new_code

# TODO: Also search cacheDir
def get_encodings_from_local(rundir):
    '''returns encodings from obs_encodings.pkl if 
    file exists in trainig directory.'''
    encodings = {}
    print('Checking if local obs_encodings.pkl file exists.') 
    if os.path.exists(os.path.join(rundir,'obs_encodings.pkl')):
        print('found local obs_encodings.pkl.')
        with open(os.path.join(rundir,'obs_encodings.pkl'), 'rb') as f:
            return rename_contents(rundir, pickle.load(f))

    return encodings

def llvmCompile(filepath, llvmCompileArgs, executablePath):
    '''
        compile the filepath with the provided llvmCompilerArgs and outputs it `executablePath`.
    '''

    clangPath = os.environ['CLANG_BIN_PATH']
    headerPath = os.path.join(os.path.dirname(filepath), 'header.c')

    compileCommand = f"timeout {TEST_SHELL_COMMAND_TIMEOUT} {clangPath} {llvmCompileArgs} -lm " \
                     f"{headerPath} {filepath} -o {executablePath}"

    os.system(compileCommand)

def makeCacheFile(filepath, cacheDir, log = False):
    '''Atomically moves the filepath the cacheDir'''

    if cacheDir is None:
        return filepath
        
    os.system(f'mv "{filepath}" "{cacheDir}"/')

    if log:
        print(f"Moved '{filepath}' to global cacheDir: '{cacheDir}'")

    return 

def compileExecutable(rundir, filename, executableName, slpMaxRegSize, slpThreshold, cacheDir = None, log = False):
    
    compilerArgs = commonLlvmArgs
    if slpMaxRegSize is not None:
        compilerArgs+= f" -mllvm -slp-max-reg-size={slpMaxRegSize}"

    if slpThreshold is not None:
        compilerArgs+= f" -mllvm -slp-threshold={slpThreshold}"

    sourceFile = os.path.join(rundir, filename)
    
    # Note: we compile locally first and then use 
    # the os to atomically move the file to cache dir to prevent race conditions 
    localExecutablePath = os.path.join(rundir, executableName)

    if log:
        print(f"Compiling '{filename}' | llvmArgs: '{compilerArgs}' | localExecutablePath: '{localExecutablePath}'")
        
    llvmCompile(sourceFile, compilerArgs, localExecutablePath)
    makeCacheFile(localExecutablePath, cacheDir)


def getExecutableName(filepath, slpMaxRegSize=None, slpThreshold=None):

    sourceName, sourceExtension = os.path.splitext(os.path.basename(filepath))

    suffix = f"_{slpMaxRegSize}_{slpThreshold}.o"
    return sourceName + suffix


def getCachedPath(rundir, filename, cacheDir = None):

    # Use local rundir as cache if cacheDir isn't specified
    baseDir = rundir if cacheDir is None else cacheDir
    return os.path.join(baseDir, filename)


def getDisassembly(rundir, filename, slpMaxRegSize = None, slpThreshold = None, cacheDir = None):

    executableName = getExecutableName(filename, slpMaxRegSize, slpThreshold)
    
    asmName = executableName+".s"
    asmPath = getCachedPath(rundir, asmName, cacheDir )

    if not os.path.exists(asmPath):

        executablePath = getCachedPath(rundir, executableName, cacheDir)
        
        # Make sure the executable has already been compiled before disassembling
        if not os.path.exists(executablePath):
            compileExecutable(rundir, filename, executableName, 
                              slpMaxRegSize, slpThreshold, cacheDir)

        localAsmPath = os.path.join(rundir, asmName)
        os.system(f"gdb -batch -ex 'file \"{executablePath}\"' -ex 'disassemble example' > '{localAsmPath}'")
        
        # Note: this will move localAsm to asmPath
        makeCacheFile(localAsmPath, cacheDir)

    with open(asmPath, "r") as file:
        asmContent = file.read()

    return asmContent

def getExecutableRuntime(executablePath, numSamples = 1):
    '''runs the executable `numSamples` times and returns average runtime. Return None if error occurred''' 

    if not numSamples:
        return None

    try:        
        totalRuntime = 0
        for i in range(numSamples):

            runtimeStr = subprocess.Popen(executablePath, executable='/bin/bash', shell=True, stdout=subprocess.PIPE).stdout.read()
            totalRuntime+= int(runtimeStr)

        return totalRuntime/numSamples

    except:
        logger.warning('Could not compile ' + executablePath +  
                       ' due to time out. Setting runtime to None .' + 
                       ' Considering increasing the TEST_SHELL_COMMAND_TIMEOUT,'+ 
                       ' which is currently set to ' + str(TEST_SHELL_COMMAND_TIMEOUT))
        return None

def get_runtime(rundir, filename, \
                slpMaxRegSize = None, slpThreshold = None, \
                cacheDir = None, numSamples = 1, log = False):

    '''produces the new file O3 compiled with the slpMaxRegSize and slpThreshold params.
       Returns the runtime of the executable after compiling.'''
    
    executableName = getExecutableName(filename, slpMaxRegSize, slpThreshold)
    executablePath = getCachedPath(rundir, executableName, cacheDir)

    # Already compiled binary, just return the runtime
    if os.path.exists(executablePath):
        if log:
            print(f"Using cached executable: '{executablePath}'")

        return getExecutableRuntime(executablePath, numSamples)

    compileExecutable(
        rundir, filename, executableName, slpMaxRegSize, slpThreshold, 
        cacheDir, log
    )

    return getExecutableRuntime(executablePath, numSamples)

def get_O3_runtimes(rundir, files, cacheDir = None, numSamples = 1):
    '''get all runetimes for O3 (baseline).'''

    try:
        print('Checking if local O3_runtimes.pkl file exists to avoid waste of compilation.') 

        picklePath = getCachedPath(rundir, "O3_runtimes.pkl", cacheDir)
        with open(picklePath, 'rb') as f:
            
            print(f"Found: '{picklePath}'")
            O3_runtimes = rename_contents(rundir, pickle.load(f))
            
    except:
        print('Did not find O3_runtimes.pkl...', 'Compiling to get -O3 runtimes.')
        O3_runtimes = {}

    full_path_header = os.path.join(rundir,'header.c')
    
    for filename in files:

        if filename not in O3_runtimes:
            O3_runtimes[filename] = get_runtime(rundir, filename, cacheDir=cacheDir, log=True, numSamples=numSamples)    

    localPicklePath = os.path.join(rundir,'O3_runtimes.pkl')
    with open(localPicklePath , 'wb') as output:
        pickle.dump(O3_runtimes, output)

    makeCacheFile(localPicklePath, cacheDir, log=True)    

    return O3_runtimes

def get_bruteforce_runtimes(rundir, files, cacheDir, \
                            slpMaxRegSizeValues, slpThresholdValues, numSamples = 1, log = False):
    ''' get all runtimes with bruteforce seach assuming a single loop per file!'''

    opt_runtimes = {}
    opt_factors = {}
    all_program_runtimes = {}
    one_program_runtimes = [
        [0]*len(slpThresholdValues) for value in range(len(slpMaxRegSizeValues))
    ]
    
    for filename in files:

        opt_runtime = float('inf')
        opt_factor = (None,None)
        
        for i, slpMaxRegSize in enumerate(slpMaxRegSizeValues):
            for j, slpThreshold in enumerate(slpThresholdValues):
                
                runtime = get_runtime(rundir, filename, slpMaxRegSize, slpThreshold, cacheDir, numSamples, log)
                one_program_runtimes[i][j] = runtime

                if runtime is not None and runtime < opt_runtime:
                    opt_runtime = runtime
                    opt_factor = (slpMaxRegSize, slpThreshold)

        opt_runtimes[filename] = opt_runtime
        opt_factors[filename] = opt_factor
        all_program_runtimes[filename] = copy.deepcopy(one_program_runtimes)
    
    data = {
        'opt_runtimes': opt_runtimes,
        'opt_factors': opt_factors,
        'all_program_runtimes': all_program_runtimes
    }

    picklePath = os.path.join(rundir,'bruteforce_runtimes.pkl')
    with open(picklePath, 'wb') as file: 
        pickle.dump(data, file)

    return data

def get_block(i,code):
    j = i
    cnt = 0
    while(True):
        line = code[j]
        if re.match(r'^\s*//',line) or re.match(r'^\s*$',line):
            j += 1
            continue
        if '{' in line:
            cnt += line.count('{')
        if '}' in line:
            cnt -= line.count('}')
        if cnt == 0 and not (re.match(r'^\s*for\s*\(',line) or re.match(r'^\s*while\s*\(',line)):
            return (i,j)
        if cnt == 0 and line.endswith(';\n'):
            return (i,j)
        if (re.match(r'^\s*for\s*\(',line) or re.match(r'^\s*while\s*\(',line)) and i != j:
            return get_block(j,code)
        j=j+1

def get_vectorized_code(code):
    '''Used by get_vectorized_codes function to do the parsing 
    of a single code to detect the loops, find pragmas, and collect data.''' 
  
    new_code = []
    for_loops_indices = []
    i = 0
    pragma_indices = []
    num_elems_in_new_code = 0

    def tryInsertPragma(line):
        if re.match(f"^\\s*{pragma_line}", line) is not None:
            pragma_indices.append(num_elems_in_new_code)

    while i < len(code):
        line=code[i]

        tryInsertPragma(line)
        
        if re.match(r'(^\s*for\s*\()|(^\s*while\s*\()',line):
            begining,ending = get_block(i,code)
            orig_i=i

            while(i<ending+1):
                line = code[i]

                tryInsertPragma(line)
                new_code.append(line)

                num_elems_in_new_code+= 1
                i+= 1
           
            # to pick the index of the most innner loop    
            #for_loops_indices.append((orig_i,ending))
            for_loops_indices.append((begining,ending))
            i=ending+1
            continue

        new_code.append(line)
        num_elems_in_new_code += 1
        i += 1

    if len(pragma_indices) == 0:
        print("NO PRAGMA!")

    return for_loops_indices, pragma_indices, new_code

# TODO: Should we use symbolic links instead now that we aren't
#       inserting pragmas? This might speed up initialization
def get_vectorized_codes(orig_trainfiles, new_trainfiles):
    '''parses the original training files to detect loops.
    Then copies the files to the new directory'''

    loops_idxs_in_orig = {}
    pragmas_idxs = {}
    const_new_codes ={}
    num_loops = {}
    const_orig_codes={}
    
    for o_fn,n_fn in zip(orig_trainfiles,new_trainfiles):
        f = open(o_fn,'r')
        try:
            code = f.readlines()
        except:
            f.close()
            continue

        # print(f"'{o_fn}' | '{n_fn}")
        loops_idx, pragmas_idx, new_code = get_vectorized_code(code)       
        if not pragmas_idx:
            f.close()
            continue

        const_orig_codes[n_fn] = list(code)
        loops_idxs_in_orig[n_fn]=list(loops_idx)
        pragmas_idxs[n_fn] = list(pragmas_idx)
        const_new_codes[n_fn] = list(new_code)
        num_loops[n_fn] = len(pragmas_idx)
        
        logger.info('writing file... ' + n_fn)
        with open(n_fn,'w') as nf:
            nf.write(''.join(new_code))
        
        f.close()

    return loops_idxs_in_orig, pragmas_idxs, const_new_codes,num_loops,const_orig_codes
