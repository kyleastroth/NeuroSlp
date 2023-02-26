# Welcome to the NeuroSLP Repo!

**Table of contents:**
---
> 1. [About NeuroSLP](#aboutNeuroSlp)  
>       1.1 [Download Links](#downloadLinks)  
>       1.2 [The Team](#theTeam)  
>  
> 2. [Getting Started](#gettingStarted)  
>       2.1 [Dependencies](#dependencies)  
>       2.2 [Configuration](#configuration)  
>       2.3 [Training](#training)  
>       2.4 [Testing](#testing)  
>       2.5 [Important Notes](#importantNotes)  
---


<a name="aboutNeuroSlp"></a>
## Section 1 - About NeuroSLP
NeuroSLP extends the work done in [NeuroVectorizer](https://github.com/intel/neuro-vectorizer) and enhance llvm's parameter selection for Superword Level Parallelism (SLP).

NeruoSLP uses deep reinforcement learning to estimate the optimal LLVM `slp-max-reg-size` and `slp-threshold` parameters source code.  

From our evaluation of 1,000 programs NeuroSLP is capable of improving runtime performance by over 6.5% and up to 54% in select applications.  


<br>

<a name="downloadLinks"></a>
### Section 1.1 - Download Links

Our project is available to download with the following links:
- [Research Paper](Report/NeuroSLP.pdf)
- [Presentation Slides](Report/NeuroSLP%20Final%20Presentation.pdf)
- [Test Results (Excel)](Report/NeuroSLP%20Training%20Results.xlsx)
- [Project Proposal](Report/EECS%20583%20Project%20Proposal.pdf)

<br>

<a name="theTeam"></a>
### Section 1.2 - The Team

|                |                    |                                                           |                                            |                                       |
| -              | -                  | -                                                         | -                                          | -                                     |
| Kyle Astroth   | kastroth@umich.edu | [LinkedIn](https://www.linkedin.com/in/kyle-astroth/)     | [GitHub](https://github.com/kyleastroth)   |  |
| Sam Gonzalez   | samgonza@umich.edu | [LinkedIn](https://www.linkedin.com/in/samgonza/)         | [GitHub](https://github.com/samrg123)      | [Website](https://samrg123.com/)      |
| Carson Hoffman | hoffcar@umich.edu  | [LinkedIn](https://linkedin.com/in/carson-hoffman)        | [GitHub](https://github.com/CarsonHoffman) |                                       |
| Xiangyu Qin    | qinx@umich.edu     | [LinkedIn](https://linkedin.com/in/xiangyu-qin-503783187) | [GitHub](https://github.com/tommy2022)     |                                       |


<br>

---

<br>

<a name="gettingStarted"></a>
## Section 2 - Getting Started

In this section we'll go through everything you'll need to know about setting up, training, and testing NeuroSLP.

<br>

<a name="dependencies"></a>
### Section 2.1 - Dependencies

NeuroSLP has the following dependencies:
```bash
# TF2
pip install tensorflow

# Ray
pip install ray==0.8.4

# RLlib
pip install ray[rllib]==0.8.4

# LLVM. Currently tested with clang 14.0.0.1
sudo apt-get install clang-14

# Clang for python
pip install clang

```

You may also need to install the Anaconda depending on your development environment.
For more detailed instructions please refer to NeuroVectorizer's extended documentation [here](https://github.com/intel/neuro-vectorizer/blob/master/detailedinstructions.md). 

<br>

<a name="configuration"></a>
### Section 2.2 - Configuration

Configuration is mostly achieved by modifying `NeuroSlp/preprocess/configure.sh`.
Some important variables you may need to modify are:
> | Varible                      | Description                                            |
> | -                            | -                                                      |
> | `CLANG_PATH`                 | Path to libclang                                       |
> | `CLANG_BIN_PATH`             | Path to clang binary                                   |
> | `SOURCE_DIR`                 | Path to files used to generate for code2vec histograms |
> | `TEST_SHELL_COMMAND_TIMEOUT` | Timeout used while compiling programs                  |

<br>

<a name="training"></a>
### Section 2.3 - Training

Training of NeuroSLP is done via the `NeuroSlp/slpTrain.sh` script. By default NeuroSLP is configured to use the `NeuroSlp/slpDataset/large` dataset for training and outputs training results to `NeuroSlp/slpTrainingResults`.

To configure the training dataset and other hyperparameters you will need to modify `NeuroSlp/slpAutovec.py`.

For more information on available hyperparameters visit the documentation of Ray [here](https://docs.ray.io/en/releases-0.8.4/rllib-training.html#common-parameters). And the documentation for PPO [here](https://docs.ray.io/en/releases-0.8.4/rllib-algorithms.html?#codecell1).  

<br>

<a name="testing"></a>
### Section 2.4 - Testing

Testing of NeuroSLP is done via the `NeuroSlp/slpTest.sh` script. By default NeuroSLP is configured to use the `NeuroSlp/slpDataset/testLarge1000` dataset for testing and outputs a summary of training results to `NeuroSlp/slpTestResults_trainLarge_testLarge1000.out`.

To change the test dataset and output path you'll have to modify the `NeuroSlp/slpTest.sh` script. To modify other hyperparameters you'll have to modify `NeuroSlp/slpTempRollout.py` instead. 

In addition `NeuroSlp/slpTempRollout.py` can be used to continue training the NeuroSLP from a given checkpoint. For more information on how to use `slpTempRollout.py` run `python slpTempRollout.py --help` and visit the documentation provided by NeuroVectorizer [here](https://github.com/intel/neuro-vectorizer/blob/master/README.md). 

Please refer to the documentation linked to in [Section 2.3](#training) for more information on the available hyperpameters in Ray. 


<br>

<a name="importantNotes"></a>
### 2.5 -  Important Notes

Below are some important notes to keep in mind about the project in no particular order are:
- The code2vec embeddings of programs are generated only first invokation of `NeuroSlp/slpTrain.sh`. If you want to regenerate them delete `NeuroSlp/code2vec/data`  
If you would like to add additional training/test programs for the
- `NeuroSlp/slpBinCache/O3_runtimes.pkl` caches the current runtimes of programs compiled with LLVM's default parameters across multiple runs of training and testing. If you want to recompute the runtimes be sure to delete the file.
- NeuroSlp comes with a pretrained version of code2vec embedding using the files in `NeuroSlp/slpDataset/full`. This embedding is stored in `NeuroSlp/slpDataset/*/obs_encodings.pkl`. If you would like to produce a new embedding/add to the dataset delete this file and run `NuroSlp/slpTrain.sh`. This will produce a new `obs_encoding.pkl` in `NeuroSlp/new_garbage_*`.   
- If you want to use another model in the embedding generator (other than code2vec), you need to modify get_obs function in `NeuroSlp/envs/neuroslp.py`. 

<br>

NeuroSLP also comes with a variety of helper programs that may be of use to you:
> | Program                                  | Description                                            |
> | -                                        | -                                                      |
> | `NeuroSlp/decompileDir.sh`               | Takes in a directory argument and decompiles every `.o` files in it into assembly |
> | `NeuroSlp/diffRuntimeAsm.py`             | Takes in a directory argument and diffs each  `.s` file in it ignoring code not part of the example function. |
> | `NeuroSlp/slpBruteForceRuntimes.py`      | Evaluates the runtime of every combination of `slp-max-reg-size` and `slp-threshold` |
> | `NeuroSlp/unpackPickle.py`               | Takes in a pkl path argument and outputs a human readable json version of it |
> | `NeuroSlp/slpDataset/preprocessLoops.py` | Takes in input and output directory arguments. Is used to converts all NeuroVectorizer formatted `.c` test programs in the input directory into NeuroSLP compatible programs. |
> | `NeuroSlp/slpDataset/makeDataset.py`     | Takes in a size, input, and output directory argument. Is used to creates random test/training datasets |
