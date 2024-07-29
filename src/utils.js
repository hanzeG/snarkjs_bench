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
    rotateRight,
    swap
};