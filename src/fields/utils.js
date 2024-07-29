const { utils } = require("ffjavascript");
const crypto = require("crypto");

function dotProduct(F, a, b) {
    let out = F.zero;
    let in1 = a.map(a => F.e(a));
    let in2 = b.map(a => F.e(a));

    for (let i = 0; i < a.length; i++) {
        out = F.add(out, F.mul(in1[i], in2[i]));
    }
    return out;
}

function randomScalar(F) {
    let buff = new Uint8Array(32);
    let randomBuff = crypto.randomFillSync(buff);
    let randomInt = utils.leBuff2int(randomBuff);
    let scalar = F.e(randomInt);
    return scalar;
}

function randomScalarNotZero(F) {
    let scalar = randomScalar(F);
    do {
        scalar = randomScalar(F);
    } while (F.isZero(scalar));
    return scalar;
}

module.exports = {
    randomScalar,
    randomScalarNotZero,
    dotProduct
};