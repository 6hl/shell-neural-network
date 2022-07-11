#!/bin/zsh
source ./linalg.zsh
source ./model.zsh

functionality_test(){
    # Temp Train function for testing
    local ar1=(1.5 1 1 1 1 1 1 1 1)
    local ar2=(1 2.5 3 4 5 6 7 8 9)
    local ar3=(1 2 3.5 4 5 6 7 8 9)
    local ar4=(-1 2 3.5 -4.5 5.5 6 7 -8 9)
    local row=3
    local col=3
    matrix_addition ar1 ar2
    echo Matrix Addition: ${matrix_add_out[@]}
    matrix_multiply ar1 ar2 3 3
    echo Matrix Multiplication: ${matrix_mult_out[@]}
    inplace_multiplication ar2 ar3
    echo Inplace Multiplication: ${inplace_mult_out[@]}
    relu ar4
    echo ReLU Activation: ${relu_out[@]}
    softmax ar1
    echo ${softmax_out[@]}
    forward_pass ar1
}

declare -a matrix_add_out
declare -a matrix_mult_out
declare -a inplace_mult_out
declare -a dot_prod_out

declare -a relu_out
declare -a softmax_out

declare -a w1
declare -a b1
declare -a w2
declare -a b2
declare -a z1
declare -a z2

functionality_test


