pragma circom 2.0.0;

include "./utils.circom";
include "./gmimc_constants.circom";

template Round(t, rc) {
    signal input in[t];
    signal output out[t];

    component sigma = Sigma();

    sigma.in <== in[0] + rc;

    out[0] <== in[0];

    for(var i = 1; i < t; i++) {
        out[i] <== in[i] + sigma.out;
    }
}

template Permutation_not_opt(nInputs) {
    signal input in[nInputs];
    signal output outputs[nInputs];

    var t = nInputs;
    var rounds = 226;
    var RC[rounds] = GMIMC_RC(t);
    var currentState[t];
    for (var i = 0; i < t; i++) {
        currentState[i] = in[i];
    }

    component round[rounds];
    component rotate_right[rounds];

    for (var i = 0; i < rounds - 1; i++) {
        round[i] = Round(t, RC[i]);
        rotate_right[i] = Rotate_right(t);

        for (var j = 0; j < t; j++) {
            round[i].in[j] <== currentState[j];
        }

        for (var j = 0; j < t; j++) {
            rotate_right[i].in[j] <== round[i].out[j];
        }

        for (var j = 0; j < t; j++) {
            currentState[j] = rotate_right[i].out[j];
        }
    }

    // last permutation without rotation
    round[rounds - 1] = Round(t, RC[rounds - 1]);
    
    for (var i = 0; i < t; i++) {
        round[rounds - 1].in[i] <== currentState[i];
    }

    for (var i = 0; i < t; i++) {
        outputs[i] <== round[rounds - 1].out[i];
    }
}

template Permutation(nInputs) {
    signal input in[nInputs];
    signal output out[nInputs];

    var t = nInputs;

    if(t < 8) {
        component permutationNotOpt = Permutation_not_opt(t);
        for (var i = 0; i < t; i++) {
            permutationNotOpt.in[i] <== in[i];
        }

        for (var i = 0; i < t; i++) {
            out[i] <== permutationNotOpt.outputs[i];
        }
    }
}

template GMiMC(nInputs, nOutputs) {
    signal input inputs[nInputs];
    signal output out[nOutputs];

    component permutation = Permutation(nInputs);
    for (var i = 0; i < nInputs; i++) {
        permutation.in[i] <== inputs[i];
    }
    
    for (var i = 0; i < nOutputs; i++) {
        out[i] <== permutation.out[i];
    }
}