
import os

os.environ.setdefault("TEST_SHELL_COMMAND_TIMEOUT", str(60))
from envs.neuroslp import NeuroSlpEnv

neuroSlp = NeuroSlpEnv({

    'filterNoise': True,
    'numRuntimeSamples': 3,

    'new_rundir': os.path.join(os.environ["NeuroVectorizer_DIR"], 'new_bruteForce_garbage'),
    'dirpath': os.path.join(os.environ["NeuroVectorizer_DIR"], 'slpDataset/bruteForce'),
    'runtimeCacheDir': os.path.join(os.environ["NeuroVectorizer_DIR"], 'slpBinCache')
})

neuroSlp.bruteForceRuntimes()

