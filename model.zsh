#!/bin/zsh

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
    echo TODO: Start foward pass using linalg funcs
}

backprop(){
    echo TODO: Complete backpropogation
}

epoch(){
    echo TODO: Complete single pass
}