class Poseidon2 {
    constructor(F, neptuneParas) {
        this.F = F;
        this.paras = neptuneParas;
    }

    External4(input) {
        const F = this.F;
        const t = this.paras.t;

        let t4 = t / 4;
        let current_state = input.map(a => F.e(a));

        for (let i = 0; i < t4; i++) {
            let tmp = new Array(8);
            tmp[0] = F.add(current_state[0 + i * 4], current_state[1 + i * 4]);
            tmp[1] = F.add(current_state[2 + i * 4], current_state[3 + i * 4]);
            tmp[2] = F.add(F.mul(current_state[1 + i * 4], F.e(2n)), tmp[1]);
            tmp[3] = F.add(F.mul(current_state[3 + i * 4], F.e(2n)), tmp[0]);
            tmp[4] = F.add(F.mul(tmp[1], F.e(4n)), tmp[3]);
            tmp[5] = F.add(F.mul(tmp[0], F.e(4n)), tmp[2]);
            tmp[6] = F.add(tmp[3], tmp[5]);
            tmp[7] = F.add(tmp[2], tmp[4]);

            current_state[0 + i * 4] = tmp[6];
            current_state[1 + i * 4] = tmp[5];
            current_state[2 + i * 4] = tmp[7];
            current_state[3 + i * 4] = tmp[4];
        }

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    ExternalRound(input) {
        const F = this.F;
        const t = this.paras.t;

        let current_state = input.map(a => F.e(a));

        if (t < 4) {
            let sum = current_state.reduce((acc, el) => F.add(acc, el));
            current_state = current_state.map(a => F.add(a, sum));
        } else if (t == 4) {
            current_state = this.External4(input);
        } else {
            let inp = current_state;
            current_state = this.External4(input);
            let store = new Array(4);

            let t4 = t / 4;
            for (let i = 0; i < 4; i++) {
                store[i] = current_state[i];
                for (let j = 0; i < t4; j++) {
                    store[i] = F.add(store[i], current_state[i + 4 * j]);
                }
            }
            for (let i = 0; i < t4; i++) {
                current_state[i * 4 + 0] = F.add(store[0], inp[i * 4 + 0]);
                current_state[i * 4 + 1] = F.add(store[1], inp[i * 4 + 1]);
                current_state[i * 4 + 2] = F.add(store[2], inp[i * 4 + 2]);
                current_state[i * 4 + 3] = F.add(store[3], inp[i * 4 + 3]);
            }
        }
        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    InternalRound(input) {
        const F = this.F;

        let current_state = input.map(a => F.e(a));

        let inp = current_state;

        let sum = current_state.reduce((acc, el) => F.add(acc, el));

        // to do t!=3
        current_state = current_state.map(a => F.add(a, sum));
        current_state[2] = F.add(current_state[2], inp[2]);

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    ExternalSbox(input, r) {
        const F = this.F;
        const t = this.paras.t;
        const RC = this.paras.round_constants;

        let current_state = input.map(a => F.e(a));

        const pow5 = a => F.mul(a, F.square(F.square(a)));

        for (let i = 0; i < t; i++) {
            current_state[i] = F.add(current_state[i], RC[r][i]);
            current_state[i] = pow5(current_state[i]);
        }

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    InternalSbox(input, r) {
        const F = this.F;
        const t = this.paras.t;
        const RC = this.paras.round_constants;

        let current_state = input.map(a => F.e(a));

        const pow5 = a => F.mul(a, F.square(F.square(a)));

        current_state[0] = F.add(current_state[0], RC[r][0]);
        current_state[0] = pow5(current_state[0]);

        let out = current_state.map(a => F.toObject(a));

        return out;
    }

    Permutation(input) {
        const roundsF_beginning = this.paras.roundsF_beginning;
        const roundsF_end = this.paras.roundsF_end;
        const roundsP = this.paras.roundsP;

        let current_state = this.ExternalRound(input);

        for (let i = 0; i < roundsF_beginning; i++) {
            current_state = this.ExternalSbox(current_state, i);
            current_state = this.ExternalRound(current_state);
        }

        for (let i = 0; i < roundsP; i++) {
            current_state = this.InternalSbox(current_state, i + roundsF_beginning);
            current_state = this.InternalRound(current_state);
        }

        for (let i = 0; i < roundsF_end; i++) {
            current_state = this.ExternalSbox(current_state, i + roundsF_beginning + roundsP);
            current_state = this.ExternalRound(current_state);
        }

        let out = current_state;

        return out;
    }
}

module.exports = Poseidon2;
