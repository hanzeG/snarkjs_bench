const Poseidon2Params = require('./poseidon2_paras');
const { getCurveFromName } = require("ffjavascript");

async function initializeParams() {
    const PrimeFiled = await getCurveFromName("bls12381", true);
    const F = PrimeFiled.Fr;

    const POSEIDON2_BN_2_PARAMS = new Poseidon2Params(F, 2, 5, 8, 56);
    const POSEIDON2_BN_3_PARAMS = new Poseidon2Params(F, 3, 5, 8, 56);
    const POSEIDON2_BN_4_PARAMS = new Poseidon2Params(F, 4, 5, 8, 56);
    const POSEIDON2_BN_8_PARAMS = new Poseidon2Params(F, 8, 5, 8, 57);

    return {
        POSEIDON2_BN_2_PARAMS,
        POSEIDON2_BN_3_PARAMS,
        POSEIDON2_BN_4_PARAMS,
        POSEIDON2_BN_8_PARAMS
    };
}

module.exports = initializeParams;