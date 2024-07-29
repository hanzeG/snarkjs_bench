pragma circom 2.0.0;

include "./utils.circom";
include "./rescue_constants.circom";

template Round(t, r, MDS, RC) {
    signal input in[t];
    signal output out[t];

    var currentState[t];

    component dot[t];

    for(var i = 0; i < t; i++) {
        dot[i] = DotProduct(t);

        for(var j = 0; j < t; j++) {
            dot[i].in1[j] <== in[j];
            dot[i].in2[j] <== MDS[i][j];
        }

        currentState[i] = dot[i].out;
    }

    component addrc = AddRC(t, RC[r]);

    for(var i = 0; i < t; i++) {
        addrc.in[i] <== currentState[i];
    }

    for(var i = 0; i < t; i++) {
        out[i] <== addrc.out[i];
    }
}

template Permutation_not_opt(nInputs) {
    signal input in[nInputs];
    signal output out[nInputs];

    var t = nInputs;
    var rounds = 45;
    var RC[rounds][t] = RESCUE_RC(t);
    var MDS[t][t] = RESCUE_MDS(t);

    var currentState[t];
    // initial round
    for (var i = 0; i < t; i++) {
        currentState[i] = in[i] + RC[0][i];
    }

    component round[rounds - 1];

    var r_2 = rounds \ 2;

    component pow5inverse[r_2][t];
    component pow5[r_2][t];

    for (var i = 0; i < r_2; i++) {
        // odd rounds
        round[2 * i] = Round(t, 2 * i + 1, MDS, RC);
        for (var j = 0; j < t; j++) {
            pow5inverse[i][j] = InvPow5();
            pow5inverse[i][j].in <== currentState[j];
            round[2 * i].in[j] <== pow5inverse[i][j].out;
        }

        // even rounds
        round[2 * i + 1] = Round(t, 2 * i + 2, MDS, RC);
        for (var j = 0; j < t; j++) {
            pow5[i][j] = Pow5();
            pow5[i][j].in <== round[2 * i].out[j];
            round[2 * i + 1].in[j] <== pow5[i][j].out;
        }

        for (var j = 0; j < t; j++) {
            currentState[j] = round[2 * i + 1].out[j];
        }
    }

    for (var i = 0; i < t; i++) {
        out[i] <== currentState[i];
    }
}


template Rescue(nInputs, nOutputs) {
    signal input inputs[nInputs];
    signal output out[nOutputs];

    component permutation = Permutation_not_opt(nInputs);
    for (var i = 0; i < nInputs; i++) {
        permutation.in[i] <== inputs[i];
    }
    
    for (var i = 0; i < nOutputs; i++) {
        out[i] <== permutation.out[i];
    }
}