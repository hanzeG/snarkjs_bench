pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/mimcsponge.circom";

template MiMC_Hasher() {
    signal input in[2];
    signal output out;

    component hasher = MiMCSponge(2,220,1);
    hasher.ins[0] <== in[0];
    hasher.ins[1] <== in[1];
    hasher.k <== 0;

    out <== hasher.outs[0];
}

template MiMC_Build_Merkle_Tree(d) {
    var leavesN = 2 ** d;
    var hasherN = 2 * leavesN - 1;

    signal input leaves[leavesN][2];
    signal output root;

    component hasher[hasherN];
    
    var hashes[hasherN];

    for (var i = 0; i < hasherN; i++){
        hasher[i] = MiMC_Hasher();
        if (i < leavesN) {
            hasher[i].in[0] <== leaves[i][0];
            hasher[i].in[1] <== leaves[i][1];
        } else {
            hasher[i].in[0] <== hashes[(i - leavesN) * 2];
            hasher[i].in[1] <== hashes[(i - leavesN) * 2 + 1];
        }

        hashes[i] = hasher[i].out;
    }

    root <== hashes[hasherN - 1];
}




