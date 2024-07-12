pragma circom 2.0.0;

include "../../circuits/gmimc.circom";

template GMiMC_Hasher() {
    signal input in[2];
    signal output out;

    component hasher = GMiMC(3,1);
    hasher.inputs[0] <== in[0];
    hasher.inputs[1] <== in[1];
    hasher.inputs[2] <== 0;

    out <== hasher.out[0];
}

template GMiMC_Build_Merkle_Tree(d) {
    var leavesN = 2 ** d;
    var hasherN = 2 * leavesN - 1;

    signal input leaves[leavesN][2];
    signal output root;

    component hasher[hasherN];
    
    var hashes[hasherN];

    for (var i = 0; i < hasherN; i++){
        hasher[i] = GMiMC_Hasher();
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




