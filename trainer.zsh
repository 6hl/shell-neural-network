#!/bin/zsh
source ./linalg.zsh
source ./model.zsh

declare -a matrix_add_out
declare -a matrix_mult_out
declare -a inplace_mult_out
declare -a dot_prod_out

declare -a relu_out
declare -a softmax_out

declare -a w1=($(seq 0 .0001 .99 | shuf | head -n7840)) # 10x784
declare -a b1=($(seq 0 .0001 .99 | shuf | head -n10))   # 10x1
declare -a w2=($(seq 0 .0001 .99 | shuf | head -n100))  # 10x10
declare -a b2=($(seq 0 .0001 .99 | shuf | head -n10))   # 10x1
declare -a z1
declare -a z2

declare -a sample=()
declare -a y_val

iteration