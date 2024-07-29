const chai = require("chai");
const path = require("path");
const wasm_tester = require("circom_tester").wasm;
const assert = chai.assert;

const { utils, getCurveFromName } = require("ffjavascript");
// const fs = require('fs');

const neptune_constants = require("./neptune_constants.js");

const { swap } = require("./utils");

function External4(F, input) {
    const t = input.length;
    let out = swap(input, 1, 3);

    let current_state = out.map(a => F.e(a));

    let sum1 = F.add(current_state[0], current_state[2]);
    let sum2 = F.add(current_state[1], current_state[3]);

    current_state[0] = F.add(current_state[0], sum1);
    current_state[1] = F.add(current_state[1], sum2);
    current_state[2] = F.add(current_state[2], sum1);
    current_state[3] = F.add(current_state[3], sum2);

    out = current_state.map(a => F.toObject(a));

    return out;
}

function ExternalMatmul(F, input) {
    const t = input.length;

    if (t === 4) {
        return External4(F, input);
    }
}

function ExternalSboxPrime(F, input, ABC) {
    let inp = input.map(a => F.e(a));
    let abc = ABC.map(a => F.e(a));

    let x1 = inp[0];
    let x2 = inp[1];

    let zi = F.sub(x1, x2);
    let zib = F.square(zi);

    // first terms
    let sum = F.add(x1, x2);
    let y1 = F.add(sum, x1);
    let y2 = F.add(sum, x2);
    y2 = F.add(y2, x2);

    // middle terms
    let tmp1 = F.add(zib, zib);
    let tmp2 = tmp1;
    tmp1 = F.add(tmp1, zib);
    tmp2 = F.add(tmp2, tmp2);
    y1 = F.add(y1, tmp1);
    y2 = F.add(y2, tmp2);

    // third terms
    let tmp = zi;
    tmp = F.sub(tmp, x2);
    tmp = F.sub(tmp, zib);
    tmp = F.add(tmp, abc[2]);
    tmp = F.square(tmp);
    y1 = F.add(y1, tmp);
    y2 = F.add(y2, tmp);

    return [F.toObject(y1), F.toObject(y2)];
}

function ExternalSbox(F, input, ABC) {
    const t = input.length;
    let out = Array(t);

    let t2 = t / 2;
    for (let i = 0; i < t2; i++) {
        let in1 = input[i * 2];
        let in2 = input[i * 2 + 1];
        let [out1, out2] = ExternalSboxPrime(F, [in1, in2], ABC);
        out[2 * i] = out1;
        out[2 * i + 1] = out2;
    }

    return out;
}

function ExternalRound(F, input, r, RC, ABC, E) {
    const t = input.length;

    let current_state = ExternalSbox(F, input, ABC);

    current_state = ExternalMatmul(F, current_state);

    current_state = current_state.map(a => F.e(a));

    for (let i = 0; i < t; i++) {
        current_state[i] = F.add(current_state[i], F.e(RC[r][i]));
    }

    let out = current_state.map(a => F.toObject(a));

    return out;
}

function InternalSbox(F, input) {
    const t = input.length;
    let current_state = input.map(a => F.e(a));

    const pow5 = a => F.mul(a, F.square(F.square(a)));

    current_state[0] = pow5(current_state[0]);

    let out = current_state.map(a => F.toObject(a));

    return out;
}

function InternalMatmul(F, input, U) {
    const t = input.length;
    let current_state = input.map(a => F.e(a));
    let UU = U.map(a => F.e(a));

    let sum = current_state.reduce((acc, el) => F.add(acc, el));

    for (let i = 0; i < t; i++) {
        current_state[i] = F.mul(current_state[i], UU[i]);
        current_state[i] = F.add(current_state[i], sum);
    }

    let out = current_state.map(a => F.toObject(a));

    return out;
}

function InternalRound(F, input, r, RC, U) {
    const t = input.length;

    let current_state = InternalSbox(F, input);

    current_state = InternalMatmul(F, current_state, U);

    current_state = current_state.map(a => F.e(a));

    for (let i = 0; i < t; i++) {
        current_state[i] = F.add(current_state[i], F.e(RC[r][i]));
    }

    let out = current_state.map(a => F.toObject(a));

    return out;
}

function Permutation(F, input, roundF, roundP, RC, E, U, ABC) {
    const t = input.length;

    let current_state = ExternalMatmul(F, input);

    for (let i = 0; i < roundF / 2; i++) {
        current_state = ExternalRound(F, current_state, i, RC, ABC, E);
    }

    for (let i = 0; i < roundP; i++) {
        current_state = InternalRound(F, current_state, i + roundF / 2, RC, U);
    }

    for (let i = 0; i < roundF / 2; i++) {
        current_state = ExternalRound(F, current_state, i + roundF / 2 + roundP, RC, ABC, E);
    }

    let out = current_state;

    return out;
}

describe("Neptune Circuit test", function () {
    let prime;
    let F;
    let circuit;

    const roundF = 6;
    const roundP = 68;

    const { RC, E, U, ABC } = utils.unstringifyBigInts(neptune_constants);

    this.timeout(1000000);

    before(async () => {
        prime = await getCurveFromName("bn128", true);
        F = prime.Fr;
        circuit = await wasm_tester(path.join(__dirname, "circuits", "neptune_test.circom"));
    });

    it("Should check consistence of different preimages when t = 4", async () => {
        const inputs = [18760637753128112318735283812312404680033976627771379502001831522413105500534n,
            876601669562826214509668860197953608048826865027005593420954541703925559393n,
            13875711461188939787036568869127908802397891188529784132980608231047511788211n,
            954735858296744895287169959207944447565690197469663798379217241921380187598n];

        // const bigIntInput = input.map(x => BigInt(x));

        const res2 = Permutation(F, inputs, roundF, roundP, RC, E, U, ABC);

        const w = await circuit.calculateWitness({ inputs: inputs });

        await circuit.assertOut(w, { outputs: res2 });
        await circuit.checkConstraints(w);
    });

});