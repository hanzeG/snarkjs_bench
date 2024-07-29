const chai = require("chai");
const path = require("path");
const wasm_tester = require("circom_tester").wasm;

const { utils, getCurveFromName } = require("ffjavascript");

const rescueConstants = require("./rescue_constants.js");

const { round_constants, mds_matrix } = utils.unstringifyBigInts(rescueConstants);

const rescue = require("../src/rescue/rescue.js");

const rescueParas = require("../src/rescue/rescue_ins.js");

describe("Rescue Circuit test", function () {
    let prime;
    let F;
    let rounds;
    let rc;
    let mds;
    let circuit;

    this.timeout(1000000);

    before(async () => {
        prime = await getCurveFromName("bn128", true);
        F = prime.Fr;
        rounds = 45;
        rc = round_constants;
        mds = mds_matrix;
        circuit = await wasm_tester(path.join(__dirname, "circuits", "rescue_test.circom"));
    });

    it("Should check consistence of different preimages when t = 3", async () => {
        const input = [28829699159647608n, 7521419745152037748n, 2n];

        // const bigIntInput = input.map(x => BigInt(x));

        const paras = new rescueParas(F, 3, 5, 0x26b6a528b427b35493736af8679aad17535cb9d394945a0dcfe7f7a98ccccccdn, 45);

        const rq = new rescue(F, paras);

        const res2 = rq.Permutation(input);

        const w = await circuit.calculateWitness({ inputs: input });

        await circuit.assertOut(w, { out: res2 });
        await circuit.checkConstraints(w);
    });

});