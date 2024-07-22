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

template Rotate_right(t) {
    signal input in[t];
    signal output out[t];

    out[0] <== in[t - 1];
    for (var i = 1; i < t; i++){
        out[i] <== in[i - 1];
    }
}

template Rotate_left(t) {
    signal input in[t];
    signal output out[t];

    out[t - 1] <== in[0];
    for (var i = 0; i < t - 1; i++){
        out[i] <== in[i + 1];
    }
}

template DotProduct(t) {
    signal input in1[t];
    signal input in2[t];
    signal output out;

    signal sum[t];

    sum[0] <== in1[0] * in2[0];
    for (var i = 1; i < t; i++) {
        sum[i] <== sum[i-1] + in1[i] * in2[i];
    }

    out <== sum[t-1];
}

template Pow(exp) {
    signal input a;
    signal output result;

    if (exp == 0) {
        result <== 1;
    } else if (exp == 1) {
        result <== a;
    } else {
        signal tmp;
        component powNMinus1 = Pow(exp-1);
        powNMinus1.a <== a;
        tmp <== powNMinus1.result;
        result <== tmp * a;
    }
}

template Pow5Inverse() {
    signal input a;
    signal output result;

    var PRIME_FIELD = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    // a^5
    signal a_pow_5;
    
    component pow5 = Sigma();
    pow5.in <== a;
    a_pow_5 <== pow5.out;

    // a^5 INV
    var p_minus_2;
    p_minus_2 = PRIME_FIELD - 2;

    signal inv_a_pow_5;

    component pow = Pow(p_minus_2);

    pow.a <== a_pow_5;

    inv_a_pow_5 <== pow.result;

    result <== inv_a_pow_5;
}