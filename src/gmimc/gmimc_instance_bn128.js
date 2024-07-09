const GmimcParams = require('./gmimc_paras');
const { getCurveFromName } = require("ffjavascript");

async function initializeParams() {
    const PrimeFiled = await getCurveFromName("bn128", true);
    const F = PrimeFiled.Fr;

    const GMIMC_BN_3_PARAMS = new GmimcParams(F, 3, 5, 226);
    const GMIMC_BN_4_PARAMS = new GmimcParams(F, 4, 5, 228);
    const GMIMC_BN_5_PARAMS = new GmimcParams(F, 5, 5, 230);
    const GMIMC_BN_8_PARAMS = new GmimcParams(F, 8, 5, 236);
    const GMIMC_BN_9_PARAMS = new GmimcParams(F, 9, 5, 238);
    const GMIMC_BN_12_PARAMS = new GmimcParams(F, 12, 5, 314);
    const GMIMC_BN_16_PARAMS = new GmimcParams(F, 16, 5, 546);
    const GMIMC_BN_20_PARAMS = new GmimcParams(F, 20, 5, 842);
    const GMIMC_BN_24_PARAMS = new GmimcParams(F, 24, 5, 1202);

    return {
        GMIMC_BN_3_PARAMS,
        GMIMC_BN_4_PARAMS,
        GMIMC_BN_5_PARAMS,
        GMIMC_BN_8_PARAMS,
        GMIMC_BN_9_PARAMS,
        GMIMC_BN_12_PARAMS,
        GMIMC_BN_16_PARAMS,
        GMIMC_BN_20_PARAMS,
        GMIMC_BN_24_PARAMS,
    };
}

module.exports = initializeParams;