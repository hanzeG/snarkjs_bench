function getRandomBigInt(bits) {
    const hexLength = Math.ceil(bits / 4);
    let hexString = '0x';

    for (let i = 0; i < hexLength; i++) {
        hexString += Math.floor(Math.random() * 16).toString(16);
    }

    return BigInt(hexString);
}

function getRandomBigIntArray(n, bits) {
    const bigIntArray = [];
    for (let i = 0; i < n; i++) {
        bigIntArray.push(getRandomBigInt(bits));
    }
    return bigIntArray;
}

// const randomBigIntArray = getRandomBigIntArray(10, 256);
// console.log(randomBigIntArray);

module.exports = {
    getRandomBigInt,
    getRandomBigIntArray
};
