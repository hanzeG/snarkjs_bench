const { randomScalar } = require("../fields/utils");

class Poseidon2Params {
    constructor(F, t, d, roundsF, roundsP) {
        if (![3, 5, 7, 11].includes(d)) {
            throw new Error('Invalid sbox degree');
        }

        if (roundsF % 2 !== 0) {
            throw new Error('Invalid full rounds');
        }

        const r = roundsF / 2;
        const rounds = roundsF + roundsP;

        this.F = F;
        this.t = t;
        this.d = d;
        this.roundsF_beginning = r;
        this.roundsP = roundsP;
        this.roundsF_end = r;
        this.rounds = rounds;
        this.round_constants = this.instantiateRC();
    }

    instantiateRC() {
        const roundConstants = [];
        for (let i = 0; i < this.rounds; i++) {
            let rc = [];
            if (i > this.roundsF_beginning - 1 && i < this.rounds - this.roundsF_end) {
                rc.push(randomScalar(this.F));
                for (let j = 1; j < this.t; j++) {
                    rc.push(this.F.zero);
                }
            } else {
                for (let j = 0; j < this.t; j++) {
                    rc.push(randomScalar(this.F));
                }
            }
            roundConstants.push(rc);
        }
        return roundConstants;
    }
}

module.exports = Poseidon2Params;