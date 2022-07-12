#!/bin/zsh
source ./linalg.zsh
source ./model.zsh

load_data(){
    {   
        read
        while read l ; do 
            sample=(${=$(echo "$l" | tr ',' ' ' | tr -s ' ')})
            break
        done 
    } < fashion-mnist_train.csv

}

declare -a matrix_add_out
declare -a matrix_mult_out
declare -a inplace_mult_out
declare -a dot_prod_out

declare -a relu_out
declare -a softmax_out

declare -a w1=($(shuf -i 1-100 -n 785))
declare -a b1=($(shuf -i 1-100 -n 5))
declare -a w2=($(shuf -i 1-100 -n 5))
declare -a b2=($(shuf -i 1-100 -n 5))
declare -a z1
declare -a z2

load_data