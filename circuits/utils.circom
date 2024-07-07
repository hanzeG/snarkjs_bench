pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/bitify.circom";

template Sigma() {
    signal input in;
    signal output out;

    signal in2;
    signal in4;

    in2 <== in*in;
    in4 <== in2*in2;

    out <== in4*in;
}

template Sum(t) {
    signal input in[t];
    signal output out;
    var sum = 0;
    for (var i = 0; i < t; i++) {
        sum += in[i];
    }
    out <== sum;
}

template Swap(t, from, to) {
    signal input in[t];

    signal output out[t];

    var current_stage[t];

    for (var i = 0; i < t; i++) {
        current_stage[i] = in[i];
    }

    current_stage[to] = in[from];
    current_stage[from] = in[to];

    for (var i = 0; i < t; i++) {
        out[i] <== current_stage[i];
    }
}

template AddRC(t, rc) {
    signal input in[t];
    signal output out[t];

    for (var i = 0; i < t; i++) {
        out[i] <== in[i] + rc[i]; 
    }
}