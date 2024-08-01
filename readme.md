# ZK-Friendly Hash Function Implementation in Circom

This repository contains the Circom implementations of the GMiMC, Neptune, Poseidon2, and Rescue hash functions. Circom is a domain-specific language designed for zero-knowledge proofs.

## Installation

1. Clone the repo: `git clone https://github.com/hanzeG/zklib_circom.git`

2. Install pre-requisites: `npm i`

3. Download circom: follow the instructions at [installing circom](https://docs.circom.io/getting-started/installation/).

4. Download snarkjs: `npm install -g snarkjs`

## Test Hash Functions

1. Test Poseidon2 Permutation with instance constants: `test_p2`

2. Test GMiMC Permutation with instance constants: `test_g`

3. Test Neptune Permutation with instance constants: `test_n`

4. Test Rescue Permutation with instance constants: `test_r`

## Benchmark

1. Benchmark in groth16: bash `./bench/groth16.sh`

2. Benchmark in plonk: bash `./bench/plonk.sh`

3. Benchmark in fflonk: bash `./bench/fflonk.sh`
