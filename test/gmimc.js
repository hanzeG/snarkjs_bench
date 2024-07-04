const chai = require("chai");
const path = require("path");
const wasm_tester = require("circom_tester").wasm;
const assert = chai.assert;

const { utils, getCurveFromName } = require("ffjavascript");

const fs = require('fs');
const { generateRandomScalars, rotateRight, sigma } = require("./utils.js");

const gmimc_constants = require("./gmimc_constants.js");
const { RC } = utils.unstringifyBigInts(gmimc_constants);

async function getGmimcParams(rounds, r) {
    const randomScalars = generateRandomScalars(r, rounds, 32);
    const data = {
        round_constants: randomScalars.map(num => num.toString())
    };
    fs.writeFile('test/gmimc_constants.json', JSON.stringify(data, null, 2), (err) => {
        if (err) {
            console.error('Error writing to file', err);
        } else {
            console.log('Successfully wrote to file');
        }
    });
    return {
        round_constants: randomScalars
    };
}

// GMiMC Round function
function round(input, rc, F) {
    const t = input.length;
    const out = Array(t);

    const pow5 = a => F.mul(a, F.square(F.square(a)));

    let current_state = input.map(a => F.e(a));

    // Calculate sigma for the first input plus rc
    let sigmaOut = pow5(F.add(current_state[0], F.e(rc)));

    // Set the first output value
    out[0] = F.toObject(current_state[0]);

    // Calculate the rest of the output values
    for (let i = 1; i < t; i++) {
        out[i] = F.toObject((F.add(current_state[i], sigmaOut)));
    }

    return out;
}

function gmimcPermutation(F, input, rounds, RC) {
    const t = input.length;
    let out = Array(t);

    let current_state = Array(t);
    current_state = input;

    for (let i = 0; i < rounds - 1; i++) {
        current_state = rotateRight(round(current_state, RC[i], F), 1);
    }

    out = round(current_state, RC.at(-1), F);

    return out;
}

describe("Gmimc Circuit test", function () {
    let prime;
    let F;
    let rounds;
    let round_constants;
    let circuit;

    this.timeout(1000000);

    before(async () => {
        prime = await getCurveFromName("bn128", true);
        F = prime.Fr;
        rounds = 226;
        round_constants = RC;
        circuit = await wasm_tester(path.join(__dirname, "circuits", "gmimc_test.circom"));
    });

    it("Should check consistence of different preimages when t = 3", async () => {
        const input = [21155829957722357464390155308839862997858020023166902334429567144095139153087n
            , 10712979148478103124883713801454257711869590356686325834712887222913173040627n
            , 16103916301700800472539073060664555415890331015680925551197759284562399937798n];

        // const bigIntInput = input.map(x => BigInt(x));

        const res2 = gmimcPermutation(F, input, rounds, round_constants);

        const w = await circuit.calculateWitness({ inputs: input });

        await circuit.assertOut(w, { out: res2 });
        await circuit.checkConstraints(w);
    });

});