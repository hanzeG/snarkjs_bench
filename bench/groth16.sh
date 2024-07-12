# declare -A PTAU_NAMES
# PTAU_NAMES=( 
#     ["circuits/test_vector/gmimc/mt_0"]="pot10_final" 
#     ["circuits/test_vector/gmimc/mt_1"]="pot11_final" 
#     ["circuits/test_vector/gmimc/mt_2"]="pot13_final" 
#     ["circuits/test_vector/gmimc/mt_3"]="pot14_final" 
#     ["circuits/test_vector/gmimc/mt_4"]="pot15_final" 
#     ["circuits/test_vector/gmimc/mt_5"]="pot16_final" 
#     ["circuits/test_vector/gmimc/mt_6"]="pot17_final" 
#     ["circuits/test_vector/gmimc/mt_7"]="pot18_final" 
#     ["circuits/test_vector/gmimc/mt_8"]="pot19_final" 
#     ["circuits/test_vector/gmimc/mt_9"]="pot20_final" 
#     ["circuits/test_vector/gmimc/mt_10"]="pot21_final" 

#     ["circuits/test_vector/mimc/mt_0"]="pot11_final" 
#     ["circuits/test_vector/mimc/mt_1"]="pot12_final" 
#     ["circuits/test_vector/mimc/mt_2"]="pot14_final" 
#     ["circuits/test_vector/mimc/mt_3"]="pot15_final" 
#     ["circuits/test_vector/mimc/mt_4"]="pot16_final" 
#     ["circuits/test_vector/mimc/mt_5"]="pot17_final" 
#     ["circuits/test_vector/mimc/mt_6"]="pot18_final" 
#     ["circuits/test_vector/mimc/mt_7"]="pot19_final" 
#     ["circuits/test_vector/mimc/mt_8"]="pot20_final" 
#     ["circuits/test_vector/mimc/mt_9"]="pot21_final" 
#     ["circuits/test_vector/mimc/mt_10"]="pot22_final" 

#     ["circuits/test_vector/poseidon/mt_0"]="pot8_final" 
#     ["circuits/test_vector/poseidon/mt_1"]="pot10_final" 
#     ["circuits/test_vector/poseidon/mt_2"]="pot11_final" 
#     ["circuits/test_vector/poseidon/mt_3"]="pot12_final" 
#     ["circuits/test_vector/poseidon/mt_4"]="pot13_final" 
#     ["circuits/test_vector/poseidon/mt_5"]="pot14_final" 
#     ["circuits/test_vector/poseidon/mt_6"]="pot15_final" 
#     ["circuits/test_vector/poseidon/mt_7"]="pot16_final" 
#     ["circuits/test_vector/poseidon/mt_8"]="pot17_final" 
#     ["circuits/test_vector/poseidon/mt_9"]="pot18_final" 
#     ["circuits/test_vector/poseidon/mt_10"]="pot19_final" 

#     ["circuits/test_vector/poseidon2/mt_0"]="pot8_final" 
#     ["circuits/test_vector/poseidon2/mt_1"]="pot10_final" 
#     ["circuits/test_vector/poseidon2/mt_2"]="pot11_final" 
#     ["circuits/test_vector/poseidon2/mt_3"]="pot12_final" 
#     ["circuits/test_vector/poseidon2/mt_4"]="pot13_final" 
#     ["circuits/test_vector/poseidon2/mt_5"]="pot14_final" 
#     ["circuits/test_vector/poseidon2/mt_6"]="pot15_final" 
#     ["circuits/test_vector/poseidon2/mt_7"]="pot16_final" 
#     ["circuits/test_vector/poseidon2/mt_8"]="pot17_final" 
#     ["circuits/test_vector/poseidon2/mt_9"]="pot18_final" 
#     ["circuits/test_vector/poseidon2/mt_10"]="pot19_final" 

