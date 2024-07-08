const { randomScalar } = require("../fields/utils");

class GMiMCParams {
    constructor(F, t, d, rounds) {
        if (![3, 5, 7].includes(d)) {
            throw new Error('Invalid sbox degree');
        }

        this.F = F;
        this.t = t;
        this.d = d;
        this.rounds = rounds;
        this.round_constants = this.instantiateRC();
    }

    instantiateRC() {
        const roundConstants = [];
        for (let i = 0; i < this.rounds; i++) {
            roundConstants.push(randomScalar(this.F));
        }
        return roundConstants;
    }
}

module.exports = GMiMCParams;
