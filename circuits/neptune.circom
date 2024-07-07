pragma circom 2.0.0;

include "./utils.circom";
include "./neptune_constants.circom";

template External_4() {
    signal input in[4];
    signal output out[4];

    component swap = Swap(4, 1, 3);

    var sum1 = 0;
    var sum2 = 0;
        
    for (var i = 0; i < 4; i++) {
        swap.in[i] <== in[i];
    }

    sum1 = swap.out[0] + swap.out[2];
    sum2 = swap.out[1] + swap.out[3];

    out[0] <== swap.out[0] + sum1;
    out[1] <== swap.out[1] + sum2;
    out[2] <== swap.out[2] + sum1;
    out[3] <== swap.out[3] + sum2;
}

template External_Matmul(t, E) {
    signal input in[t];
    signal output out[t];

    var current_state[t];

    if(t == 4) {
        component external_4 = External_4();

        for (var i = 0; i < t; i++) {
            external_4.in[i] <== in[i];
        }

        for (var i = 0; i < t; i++) {
            out[i] <== external_4.out[i];
        }
    } else {
        var t_2 = t / 2;
        for (var i = 0; i < t_2; i++) {
            for (var j = 0; j < t_2; j++) {
                current_state[i * 2] += E[i * 2][j * 2] * in[j * 2];
                current_state[i * 2 + 1] += E[i * 2 + 1][j * 2 + 1] * in[j * 2 + 1];
            }
        }

        for (var i = 0; i < t; i++) {
            out[i] <== current_state[i];
        }
    }
}

template Internal_Matmul(t, U) {
    signal input in[t];
    signal output out[t];

    component sum = Sum(t);

    var current_state[t];

    for (var i = 0; i < t; i++) {
        sum.in[i] <== in[i];
        current_state[i] = in[i];
    }

    for (var i = 0; i < t; i++) {
        current_state[i] = current_state[i] * U[i] + sum.out;
        out[i] <== current_state[i];
    }
}

template InternalSbox(t) {
    signal input in[t];
    signal output out[t];

    component sbox = Sigma();
    sbox.in <== in[0];
    out[0] <== sbox.out;

    for (var i = 1; i < t; i++) {
        out[i] <== in[i];
    }
}

template InternalRound(t, r, U, RC) {
    signal input in[t];
    signal output out[t];

    component internalsbox = InternalSbox(t);
    component internalmatmul = Internal_Matmul(t, U);
    component addrc = AddRC(t, RC[r]);

    for (var i = 0; i < t; i++) {
        internalsbox.in[i] <== in[i];
    }

    for (var i = 0; i < t; i++) {
        internalmatmul.in[i] <== internalsbox.out[i];
    }

    for (var i = 0; i < t; i++) {
        addrc.in[i] <== internalmatmul.out[i];
    }

    for (var i = 0; i < t; i++) {
        out[i] <== addrc.out[i];
    }
}

template ExternalSboxPrime(ABC) {
    signal input in[2];
    signal output out[2];

    var x1 = in[0];
    var x2 = in[1];

    var zi = x1 - x2;
    signal zib <== zi * zi;

    // first terms
    var sum = x1;
    sum += x2;

    var y1 = sum + x1;
    var y2 = sum + x2 + x2;

    // middle terms
    var tmp1 = zib + zib;
    var tmp2 = tmp1;

    tmp1 += zib;
    tmp2 += tmp2;

    y1 += tmp1;
    y2 += tmp2;

    // third terms
    var tmp = zi;
    tmp -= x2;
    tmp -= zib;
    tmp += ABC[2];
    signal tmpb <== tmp * tmp;

    y1 += tmpb;
    y2 += tmpb;

    out[0] <== y1;
    out[1] <== y2;
}

template ExternalSbox(t, ABC) {
    signal input in[t];
    signal output out[t];

    var current_state[t];

    for (var i = 0; i < t; i++) {
        current_state[i] = 0;
    }

    var t_2 = t / 2;

    component esp[t_2];
    for (var i = 0; i < t_2; i++) {
        esp[i] = ExternalSboxPrime(ABC);

        esp[i].in[0] <== in[i * 2];
        esp[i].in[1] <== in[i * 2 + 1];
        current_state[i * 2] = esp[i].out[0];
        current_state[i * 2 + 1] = esp[i].out[1];
    }

    for (var i = 0; i < t; i++) {
        out[i] <== current_state[i];
    }
}

template ExternalRound(t, r, RC, ABC, E) {
    signal input in[t];
    signal output out[t];

    component externalsbox = ExternalSbox(t, ABC);
    component external = External_Matmul(t, E);
    component addrc = AddRC(t, RC[r]);

    for (var i = 0; i < t; i++) {
        externalsbox.in[i] <== in[i];
    }

    for (var i = 0; i < t; i++) {
        external.in[i] <== externalsbox.out[i];
    }

    for (var i = 0; i < t; i++) {
        addrc.in[i] <== external.out[i];
    }

    for (var i = 0; i < t; i++) {
        out[i] <== addrc.out[i];
    }
}

template Permutation(nInputs) {
    signal input in[nInputs];
    signal output out[nInputs];

    var t = nInputs;

    var roundF = 6;
    var roundP = 68;

    var E[t][t] = NEPTUNE_E(t);
    var U[t] = NEPTUNE_U(t);
    var ABC[3] = NEPTUNE_ABC(t);
    var RC[roundF + roundP][t] = NEPTUNE_RC(t);
    
    var current_state[t];

    component externalmatmul;
    component externalround[roundF];
    component internalround[roundP];

    externalmatmul = External_Matmul(t, E);
    for (var i = 0; i < t; i++) {
        externalmatmul.in[i] <== in[i];
    }

    for (var i = 0; i < t; i++) {
        current_state[i] = externalmatmul.out[i];
    }

    // beginning full round
    for (var i = 0; i < roundF / 2; i++) {
        externalround[i] = ExternalRound(t, i, RC, ABC, E);

        for (var j = 0; j < t; j++) {
            externalround[i].in[j] <== current_state[j];
        }

        for (var j = 0; j < t; j++) {
            current_state[j] = externalround[i].out[j];
        }
    }

    // partial round
    for (var i = 0; i < roundP; i++) {
        internalround[i] = InternalRound(t, i + roundF / 2, U, RC);

        for (var j = 0; j < t; j++) {
            internalround[i].in[j] <== current_state[j];
        }

        for (var j = 0; j < t; j++) {
            current_state[j] = internalround[i].out[j];
        }
    }

    // ending full round
    for (var i = 0; i < roundF / 2; i++) {
        externalround[i + roundF / 2] = ExternalRound(t, i + roundF / 2 + roundP, RC, ABC, E);

        for (var j = 0; j < t; j++) {
            externalround[i + roundF / 2].in[j] <== current_state[j];
        }

        for (var j = 0; j < t; j++) {
            current_state[j] = externalround[i + roundF / 2].out[j];
        }
    }

    for (var i = 0; i < t; i++) {
        out[i] <== current_state[i];
    }
}

template Neptune(nInputs, nOutputs) {
    signal input inputs[nInputs];
    signal output outputs[nOutputs];

    component permutation = Permutation(nInputs);

    for (var i = 0; i < nInputs; i++) {
        permutation.in[i] <== inputs[i];
    }

    for (var i = 0; i < nOutputs; i++) {
        outputs[i] <== permutation.out[i];
    }
}