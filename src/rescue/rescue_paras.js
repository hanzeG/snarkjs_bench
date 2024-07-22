const { randomScalar } = require("../fields/utils");

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
        const roundConstants = [];
        for (let i = 0; i < this.rounds; i++) {
            let rc = [];

            for (let j = 1; j < this.t; j++) {
                rc.push(randomScalar(this.F));
            }

            roundConstants.push(rc);
        }

        return roundConstants;
    }

    instantiateMDS() {
        const roundConstants = [];
        for (let i = 0; i < this.t; i++) {
            let rc = [];

            for (let j = 1; j < this.t; j++) {
                rc.push(randomScalar(this.F));
            }
            roundConstants.push(rc);
        }

        return roundConstants;
    }
}

module.exports = RescueParas;