#!/bin/bash

CIRCUIT_DIRS=(
    # "circuits/test_vector/mimc/mt_0"
    # "circuits/test_vector/mimc/mt_1"
    # "circuits/test_vector/mimc/mt_2"
    # "circuits/test_vector/mimc/mt_3"
    # "circuits/test_vector/mimc/mt_4"
    # "circuits/test_vector/mimc/mt_5"
    # "circuits/test_vector/mimc/mt_6"
    # "circuits/test_vector/mimc/mt_7"
    # "circuits/test_vector/mimc/mt_8"
    # "circuits/test_vector/mimc/mt_9"
    # "circuits/test_vector/mimc/mt_10"

    # "circuits/test_vector/poseidon/mt_0"
    # "circuits/test_vector/poseidon/mt_1"
    # "circuits/test_vector/poseidon/mt_2"
    # "circuits/test_vector/poseidon/mt_3"
    # "circuits/test_vector/poseidon/mt_4"
    # "circuits/test_vector/poseidon/mt_5"
    # "circuits/test_vector/poseidon/mt_6"
    # "circuits/test_vector/poseidon/mt_7"
    # "circuits/test_vector/poseidon/mt_8"
    # "circuits/test_vector/poseidon/mt_9"
    # "circuits/test_vector/poseidon/mt_10"

    # "circuits/test_vector/poseidon2/mt_0"
    # "circuits/test_vector/poseidon2/mt_1"
    # "circuits/test_vector/poseidon2/mt_2"
    # "circuits/test_vector/poseidon2/mt_3"
    # "circuits/test_vector/poseidon2/mt_4"
    # "circuits/test_vector/poseidon2/mt_5"
    # "circuits/test_vector/poseidon2/mt_6"
    # "circuits/test_vector/poseidon2/mt_7"
    # "circuits/test_vector/poseidon2/mt_8"
    # "circuits/test_vector/poseidon2/mt_9"
    # "circuits/test_vector/poseidon2/mt_10"

    "circuits/test_vector/neptune/mt_0"
    # "circuits/test_vector/neptune/mt_1"
    # "circuits/test_vector/neptune/mt_2"
    # "circuits/test_vector/neptune/mt_3"
    # "circuits/test_vector/neptune/mt_4"
    # "circuits/test_vector/neptune/mt_5"
    # "circuits/test_vector/neptune/mt_6"
    # "circuits/test_vector/neptune/mt_7"
    # "circuits/test_vector/neptune/mt_8"
    # "circuits/test_vector/neptune/mt_9"
    # "circuits/test_vector/neptune/mt_10"

    "circuits/test_vector/gmimc/mt_0"
    # "circuits/test_vector/gmimc/mt_1"
    # "circuits/test_vector/gmimc/mt_2"
    # "circuits/test_vector/gmimc/mt_3"
    # "circuits/test_vector/gmimc/mt_4"
    # "circuits/test_vector/gmimc/mt_5"
    # "circuits/test_vector/gmimc/mt_6"
    # "circuits/test_vector/gmimc/mt_7"
    # "circuits/test_vector/gmimc/mt_8"
    # "circuits/test_vector/gmimc/mt_9"
    # "circuits/test_vector/gmimc/mt_10"

    "circuits/test_vector/rescue/mt_0"
    # "circuits/test_vector/rescue/mt_1"
    # "circuits/test_vector/rescue/mt_2"
    # "circuits/test_vector/rescue/mt_3"
    # "circuits/test_vector/rescue/mt_4"
    # "circuits/test_vector/rescue/mt_5"
    # "circuits/test_vector/rescue/mt_6"
    # "circuits/test_vector/rescue/mt_7"
    # "circuits/test_vector/rescue/mt_8"
    # "circuits/test_vector/rescue/mt_9"
    # "circuits/test_vector/rescue/mt_10"
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TARGET_DIR="$SCRIPT_DIR/circuit_gen"

RESULTS_FILE="$SCRIPT_DIR/results.json"

# Initialize JSON file
echo "{}" > "$RESULTS_FILE"

for CIRCUIT_DIR in "${CIRCUIT_DIRS[@]}"
do
    # Extract family and h values
    FAMILY="$(basename "$(dirname "$CIRCUIT_DIR")")"
    H="$(basename "$CIRCUIT_DIR")"

    CIRCUIT="$SCRIPT_DIR/$CIRCUIT_DIR.circom"
    PTAU="$SCRIPT_DIR/.ptau/pot16_final.ptau"
    INPUT="$SCRIPT_DIR/circuits/$FAMILY/input/${H}.json"
    GEN_DIR="$TARGET_DIR/${H}_js"

    mkdir -p $TARGET_DIR

    echo ">> ---------- TEST CASE: $FAMILY, $H in Groth16 ----------"

    # Debug: Print extracted values
    # echo "Debug: FAMILY = $FAMILY, H = $H"

    # ******************************************************
    # ************* Witness **************
    # ****************************************************** 
    
    echo ">> 1.1 Compiling Circuit"
    circom $CIRCUIT --r1cs --wasm --sym --c --wat --output "$TARGET_DIR"
    echo "-------------------------------------------------------"
    echo ">> 1.2 Generating Witness"
    node $GEN_DIR/generate_witness.js $GEN_DIR/$H.wasm $INPUT $TARGET_DIR/witness.wtns
    echo "-------------------------------------------------------"

    # ******************************************************
    # ************* Setup **************
    # ******************************************************  
    echo ">> 2.1 Generating Groth16 zkey"
    NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs groth16 setup $TARGET_DIR/$H.r1cs $PTAU $TARGET_DIR/$H"_groth16_final.zkey"
    echo "-------------------------------------------------------"
    # echo ">> 2.2 First contribution to zkey"
    # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey contribute $TARGET_DIR/$H"_0000.zkey" $TARGET_DIR/$H"_0001.zkey" --name="First Contribution to zkey" -v -e="GUO"
    # echo "-------------------------------------------------------"
    # echo ">> 2.3 Second contribution to zkey"
    # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey contribute $TARGET_DIR/$H"_0001.zkey" $TARGET_DIR/$H"_0002.zkey" --name="Second Contribution to zkey" -v -e="HANZE"
    # echo "-------------------------------------------------------"
    # echo ">> 2.4 Apply a random beacon"
    # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey beacon $TARGET_DIR/$H"_0002.zkey" $TARGET_DIR/$H"_${PROOF_SY}_final.zkey" 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"
    # echo "-------------------------------------------------------"
    echo ">> 2.5. Exporting Verification Key"
    NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey export verificationkey $TARGET_DIR/$H"_groth16_final.zkey" $TARGET_DIR/groth16_verification_key.json
    echo "-------------------------------------------------------"

    # ******************************************************
    # ************* Prove **************
    # ****************************************************** 
    echo ">> 3.1 Generating proof by Groth16"
    # Corrected command
    TIME_OUTPUT=$( { NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs groth16 prove $TARGET_DIR/$H"_groth16_final.zkey" $TARGET_DIR/witness.wtns $TARGET_DIR/groth16_proof.json $TARGET_DIR/groth16_public.json > /dev/null; } 2>&1 )

    # Extract user time and maximum resident set size
    USER_TIME=$(echo "$TIME_OUTPUT" | grep 'user' | awk '{print $1}')
    MAX_RSS=$(echo "$TIME_OUTPUT" | grep 'maximum resident set size' | awk '{print $1}')

    # Build JSON object
    COMMAND_JSON=$(jq -n \
        --arg user_time "$USER_TIME" \
        --arg max_rss "$MAX_RSS" \
        '{user_time: $user_time, max_resident_size: $max_rss}')

    # Update JSON file
    jq --arg family "$FAMILY" --arg h "$H" --argjson data "$COMMAND_JSON" \
       '(.[$family] //= {} ) | .[$family][$h].prove = $data' \
       "$RESULTS_FILE" > tmp.$$.json && mv tmp.$$.json "$RESULTS_FILE"

    echo ">> 1.1 Generated Proof, user time: $USER_TIME, max ram: $MAX_RSS"

    # ******************************************************
    # ************* Verify **************
    # ****************************************************** 
    # Corrected command
    TIME_OUTPUT=$( { NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs groth16 verify $TARGET_DIR/groth16_verification_key.json $TARGET_DIR/groth16_public.json $TARGET_DIR/groth16_proof.json > /dev/null; } 2>&1 )

    # Extract user time and maximum resident set size
    USER_TIME=$(echo "$TIME_OUTPUT" | grep 'user' | awk '{print $1}')
    MAX_RSS=$(echo "$TIME_OUTPUT" | grep 'maximum resident set size' | awk '{print $1}')

    # Build JSON object
    COMMAND_JSON=$(jq -n \
        --arg user_time "$USER_TIME" \
        --arg max_rss "$MAX_RSS" \
        '{user_time: $user_time, max_resident_size: $max_rss}')

    # Update JSON file
    jq --arg family "$FAMILY" --arg h "$H" --argjson data "$COMMAND_JSON" \
       '(.[$family] //= {} ) | .[$family][$h].verify = $data' \
       "$RESULTS_FILE" > tmp.$$.json && mv tmp.$$.json "$RESULTS_FILE"

    echo ">> 2.1 Verified, user time: $USER_TIME, max ram: $MAX_RSS"
done