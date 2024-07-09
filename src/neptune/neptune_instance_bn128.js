const NeptuneParams = require('./neptune_paras');
const { getCurveFromName } = require("ffjavascript");

async function initializeParams() {
    const PrimeFiled = await getCurveFromName("bn128", true);
    const F = PrimeFiled.Fr;

    const NEPTUNE_BN_4_PARAMS = new NeptuneParams(F, 4, 5, 6, 68);

    return {
        NEPTUNE_BN_4_PARAMS
    };
}

module.exports = initializeParams;