#     ["circuits/test_vector/neptune/mt_0"]="pot8_final" 
#     ["circuits/test_vector/neptune/mt_1"]="pot10_final" 
#     ["circuits/test_vector/neptune/mt_2"]="pot11_final" 
#     ["circuits/test_vector/neptune/mt_3"]="pot12_final" 
#     ["circuits/test_vector/neptune/mt_4"]="pot13_final" 
#     ["circuits/test_vector/neptune/mt_5"]="pot14_final" 
#     ["circuits/test_vector/neptune/mt_6"]="pot15_final" 
#     ["circuits/test_vector/neptune/mt_7"]="pot16_final" 
#     ["circuits/test_vector/neptune/mt_8"]="pot17_final" 
#     ["circuits/test_vector/neptune/mt_9"]="pot18_final" 
#     ["circuits/test_vector/neptune/mt_10"]="pot19_final" 
# )

# declare -A INPUT_NAMES
# INPUT_NAMES=( 
#     ["circuits/test_vector/gmimc/mt_0"]="mt_0" 
#     ["circuits/test_vector/gmimc/mt_1"]="mt_1" 
#     ["circuits/test_vector/gmimc/mt_2"]="mt_2" 
#     ["circuits/test_vector/gmimc/mt_3"]="mt_3" 
#     ["circuits/test_vector/gmimc/mt_4"]="mt_4" 
#     ["circuits/test_vector/gmimc/mt_5"]="mt_5" 
#     ["circuits/test_vector/gmimc/mt_6"]="mt_6" 
#     ["circuits/test_vector/gmimc/mt_7"]="mt_7" 
#     ["circuits/test_vector/gmimc/mt_8"]="mt_8" 
#     ["circuits/test_vector/gmimc/mt_9"]="mt_9" 
#     ["circuits/test_vector/gmimc/mt_10"]="mt_10" 

#     ["circuits/test_vector/mimc/mt_0"]="mt_0" 
#     ["circuits/test_vector/mimc/mt_1"]="mt_1" 
#     ["circuits/test_vector/mimc/mt_2"]="mt_2" 
#     ["circuits/test_vector/mimc/mt_3"]="mt_3" 
#     ["circuits/test_vector/mimc/mt_4"]="mt_4" 
#     ["circuits/test_vector/mimc/mt_5"]="mt_5" 
#     ["circuits/test_vector/mimc/mt_6"]="mt_6" 
#     ["circuits/test_vector/mimc/mt_7"]="mt_7" 
#     ["circuits/test_vector/mimc/mt_8"]="mt_8" 
#     ["circuits/test_vector/mimc/mt_9"]="mt_9" 
#     ["circuits/test_vector/mimc/mt_10"]="mt_10" 

#     ["circuits/test_vector/poseidon/mt_0"]="mt_0" 
#     ["circuits/test_vector/poseidon/mt_1"]="mt_1" 
#     ["circuits/test_vector/poseidon/mt_2"]="mt_2" 
#     ["circuits/test_vector/poseidon/mt_3"]="mt_3" 
#     ["circuits/test_vector/poseidon/mt_4"]="mt_4" 
#     ["circuits/test_vector/poseidon/mt_5"]="mt_5" 
#     ["circuits/test_vector/poseidon/mt_6"]="mt_6" 
#     ["circuits/test_vector/poseidon/mt_7"]="mt_7" 
#     ["circuits/test_vector/poseidon/mt_8"]="mt_8" 
#     ["circuits/test_vector/poseidon/mt_9"]="mt_9" 
#     ["circuits/test_vector/poseidon/mt_10"]="mt_10" 

#     ["circuits/test_vector/poseidon2/mt_0"]="mt_0" 
#     ["circuits/test_vector/poseidon2/mt_1"]="mt_1" 
#     ["circuits/test_vector/poseidon2/mt_2"]="mt_2" 
#     ["circuits/test_vector/poseidon2/mt_3"]="mt_3" 
#     ["circuits/test_vector/poseidon2/mt_4"]="mt_4" 
#     ["circuits/test_vector/poseidon2/mt_5"]="mt_5" 
#     ["circuits/test_vector/poseidon2/mt_6"]="mt_6" 
#     ["circuits/test_vector/poseidon2/mt_7"]="mt_7" 
#     ["circuits/test_vector/poseidon2/mt_8"]="mt_8" 
#     ["circuits/test_vector/poseidon2/mt_9"]="mt_9" 
#     ["circuits/test_vector/poseidon2/mt_10"]="mt_10" 

