import json
import pickle
import sys
import jsbeautifier

import numpy as np

class JsonEncoder(json.JSONEncoder):

    def default(self, o: any) -> any:

        # use list for np arrays
        if isinstance(o, np.ndarray):
            return o.tolist()        

        if isinstance(o, np.int32):
            return int(o)
        
        if isinstance(o, np.float):
            return float(o)

        return super().default(o)

assert len(sys.argv) == 2, "Expected [pklPath] args"

pklPath = sys.argv[1]
names = [ pklPath ] 

for name in names:
    
    outputName = name+".json"
    print(f"Unpacking '{pklPath}' into '{outputName}'...")
    
    with open(name, 'rb') as f:
        x = pickle.load(f)
        jsonString = json.dumps(x, cls=JsonEncoder, indent=None)

        options = jsbeautifier.default_options()
        options.indent_size = 2
        jsonString = jsbeautifier.beautify(jsonString, options)

    with open(outputName, 'w') as f:
        f.write(jsonString)

