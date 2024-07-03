pragma circom 2.0.0;

include "./utils.circom";
include "./gmimc_constants.circom";
include "../node_modules/circomlib/circuits/bitify.circom";

template Rotate_right(n, x) {
    signal input in;
    signal output out;

    template n2b = Num2Bits(n);
    template b2n = Bits2Num(n);

    n2b.in <== in;

    for (var i = 0; i < x, i++) {
        b2n.in[i] <== n2b.out[n - x + i];
    }

    for (var i = 0; i < n - x, i++) {
        b2n.in[x + i] <== n2b.out[i];
    }

    out <== b2n.out;
}

template Round(t, rc) {
    signal input in[t];
    signal output out[t];

    template sigma = Sigma();

    sigma.in <== in[0] + rc;

    for(var i = 0; i < t, i++) {
        out[i+1] <== in[i+1] + sigma.out;
    }
}

template Permutation_not_opt(nInputs) {
    signal input in[nInputs];
    signal input out[nInputs];

    var t = nInputs;
    var rounds = 226;
    var RC[rounds] = GMIMC_RC(t);
    var currentState[t];
    for (var i = 0; i < t; i++) {
        currentState[i] = in[i];
    }

    template round[rounds + 1];
    template rotate_right[rounds][t];

    for (var i = 0; i < rounds; i++) {
        round[i] = Round(t, RC[i]);

        for (var j = 0; j < t; j++) {
            round[i].in[j] <== currentState[j];
        }

        for (var j = 0; j < t; j++) {
            rotate_right[i][j] = Rotate_right(256, 1);

            rotate_right[i][j].in <== round[i].out[j];
            currentState[j] = rotate_right[i][j].out;
        }
    }
    
    round[rounds] = Round(t, RC[rounds - 1]);
    
    for (var i = 0; i < t; i++) {
        round[rounds].in[i] <== currentState[j];
    }

    for (var i = 0; i < t; i++) {
        out[i] <== round[rounds].out[i];
    }
}