#     ["circuits/test_vector/neptune/mt_0"]="mt_0" 
#     ["circuits/test_vector/neptune/mt_1"]="mt_1" 
#     ["circuits/test_vector/neptune/mt_2"]="mt_2" 
#     ["circuits/test_vector/neptune/mt_3"]="mt_3" 
#     ["circuits/test_vector/neptune/mt_4"]="mt_4" 
#     ["circuits/test_vector/neptune/mt_5"]="mt_5" 
#     ["circuits/test_vector/neptune/mt_6"]="mt_6" 
#     ["circuits/test_vector/neptune/mt_7"]="mt_7" 
#     ["circuits/test_vector/neptune/mt_8"]="mt_8" 
#     ["circuits/test_vector/neptune/mt_9"]="mt_9" 
#     ["circuits/test_vector/neptune/mt_10"]="mt_10" 
# )

PROOF_SYS=(
    "groth16"
    # "plonk"
    # "fflonk"
)

CIRCUIT_NAMES=(
    "circuits/test_vector/gmimc/mt_0"
    "circuits/test_vector/gmimc/mt_1"
    "circuits/test_vector/gmimc/mt_2"
    "circuits/test_vector/gmimc/mt_3"
    "circuits/test_vector/gmimc/mt_4"
    "circuits/test_vector/gmimc/mt_5"
    # "circuits/test_vector/gmimc/mt_6"
    # "circuits/test_vector/gmimc/mt_7"
    # "circuits/test_vector/gmimc/mt_8"
    # "circuits/test_vector/gmimc/mt_9"
    # "circuits/test_vector/gmimc/mt_10"

    "circuits/test_vector/mimc/mt_0"
    "circuits/test_vector/mimc/mt_1"
    "circuits/test_vector/mimc/mt_2"
    "circuits/test_vector/mimc/mt_3"
    "circuits/test_vector/mimc/mt_4"
    "circuits/test_vector/mimc/mt_5"
    # "circuits/test_vector/mimc/mt_6"
    # "circuits/test_vector/mimc/mt_7"
    # "circuits/test_vector/mimc/mt_8"
    # "circuits/test_vector/mimc/mt_9"
    # "circuits/test_vector/mimc/mt_10"

    "circuits/test_vector/poseidon/mt_0"
    "circuits/test_vector/poseidon/mt_1"
    "circuits/test_vector/poseidon/mt_2"
    "circuits/test_vector/poseidon/mt_3"
    "circuits/test_vector/poseidon/mt_4"
    "circuits/test_vector/poseidon/mt_5"
    # "circuits/test_vector/poseidon/mt_6"
    # "circuits/test_vector/poseidon/mt_7"
    # "circuits/test_vector/poseidon/mt_8"
    # "circuits/test_vector/poseidon/mt_9"
    # "circuits/test_vector/poseidon/mt_10"

    "circuits/test_vector/poseidon2/mt_0"
    "circuits/test_vector/poseidon2/mt_1"
    "circuits/test_vector/poseidon2/mt_2"
    "circuits/test_vector/poseidon2/mt_3"
    "circuits/test_vector/poseidon2/mt_4"
    "circuits/test_vector/poseidon2/mt_5"
    # "circuits/test_vector/poseidon2/mt_6"
    # "circuits/test_vector/poseidon2/mt_7"
    # "circuits/test_vector/poseidon2/mt_8"
    # "circuits/test_vector/poseidon2/mt_9"
    # "circuits/test_vector/poseidon2/mt_10"

    # "circuits/test_vector/neptune/mt_0"
    # "circuits/test_vector/neptune/mt_1"
    # "circuits/test_vector/neptune/mt_2"
    # "circuits/test_vector/neptune/mt_3"
    # "circuits/test_vector/neptune/mt_4"
    # "circuits/test_vector/neptune/mt_5"
    "circuits/test_vector/neptune/mt_6"
    "circuits/test_vector/neptune/mt_7"
    "circuits/test_vector/neptune/mt_8"
    # "circuits/test_vector/neptune/mt_9"
    # "circuits/test_vector/neptune/mt_10"
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TARGET_DIR="$SCRIPT_DIR/circuit_gen"

for PROOF_SY in "${PROOF_SYS[@]}"
do
    for CIRCUIT_NAME in "${CIRCUIT_NAMES[@]}"
    do
        case $CIRCUIT_NAME in
            "circuits/test_vector/gmimc/mt_0")
                PTAU_NAME="pot10_final"
                INPUT_NAME="mt_0"
                ;;
            "circuits/test_vector/gmimc/mt_1")
                PTAU_NAME="pot11_final"
                INPUT_NAME="mt_1"
                ;;
            "circuits/test_vector/gmimc/mt_2")
                PTAU_NAME="pot13_final"
                INPUT_NAME="mt_2"
                ;;
            "circuits/test_vector/gmimc/mt_3")
                PTAU_NAME="pot14_final"
                INPUT_NAME="mt_3"
                ;;
            "circuits/test_vector/gmimc/mt_4")
                PTAU_NAME="pot15_final"
                INPUT_NAME="mt_4"
                ;;
            "circuits/test_vector/gmimc/mt_5")
                PTAU_NAME="pot16_final"
                INPUT_NAME="mt_5"
                ;;
            "circuits/test_vector/gmimc/mt_6")
                PTAU_NAME="pot17_final"
                INPUT_NAME="mt_6"
                ;;
            "circuits/test_vector/gmimc/mt_7")
                PTAU_NAME="pot18_final"
                INPUT_NAME="mt_7"
                ;;
            "circuits/test_vector/gmimc/mt_8")
                PTAU_NAME="pot19_final"
                INPUT_NAME="mt_8"
                ;;
            "circuits/test_vector/gmimc/mt_9")
                PTAU_NAME="pot20_final"
                INPUT_NAME="mt_9"
                ;;
            "circuits/test_vector/gmimc/mt_10")
                PTAU_NAME="pot21_final"
                INPUT_NAME="mt_10"
                ;;

            "circuits/test_vector/mimc/mt_0")
                PTAU_NAME="pot11_final"
                INPUT_NAME="mt_0"
                ;;
            "circuits/test_vector/mimc/mt_1")
                PTAU_NAME="pot12_final"
                INPUT_NAME="mt_1"
                ;;
            "circuits/test_vector/mimc/mt_2")
                PTAU_NAME="pot14_final"
                INPUT_NAME="mt_2"
                ;;
            "circuits/test_vector/mimc/mt_3")
                PTAU_NAME="pot15_final"
                INPUT_NAME="mt_3"
                ;;
            "circuits/test_vector/mimc/mt_4")
                PTAU_NAME="pot16_final"
                INPUT_NAME="mt_4"
                ;;
            "circuits/test_vector/mimc/mt_5")
                PTAU_NAME="pot17_final"
                INPUT_NAME="mt_5"
                ;;
            "circuits/test_vector/mimc/mt_6")
                PTAU_NAME="pot18_final"
                INPUT_NAME="mt_6"
                ;;
            "circuits/test_vector/mimc/mt_7")
                PTAU_NAME="pot19_final"
                INPUT_NAME="mt_7"
                ;;
            "circuits/test_vector/mimc/mt_8")
                PTAU_NAME="pot20_final"
                INPUT_NAME="mt_8"
                ;;
            "circuits/test_vector/mimc/mt_9")
                PTAU_NAME="pot21_final"
                INPUT_NAME="mt_9"
                ;;
            "circuits/test_vector/mimc/mt_10")
                PTAU_NAME="pot22_final"
                INPUT_NAME="mt_10"
                ;;

            "circuits/test_vector/poseidon/mt_0")
                PTAU_NAME="pot8_final"
                INPUT_NAME="mt_0"
                ;;
            "circuits/test_vector/poseidon/mt_1")
                PTAU_NAME="pot10_final"
                INPUT_NAME="mt_1"
                ;;
            "circuits/test_vector/poseidon/mt_2")
                PTAU_NAME="pot11_final"
                INPUT_NAME="mt_2"
                ;;
            "circuits/test_vector/poseidon/mt_3")
                PTAU_NAME="pot12_final"
                INPUT_NAME="mt_3"
                ;;
            "circuits/test_vector/poseidon/mt_4")
                PTAU_NAME="pot13_final"
                INPUT_NAME="mt_4"
                ;;
            "circuits/test_vector/poseidon/mt_5")
                PTAU_NAME="pot14_final"
                INPUT_NAME="mt_5"
                ;;
            "circuits/test_vector/poseidon/mt_6")
                PTAU_NAME="pot15_final"
                INPUT_NAME="mt_6"
                ;;
            "circuits/test_vector/poseidon/mt_7")
                PTAU_NAME="pot16_final"
                INPUT_NAME="mt_7"
                ;;
            "circuits/test_vector/poseidon/mt_8")
                PTAU_NAME="pot17_final"
                INPUT_NAME="mt_8"
                ;;
            "circuits/test_vector/poseidon/mt_9")
                PTAU_NAME="pot18_final"
                INPUT_NAME="mt_9"
                ;;
            "circuits/test_vector/poseidon/mt_10")
                PTAU_NAME="pot19_final"
                INPUT_NAME="mt_10"
                ;;

            "circuits/test_vector/poseidon2/mt_0")
                PTAU_NAME="pot8_final"
                INPUT_NAME="mt_0"
                ;;
            "circuits/test_vector/poseidon2/mt_1")
                PTAU_NAME="pot10_final"
                INPUT_NAME="mt_1"
                ;;
            "circuits/test_vector/poseidon2/mt_2")
                PTAU_NAME="pot11_final"
                INPUT_NAME="mt_2"
                ;;
            "circuits/test_vector/poseidon2/mt_3")
                PTAU_NAME="pot12_final"
                INPUT_NAME="mt_3"
                ;;
            "circuits/test_vector/poseidon2/mt_4")
                PTAU_NAME="pot13_final"
                INPUT_NAME="mt_4"
                ;;
            "circuits/test_vector/poseidon2/mt_5")
                PTAU_NAME="pot14_final"
                INPUT_NAME="mt_5"
                ;;
            "circuits/test_vector/poseidon2/mt_6")
                PTAU_NAME="pot15_final"
                INPUT_NAME="mt_6"
                ;;
            "circuits/test_vector/poseidon2/mt_7")
                PTAU_NAME="pot16_final"
                INPUT_NAME="mt_7"
                ;;
            "circuits/test_vector/poseidon2/mt_8")
                PTAU_NAME="pot17_final"
                INPUT_NAME="mt_8"
                ;;
            "circuits/test_vector/poseidon2/mt_9")
                PTAU_NAME="pot18_final"
                INPUT_NAME="mt_9"
                ;;
            "circuits/test_vector/poseidon2/mt_10")
                PTAU_NAME="pot19_final"
                INPUT_NAME="mt_10"
                ;;

            "circuits/test_vector/neptune/mt_0")
                PTAU_NAME="pot8_final"
                INPUT_NAME="mt_0"
                ;;
            "circuits/test_vector/neptune/mt_1")
                PTAU_NAME="pot10_final"
                INPUT_NAME="mt_1"
                ;;
            "circuits/test_vector/neptune/mt_2")
                PTAU_NAME="pot11_final"
                INPUT_NAME="mt_2"
                ;;
            "circuits/test_vector/neptune/mt_3")
                PTAU_NAME="pot12_final"
                INPUT_NAME="mt_3"
                ;;
            "circuits/test_vector/neptune/mt_4")
                PTAU_NAME="pot13_final"
                INPUT_NAME="mt_4"
                ;;
            "circuits/test_vector/neptune/mt_5")
                PTAU_NAME="pot14_final"
                INPUT_NAME="mt_5"
                ;;
            "circuits/test_vector/neptune/mt_6")
                PTAU_NAME="pot15_final"
                INPUT_NAME="mt_6"
                ;;
            "circuits/test_vector/neptune/mt_7")
                PTAU_NAME="pot16_final"
                INPUT_NAME="mt_7"
                ;;
            "circuits/test_vector/neptune/mt_8")
                PTAU_NAME="pot17_final"
                INPUT_NAME="mt_8"
                ;;
            "circuits/test_vector/neptune/mt_9")
                PTAU_NAME="pot18_final"
                INPUT_NAME="mt_9"
                ;;
            "circuits/test_vector/neptune/mt_10")
                PTAU_NAME="pot19_final"
                INPUT_NAME="mt_10"
                ;;
            *)
                echo "Unknown CIRCUIT_NAME: $CIRCUIT_NAME"
                exit 1
                ;;
        esac

        CIRCUIT="$SCRIPT_DIR/$CIRCUIT_NAME.circom"
        PTAU="$SCRIPT_DIR/.ptau/$PTAU_NAME.ptau"
        INPUT="$SCRIPT_DIR/circuits/test_vector/circuit_input/${INPUT_NAME}.json"

        GEN_DIR="$TARGET_DIR/${INPUT_NAME}_js"

        mkdir -p $TARGET_DIR

        echo ">> ---------- TEST CASE: $CIRCUIT_NAME in $PROOF_SY ----------"

        # ******************************************************
        # ************* Circuit **************
        # ******************************************************  
        echo ">> 1.1 Compiling Circuit"
        circom $CIRCUIT --r1cs --wasm --sym --c --wat --output "$TARGET_DIR"
        echo "-------------------------------------------------------"
        echo ">> 1.2 Generating Witness"
        node $GEN_DIR/generate_witness.js $GEN_DIR/$INPUT_NAME.wasm $INPUT $TARGET_DIR/witness.wtns
        echo "-------------------------------------------------------"

        # ******************************************************
        # ************* Setup **************
        # ******************************************************  
        echo ">> 2.1 Generating $PROOF_SY zkey"
        NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs $PROOF_SY setup $TARGET_DIR/$INPUT_NAME.r1cs $PTAU $TARGET_DIR/$INPUT_NAME"_${PROOF_SY}_final.zkey"
        echo "-------------------------------------------------------"
        # echo ">> 2.2 First contribution to zkey"
        # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey contribute $TARGET_DIR/$INPUT_NAME"_0000.zkey" $TARGET_DIR/$INPUT_NAME"_0001.zkey" --name="First Contribution to zkey" -v -e="GUO"
        # echo "-------------------------------------------------------"
        # echo ">> 2.3 Second contribution to zkey"
        # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey contribute $TARGET_DIR/$INPUT_NAME"_0001.zkey" $TARGET_DIR/$INPUT_NAME"_0002.zkey" --name="Second Contribution to zkey" -v -e="HANZE"
        # echo "-------------------------------------------------------"
        # echo ">> 2.4 Apply a random beacon"
        # NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey beacon $TARGET_DIR/$INPUT_NAME"_0002.zkey" $TARGET_DIR/$INPUT_NAME"_${PROOF_SY}_final.zkey" 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"
        # echo "-------------------------------------------------------"
        echo ">> 2.5. Exporting Verification Key"
        NODE_OPTIONS=--max-old-space-size=12000 snarkjs zkey export verificationkey $TARGET_DIR/$INPUT_NAME"_${PROOF_SY}_final.zkey" $TARGET_DIR/${PROOF_SY}_verification_key.json
        echo "-------------------------------------------------------"

        # ******************************************************
        # ************* Prove **************
        # ****************************************************** 
        echo ">> 3.1 Generating proof by $PROOF_SY"
        NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs $PROOF_SY prove $TARGET_DIR/$INPUT_NAME"_${PROOF_SY}_final.zkey" $TARGET_DIR/witness.wtns $TARGET_DIR/${PROOF_SY}_proof.json $TARGET_DIR/${PROOF_SY}_public.json
        echo "-------------------------------------------------------"
        echo ">> 3.2 Verifying proof"
        NODE_OPTIONS=--max-old-space-size=12000 /usr/bin/time -l snarkjs $PROOF_SY verify $TARGET_DIR/${PROOF_SY}_verification_key.json $TARGET_DIR/${PROOF_SY}_public.json $TARGET_DIR/${PROOF_SY}_proof.json
    done
done