#!/bin/bash

relu(){
    # Computes relu of matrix
    #
    # Args:
    #   _ar1 (?,?): matrix formatted as an array
    #
    # Returns:
    #   Stores output into relu_out global variable, view output with: echo ${relu_out[@]}
    
    local -n _ar1=$1
    relu_out=()
    for i in "${_ar1[@]}";
    do
        if [ $i -lt 0 ];
        then
            relu_out+=(0)
        else
            relu_out+=($i)
        fi
    done
}

forward_pass(){
    echo TODO: Start foward pass using linalg funcs
}
backprop(){
    echo TODO: Complete backpropogation
}

epoch(){
    echo TODO: Complete One Pass func
}