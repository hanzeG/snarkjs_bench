const { dotProduct } = require("../fields/utils");
const { getCurveFromName } = require("ffjavascript");
const RescueParas = require("./rescue_ins");
class Rescue {
    constructor(F, rescueParas) {
        this.F = F;
        this.paras = rescueParas;
    }

    ExternalRound(input, r) {
        const F = this.F;
        const t = this.paras.t;
        const RC = this.paras.round_constants;
        const MDS_MATRIX = this.paras.mds;

        let current_state = Array(t).fill(F.zero);
        for (let i = 0; i < t; i++) {
            current_state[i] = dotProduct(F, input, MDS_MATRIX[i]);
        }

        for (let i = 0; i < t; i++) {
            current_state[i] = F.add(current_state[i], F.e(RC[r][i]));
        }

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    InternalRound(input, r) {
        const F = this.F;
        const t = this.paras.t;

        const INV = this.paras.INV;
        const d = this.paras.d;

        let current_state = input.map(a => F.e(a));

        if (r % 2 == 1) {
            for (let i = 0; i < t; i++) {
                current_state[i] = F.exp(current_state[i], INV);
            }
        } else {
            for (let i = 0; i < t; i++) {
                current_state[i] = F.exp(current_state[i], d);
            }
        }

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    Permutation(input) {
        const F = this.F;
        const t = this.paras.t;
        const rounds = this.paras.rounds;
        const RC = this.paras.round_constants;

        let current_state = input.map(a => F.e(a));

        for (let i = 0; i < t; i++) {
            current_state[i] = F.add(current_state[i], F.e(RC[0][i]));
        }

        current_state.map(a => F.toObject(a));

        for (let i = 1; i < rounds; i++) {
            current_state = this.InternalRound(current_state, i);

            current_state = this.ExternalRound(current_state, i);
        }

        let out = current_state;

        return out;
    }

}

module.exports = Rescue;
