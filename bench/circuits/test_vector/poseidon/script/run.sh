CIRCUIT_NAME=mt_0
PTAU_NAME=pot12
PROOF_SYS="groth16"
echo "-------------------------------------------------------"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PARENT_DIR="$( dirname "$SCRIPT_DIR" )"
INPUT_DIR="$( dirname "$( dirname "$SCRIPT_DIR" )" )"
PTAU_DIR="$( dirname "$( dirname "$( dirname "$( dirname "$SCRIPT_DIR" )" )" )" )"

TARGET_DIR="$SCRIPT_DIR/circuit_gen"
GEN_DIR="$TARGET_DIR/${CIRCUIT_NAME}_js"

INPUT_JSON="$INPUT_DIR/circuit_input/$CIRCUIT_NAME.json"
CIRCUIT_CIRCOM="$PARENT_DIR/$CIRCUIT_NAME.circom"
PTAU_FILE="$PTAU_DIR/.ptau/${PTAU_NAME}_final.ptau"


GRANDPARENT_DIR="$( dirname "$PARENT_DIR" )"

mkdir -p $TARGET_DIR
time_sum=0

# ******************************************************
# ************* Circuit **************
# ******************************************************  
echo ">> 1.1. Compiling Circuit"
start=`date +%s`
circom "$CIRCUIT_CIRCOM" --r1cs --wasm --sym --c --wat --output "$TARGET_DIR"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc) 
time_sum=$(echo "$time_sum + $time_diff" | bc) 
formatted_time=$(printf "%.3f" $time_diff)
echo ">>Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 1.2. Generating Witness"
start=`date +%s`
node $GEN_DIR/generate_witness.js $GEN_DIR/$CIRCUIT_NAME.wasm $INPUT_JSON $TARGET_DIR/witness.wtns
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc) 
time_sum=$(echo "$time_sum + $time_diff" | bc) 
formatted_time=$(printf "%.3f" $time_diff)
echo ">>Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 1.3. Checking Witness"
start=`date +%s`
snarkjs wtns check $TARGET_DIR/$CIRCUIT_NAME.r1cs $TARGET_DIR/witness.wtns
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc) 
time_sum=$(echo "$time_sum + $time_diff" | bc) 
formatted_time=$(printf "%.3f" $time_diff)
echo ">>Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 1.4. Exporting Witness To JSON"
start=`date +%s`
snarkjs wtns export json $TARGET_DIR/witness.wtns $TARGET_DIR/witness.json
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc) 
time_sum=$(echo "$time_sum + $time_diff" | bc) 
formatted_time=$(printf "%.3f" $time_diff)
echo ">>Step Completed:"
echo "Time:($formatted_time s)"

# ******************************************************
# ************* Setup **************
# ******************************************************  
echo "-------------------------------------------------------"
echo ">> 2.1. Generating $PROOF_SYS zkey"
start=$(gdate +%s.%3N)
NODE_OPTIONS=--max-old-space-size=4000 snarkjs $PROOF_SYS setup $TARGET_DIR/$CIRCUIT_NAME.r1cs $PTAU_FILE $TARGET_DIR/$CIRCUIT_NAME"_0000.zkey"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 2.2 First contribution to zkey"
start=$(gdate +%s.%3N)
npx snarkjs zkey contribute $TARGET_DIR/$CIRCUIT_NAME"_0000.zkey" $TARGET_DIR/$CIRCUIT_NAME"_0001.zkey" --name="First Contribution to zkey" -v -e="GUO"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 2.3. Second contribution to zkey"
start=$(gdate +%s.%3N)
npx snarkjs zkey contribute $TARGET_DIR/$CIRCUIT_NAME"_0001.zkey" $TARGET_DIR/$CIRCUIT_NAME"_0002.zkey" --name="Second Contribution to zkey" -v -e="HANZE"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 2.4. Apply a random beacon"
start=$(gdate +%s.%3N)
snarkjs zkey beacon $TARGET_DIR/$CIRCUIT_NAME"_0002.zkey" $TARGET_DIR/$CIRCUIT_NAME"_{$PROOF_SYS}_final.zkey" 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 2.5. Verify the final zkey"
start=$(gdate +%s.%3N)
NODE_OPTIONS=--max-old-space-size=4000 snarkjs zkey verify $TARGET_DIR/$CIRCUIT_NAME.r1cs $PTAU_FILE $TARGET_DIR/$CIRCUIT_NAME"_{$PROOF_SYS}_final.zkey"
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 2.6. Exporting Verification Key"
start=$(gdate +%s.%3N)
NODE_OPTIONS=--max-old-space-size=4000 snarkjs zkey export verificationkey $TARGET_DIR/$CIRCUIT_NAME"_{$PROOF_SYS}_final.zkey" $TARGET_DIR/{$PROOF_SYS}_verification_key.json
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"

# ******************************************************
# ************* Prove **************
# ****************************************************** 
echo "-------------------------------------------------------"
echo ">> 3.1. Generating proof by $PROOF_SYS"
start=$(gdate +%s.%3N)
NODE_OPTIONS=--max-old-space-size=4000 snarkjs $PROOF_SYS prove $TARGET_DIR/$CIRCUIT_NAME"_{$PROOF_SYS}_final.zkey" $TARGET_DIR/witness.wtns $TARGET_DIR/{$PROOF_SYS}_proof.json $TARGET_DIR/{$PROOF_SYS}_public.json
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">> 3.2. Verifying proof"
start=$(gdate +%s.%3N)
NODE_OPTIONS=--max-old-space-size=4000 snarkjs $PROOF_SYS verify $TARGET_DIR/{$PROOF_SYS}_verification_key.json $TARGET_DIR/{$PROOF_SYS}_public.json $TARGET_DIR/{$PROOF_SYS}_proof.json
end=$(gdate +%s.%3N)
time_diff=$(echo "$end - $start" | bc)
time_sum=$(echo "$time_sum + $time_diff" | bc)
formatted_time=$(printf "%.3f" $time_diff)
echo ">> Step Completed:"
echo "Time:($formatted_time s)"
echo "-------------------------------------------------------"
echo ">>Total Time Taken: $time_sum s"

