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

declare -a w1=($(seq 0 .0001 .99 | shuf | head -n7850))
declare -a b1=($(seq 0 .0001 .99 | shuf | head -n10))
declare -a w2=($(seq 0 .0001 .99 | shuf | head -n100))
declare -a b2=($(seq 0 .0001 .99 | shuf | head -n10))
declare -a z1
declare -a z2

load_data