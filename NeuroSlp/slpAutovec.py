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
import ray
import ray.tune as tune
from ray.rllib.agents import ppo
from envs.neuroslp import NeuroSlpEnv
from ray.tune.registry import register_env
from ray.tune.logger import TBXLogger

# Note: num_gpu
# ray.init(num_cpus=6, num_gpus=1)
ray.init()
register_env("slpAutovec", lambda config:NeuroSlpEnv(config))

# Note(Sam): see https://docs.ray.io/en/releases-0.8.4/rllib-training.html#common-parameters for details
tune.run("PPO",
        #restore = "~/ray_results/PPO_*/checkpoint_240/checkpoint-240",
        checkpoint_freq  = 1,
        name = "neuroslp_train",
        stop = {"episodes_total": 100000}, # Note(Sam): Default is 100000
        config={
            "sample_batch_size": 25,
            "train_batch_size": 500,
            "sgd_minibatch_size": 20,
            "num_sgd_iter":20,
            #"lr":5e-5,                   # learning rate. Default = .0001
            #"vf_loss_coeff":0.5,         # used to 
            "env": "slpAutovec",
            "horizon":  1,
            "num_gpus": 0,
            "model":{'fcnet_hiddens':[128,128]},
            "num_workers": 0, # Note(Sam): Default = 1, PPO uses additional thread for training nn
            # "num_gpus": 0,  # TODO: Enable this? Note: this can be fractional

            "env_config": {
               'filterNoise': True,
               'numRuntimeSamples': 3,
               
               'dirpath': os.path.join(os.environ["NeuroVectorizer_DIR"], 'slpDataset/large'),
               'new_rundir': os.path.join(os.environ["NeuroVectorizer_DIR"], 'new_garbage'),
               'runtimeCacheDir': os.path.join(os.environ["NeuroVectorizer_DIR"], 'slpBinCache')
            }
         },
        loggers=[TBXLogger]
)
