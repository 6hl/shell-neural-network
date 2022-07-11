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
    for i in "${_ar1[@]}";
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
    for i in "${_ar1[@]}";
    do
        sum=$((sum+$e**$i))
    done
    for i in "${_ar1[@]}";
    do
        softmax_out+=($(($e**$i/$sum)))
    done
}

forward_pass(){
    # Computes forward pass for inputs
    #
    # Args:
    #   _ar1 (?,): vector
    #
    # Returns:
    #   softmax output stored in softmax_out global variable, view output with: echo ${softmax_out[@]}

    local _ar1=(${(P)1[@]})                 # A0
    matrix_multiply w1 _ar1                 # Output stored in matrix_mult_out
    matrix_addition matrix_mult_out b1      # Output stored in matrix_add_out
    z1=matrix_add_out
    relu z1                                 # A1 stored in relu_out
    matrix_multiply w2 relu_out             
    matrix_addition matrix_mult_out b2
    z2=matrix_add_out
    softmax z2                              # A2 stored in softmax_out
}

gradient_descent(){
    echo TODO: Complete gd
}

backprop(){
    echo TODO: Complete backpropogation
}

epoch(){
    echo TODO: Complete single pass
}