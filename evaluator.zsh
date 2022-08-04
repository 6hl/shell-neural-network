#!/bin/zsh
source ./linalg.zsh
source ./model.zsh
source ./weights.zsh

# Initialize math bins
declare -a matrix_add_out
declare -a matrix_sub_out
declare -a matrix_mult_out
declare -a inplace_mult_out
declare -a transpose_out
declare -a relu_out
declare -a softmax_out
declare -a log_out

# Initialize model variables
declare -a z1
declare -a z2

# Initialize inputs
declare -a sample=()
declare -a target=()

{
    read
    its=1
    start=$(date +%s.%N)
    while read l ; do
        sample=()
        target=()
        clean=(${=$(echo "$l" | tr ',' ' ' | tr -s ' ')})
        for i in {0..9}; do if [[ $i = $clean[1] ]]; then target+=(1); else target+=(0); fi; done
        shift clean
        for i in $clean; do sample+=($(($i/255.0))); done
        forward_pass sample 10 784
        cross_entropy_loss target softmax_out
        
        if [[ $(($its%50)) -eq 0 ]];
        then
            end=$(date +%s.%N)
            runtime=$( echo "$end - $start" | bc -l )
            echo Iteration: $its, Loss: $((tot_loss/$its)), Time taken: $runtime s
            start=$(date +%s.%N)
        fi
        its=$(($its+1))
    done
} < fashion-mnist_test.csv