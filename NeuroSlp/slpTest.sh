#! /bin/bash

# checkpointFile=checkpoints/checkpoint_200/checkpoint-200
# checkpointFile=slpTrainingResults/keep/PPO_slpAutovec_0_2022-12-09_04-23-small/checkpoint_200/checkpoint-200
# checkpointFile=slpTrainingResults/keep/PPO_slpAutovec_0_2022-12-10_00-07-medium/checkpoint_200/checkpoint-200
checkpointFile=slpTrainingResults/keep/PPO_slpAutovec_0_2022-12-10_16-54-large/checkpoint_200/checkpoint-200

# testDir=slpDataset/large
testDir=slpDataset/testLarge1000

source preprocess/configure.sh

# cleanup old files
rm -r new_rollout_garbage*

# python slpTempRollout.py -h
# Note: -u for unbuffered output so we can track progress
python -u slpTempRollout.py $checkpointFile --rollout_dir $testDir --compile | tee test.out

grep -Po "benchmark:.*" test.out | column -t > slpTestResults/slpTestResults_trainLarge_testLarge1000.out
