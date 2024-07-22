const { unstringifyBigInts } = require("ffjavascript").utils;
const {
    mds_matrix: MDS_MATRIX,
    round_constants: ROUND_CONSTANTS
} = unstringifyBigInts(require("../../test/rescue_constants.js"));

class RescueParas {
    constructor(F, t, d, INV, rounds) {
        if (![5].includes(d)) {
            throw new Error('Invalid sbox degree');
        }

        this.F = F;
        this.t = t;
        this.d = d;
        this.rounds = rounds;
        this.INV = INV;
        this.round_constants = this.instantiateRC();
        this.mds = this.instantiateMDS();
    }

    instantiateRC() {


        return ROUND_CONSTANTS;
    }

    instantiateMDS() {

        return MDS_MATRIX;
    }
}

module.exports = RescueParas;