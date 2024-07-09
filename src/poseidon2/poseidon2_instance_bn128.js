const Poseidon2Params = require('./poseidon2_paras');
const { getCurveFromName } = require("ffjavascript");

async function initializeParams() {
    const PrimeFiled = await getCurveFromName("bn128", true);
    const F = PrimeFiled.Fr;

    const POSEIDON2_BN_3_PARAMS = new Poseidon2Params(F, 3, 5, 8, 56);

    return {
        POSEIDON2_BN_3_PARAMS
    };
}

module.exports = initializeParams;