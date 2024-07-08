const { rotateRight } = require("../utils");

class GMiMC {
    constructor(F, neptuneParas) {
        this.F = F;
        this.paras = neptuneParas;
    }

    Round(input, r) {
        const F = this.F;
        const t = this.paras.t;
        const RC = this.paras.round_constants;
        const out = Array(t);

        const pow5 = a => F.mul(a, F.square(F.square(a)));

        let current_state = input.map(a => F.e(a));

        // Calculate sigma for the first input plus rc
        let sigmaOut = pow5(F.add(current_state[0], F.e(RC[r])));

        // Set the first output value
        out[0] = F.toObject(current_state[0]);

        // Calculate the rest of the output values
        for (let i = 1; i < t; i++) {
            out[i] = F.toObject((F.add(current_state[i], sigmaOut)));
        }

        return out;
    }

    Permutation(input) {
        const F = this.F;
        const t = this.paras.t;
        const rounds = this.paras.rounds;

        let out = Array(t);

        let current_state = Array(t);
        current_state = input;

        for (let i = 0; i < rounds - 1; i++) {
            current_state = rotateRight(this.Round(current_state, i), 1);
        }

        out = this.Round(current_state, rounds - 1);

        return out;
    }

}

module.exports = GMiMC;
