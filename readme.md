# ZK-Friendly Hash Function Implementation in Circom

This repository contains the Circom implementations of the GMiMC, Neptune, Poseidon2, and Rescue hash functions. Circom is a domain-specific language designed for zero-knowledge proofs. Plain permutation and parameters generation (still need security check) implementation is at `./src` using [ffjavascript v0.3.0](https://github.com/iden3/ffjavascript.git), circuit templates are at `./circuits` using [Circom v2.1.9](https://github.com/iden3/circom.git), and a simple benchmark script written in bash is at `./bench`.

## Installation

1. Clone the repo: `git clone https://github.com/hanzeG/zklib_circom.git`

2. Install pre-requisites: `npm i`

3. Download Circom: follow the instructions at [installing Circom](https://docs.circom.io/getting-started/installation/).

4. Download snarkjs: `npm install -g snarkjs`

## Test Hash Functions

1. Test Poseidon2 Permutation with [instance constants](https://github.com/HorizenLabs/poseidon2.git): `npm run test_p2`

2. Test GMiMC Permutation with [instance constants](https://github.com/HorizenLabs/poseidon2.git): `npm run test_g`

3. Test Neptune Permutation with [instance constants](https://github.com/HorizenLabs/poseidon2.git): `npm run test_n`

4. Test Rescue Permutation with [instance constants](https://github.com/fluidex/rescue-hash-js.git): `npm run test_r`

## Benchmark

1. Benchmark in groth16: `bash ./bench/groth16.sh`

2. Benchmark in plonk: `bash ./bench/plonk.sh`

3. Benchmark in fflonk: `bash ./bench/fflonk.sh`
