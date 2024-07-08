const { randomScalar, randomScalarNotZero } = require("../fields/utils");

class NeptuneParams {
    constructor(F, t, d, roundsF, roundsP) {
        if (![3, 5, 7].includes(d)) {
            throw new Error('Invalid sbox degree');
        }

        if (roundsF % 2 !== 0) {
            throw new Error('Invalid full rounds');
        }

        if (t % 2 !== 0) {
            throw new Error('Invalid input length');
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

        this.E = this.instantiateE();
        this.U = this.instantiateU();
        this.ABC = this.instantiateABC();

        this.a_ = [this.ABC[0], this.ABC[0], this.ABC[0]];
        this.a_[0] = this.F.square(this.a_[0]);
        this.a_[1] = this.F.add(this.a_[1], this.a_[1]);
        this.a_[2] = this.a_[1];
        this.a_[1] = this.F.add(this.a_[1], this.ABC[0]);
        this.a_[2] = this.F.add(this.a_[2], this.a_[2]);
    }

    instantiateRC() {
        const roundConstants = [];
        for (let i = 0; i < this.rounds; i++) {
            let rc = [];
            for (let j = 0; j < this.t; j++) {
                rc.push(randomScalar(this.F));
            }
            roundConstants.push(rc);
        }
        return roundConstants;
    }

    instantiateABC() {
        const abc = [this.F.e(1n), this.F.e(1n), randomScalar(this.F)];
        return abc;
    }

    instantiateU() {
        return Array.from({ length: this.t }, () => {
            const tmp = randomScalarNotZero(this.F);
            return this.F.sub(tmp, this.F.zero);
        });
    }

    instantiateE() {
        const t_ = this.t >> 1;
        const mat = Array.from({ length: this.t }, () => Array(this.t).fill(this.F.zero));

        let m_, m__;

        if (this.t === 4) {
            m_ = this.circ_mat([this.F.e(2n), this.F.e(1n)]);
            m__ = this.circ_mat([this.F.e(1n), this.F.e(2n)]);
        } else if (this.t === 8) {
            m_ = this.circ_mat([this.F.e(3n), this.F.e(2n), this.F.e(1n), this.F.e(1n)]);
            m__ = this.circ_mat([this.F.e(1n), this.F.e(1n), this.F.e(2n), this.F.e(3n)]);
        } else {
            m_ = Array.from({ length: t_ }, () =>
                Array.from({ length: t_ }, () => randomScalarNotZero(this.F))
            );
            m__ = Array.from({ length: t_ }, () =>
                Array.from({ length: t_ }, () => randomScalarNotZero(this.F))
            );
        }

        for (let row = 0; row < t_; row++) {
            for (let col = 0; col < t_; col++) {
                mat[2 * row][2 * col] = m_[row][col];
            }
        }

        for (let row = 0; row < t_; row++) {
            for (let col = 0; col < t_; col++) {
                mat[2 * row + 1][2 * col + 1] = m__[row][col];
            }
        }

        return mat;
    }

    circ_mat(row) {
        const t = row.length;
        const mat = [];
        let rot = row.slice();
        mat.push(rot.slice());
        for (let i = 1; i < t; i++) {
            rot.unshift(rot.pop());
            mat.push(rot.slice());
        }
        return mat;
    }

}

module.exports = NeptuneParams;

