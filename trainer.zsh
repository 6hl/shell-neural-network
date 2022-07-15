#!/bin/zsh
source ./linalg.zsh
source ./model.zsh

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
declare -a w1=($(seq -0.3 .00005 .3 | shuf | head -n7840))  # 10x784
declare -a b1=($(seq -0.3 .0001 .4 | shuf | head -n10))     # 10x1
declare -a w2=($(seq -0.3 .0001 .4 | shuf | head -n100))    # 10x10
declare -a b2=($(seq -0.3 .0001 .4 | shuf | head -n10))     # 10x1
declare -a z1
declare -a z2

# Initialize gradient variables
declare -a gw1
declare -a gb1
declare -a gw2
declare -a gb2

# Initialize inputs
declare -a sample=()
declare -a target=()
declare lr=$2
declare tot_loss=0.0

epch=$1
for i in {1..$epch};
do  
    tot_loss=0.0
    iteration $i
done