#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
 
    struct FinalProject : public FunctionPass {

        // Note: populated at compile time
        static inline char ID = 0;

        FinalProject(): FunctionPass(ID) {}

        bool runOnFunction(Function &F) override {

            errs() << "Hello Final Project: ";
            errs().write_escaped(F.getName()) << '\n';

            return false;
        }
    };
}

static RegisterPass<FinalProject> X(
    "finalProject",            // Plugin command line argument
    "Final Project Pass",      // Plugin Name
    false,                     // Read-Only Control Flow Graph (CFG)
    false                      // is analysis pass
);
