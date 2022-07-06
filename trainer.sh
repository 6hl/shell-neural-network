#!/bin/bash
source ./linalg.sh
source ./model.sh

main(){
    local p=$(matrix_multiply 10 20)
    echo $p
}

train(){
    # Temp Train function for testing
    local m1=(1 2 3 4 5 6 7 8 9)
    local m2=(1 2 3 4 5 6 7 8 9)
    matrix_addition $m1 $m2 3 3
    echo ${matrix_add_out[@]}
    matrix_addition $matrix_add_out $m2 3 3
    
    matrix_multiply
}

declare -a matrix_add_out
declare -a matrix_mul_out
declare -a dot_prod_out

train