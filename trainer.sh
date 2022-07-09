#!/bin/bash
source ./linalg.sh
source ./model.sh

train(){
    # Temp Train function for testing
    local ar1=(1 1 1 1 1 1 1 1 1)
    local ar2=(1 2 3 4 5 6 7 8 9)
    matrix_addition ar1 ar2 3 3
    echo ${matrix_add_out[@]}
    matrix_multiply ar1 ar2 3 3
    echo ${matrix_mul_out[@]}
}

declare -a matrix_add_out
declare -a matrix_mul_out
declare -a dot_prod_out

train