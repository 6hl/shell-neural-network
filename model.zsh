#!/bin/zsh
source ./linalg.zsh

relu(){
    # Computes relu of matrix
    #
    # Args:
    #   _ar1 (?,?): matrix formatted as an array
    #
    # Returns:
    #   Stores output into relu_out global variable, view output with: echo ${relu_out[@]}
    
    local _ar1=(${(P)1[@]})
    relu_out=()
    for i in $_ar1;
    do
        if [[ $i -lt 0 ]];
        then
            relu_out+=(0)
        else
            relu_out+=($i)
        fi
    done
}

softmax(){
    # Computes softmax of vector
    #
    # Args:
    #   _ar1 (?,): vector
    #
    # Returns:
    #   Stores output into softmax_out global variable, view output with: echo ${softmax_out[@]}
    
    local _ar1=(${(P)1[@]})
    local e=2.7182818
    local sum=0
    softmax_out=()
    for i in $_ar1;
    do
        sum=$((sum+$e**$i))
    done
    for i in $_ar1;
    do
        softmax_out+=($(($e**$i/$sum)))
    done
}

forward_pass(){
    # Computes forward pass for inputs
    #
    # Args:
    #   _ar1 (?,): one sample of data
    #
    # Returns:
    #   softmax output stored in softmax_out global variable, view output with: echo ${softmax_out[@]}

    local _ar1=(${(P)1[@]})                 # A0
    matrix_multiply w1 _ar1 10 784 1            # Output stored in matrix_mult_out
    matrix_addition matrix_mult_out b1      # Output stored in matrix_add_out
    z1=( $matrix_add_out )
    relu z1                                 # A1 stored in relu_out
    matrix_multiply w2 relu_out 10 10 1      
    matrix_addition matrix_mult_out b2
    z2=( $matrix_add_out )
    softmax z2                              # A2 stored in softmax_out
}

stochastic_gradient_descent(){
    echo TODO: Complete sgd
}

backpropagation(){
    # Computes backpropagation for inputs
    #
    # Args:
    #   _ar1 (?,): one sample of data
    #
    # Returns:
    #   softmax output stored in softmax_out global variable, view output with: echo ${softmax_out[@]}

    matrix_subtraction softmax_out target               # Z^2 stored in matrix_sub_out
    matrix_multiply matrix_sub_out relu_out 10 1 10     # W^2 grad stored in matrix_mult_out
    gw2=( $matrix_mult_out )                            # gradient of w2
    gb2=( $matrix_sub_out )                             # SGD so no average
    transpose w2 10 10
    matrix_multiply transpose_out matrix_sub_out 10 10 1
    temp=( $matrix_mult_out )
    relu z1
    matrix_multiply temp relu_out 10 1 1
    gb1=( $matrix_mult_out )
    matrix_multiply gb1 sample 10 1 784
    gw1=( $matrix_mult_out )
    stochastic_gradient_descent
}

iteration(){
    {   
        read
        while read l ; do
            sample=()
            target=()
            clean=(${=$(echo "$l" | tr ',' ' ' | tr -s ' ')})
            for i in {0..9}; do if [[ $i = $clean[1] ]]; then target+=(1); else target+=(0); fi; done
            shift clean
            for i in $clean; do sample+=($(($i/255.0))); done
            forward_pass sample 10 784
            backpropagation
            break
        done 
    } < fashion-mnist_train.csv
}