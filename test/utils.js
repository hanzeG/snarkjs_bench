const { Scalar, getCurveFromName } = require("ffjavascript");
const crypto = require('crypto');

function getRandomScalar(n, r) {
    let scalar;
    let array = new Uint8Array(n);
    do {
        array = crypto.randomFillSync(array);
        scalar = Scalar.e(uint8ArrayToBigInt(array));
        scalar = scalar % r;
    } while (Scalar.gt(scalar.toString(), r.toString()));
    return scalar;
}

function generateRandomScalars(r, rounds, n) {
    const scalars = [];
    for (let i = 0; i < rounds; i++) {
        scalars.push(getRandomScalar(n, r));
    }
    return scalars;
}

function uint8ArrayToBigInt(uint8Array) {
    let hexString = Array.from(uint8Array)
        .map(byte => byte.toString(16).padStart(2, '0'))
        .join('');
    let bigIntValue = BigInt('0x' + hexString);
    return bigIntValue;
}

function bigIntToUint8Array(bigInt, arraySize) {
    const uint8Array = new Uint8Array(arraySize);

    let hexString = bigInt.toString(16);

    if (hexString.length % 2 !== 0) {
        hexString = '0' + hexString;
    }

    const byteArray = hexString.match(/.{1,2}/g).map(byte => parseInt(byte, 16));

    for (let i = 0; i < byteArray.length; i++) {
        uint8Array[arraySize - byteArray.length + i] = byteArray[i];
    }

    return uint8Array;
}

function rotateRight(arr, positions) {
    const len = arr.length;
    const offset = positions % len;
    if (offset === 0) return arr.slice();

    return arr.slice(-offset).concat(arr.slice(0, len - offset));
}

function swap(arr, index1, index2) {
    let newArr = [...arr];
    [newArr[index1], newArr[index2]] = [newArr[index2], newArr[index1]];

    return newArr;
}

module.exports = {
    getRandomScalar,
    generateRandomScalars,
    rotateRight,
    swap
};
