const NeptuneParams = require('./neptune_paras');
const { getCurveFromName } = require("ffjavascript");

async function initializeParams() {
    const PrimeFiled = await getCurveFromName("bls12381", true);
    const F = PrimeFiled.Fr;

    const NEPTUNE_BLS_4_PARAMS = new NeptuneParams(F, 4, 5, 6, 69);
    const NEPTUNE_BLS_8_PARAMS = new NeptuneParams(F, 8, 5, 6, 74);

    return {
        NEPTUNE_BLS_4_PARAMS,
        NEPTUNE_BLS_8_PARAMS
    };
}

module.exports = initializeParams;