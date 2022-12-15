#! /bin/bash

c2vDir="../code2vec/data/for_loops/"


pushd .

    cd preprocess
    source configure.sh

    # Needed to compute O3 runtimes and preprocess code
    if [ ! -d $forLoopDir ] || [ ! $(ls -A $c2vDir | grep c2v) ]; then
        
        echo "Getting C2V Data ..."
        source preprocess.sh
        
        echo "----"
        echo contents of "$c2vDir"
        ls -lah $c2vDir
        echo "----"
        echo 
    fi

popd

# cleanup old data
rm -r new_garbage*
rm -r ~/ray_results/*

# Trains neurovectorizer
# Note: -u for unbuffered output so we can track progress
python3 -u  slpAutovec.py

trainResultDir=slpTrainingResults
mkdir $trainResultDir 2> /dev/null
mv ~/ray_results/neuroslp_train/* $trainResultDir/
echo MOVED RAY LOGDIR TO: "$trainResultDir"
