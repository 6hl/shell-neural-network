#!/bin/bash

matrix_addition() {
    # Computes addition of two matricies
    #
    # Args:
    #   ar1 (n,m): matrix 1 formatted as an array
    #   ar2 (n,m): matrix 2 formatted as an array
    #   rows: num rows
    #   cols: num cols
    #
    # Returns:
    #   Stores output into matrix_add_out global variable, view output with: echo ${matrix_add_out[@]}
    
    local -n _ar1=$1
    local -n _ar2=$2
    local rows=$3
    local cols=$4
    local idx=0
    matrix_add_out=()
    for i in "${!_ar1[@]}";
    do
        matrix_add_out+=($((${_ar1[i]}+${_ar2[i]})))
    done
}

matrix_multiply(){
    # Computes multiplication of two matricies
    #
    # Args:
    #   ar1 (n,m): matrix 1 formatted as an array
    #   ar2 (n,m): matrix 2 formatted as an array
    #   row_1: num rows for matrix 1
    #   col_2: num cols for matrix 2
    #
    # Returns:
    #   Stores output into matrix_mult_out global variable, view output with: echo ${matrix_mult_out[@]}
    local -n _ar1=$1
    local -n _ar2=$2
    local row_1=$3
    local col_2=$4
    local result=0
    local idx=0
    matrix_mult_out=()
    for((x=0; x<$row_1; x++))
    do
        for((y=0; y<$col_2; y++))
        do
            result=0
            for((z=0; z<$row_1; z++))
            do
                result=$(($result+${_ar1[$((x*$row_1+z))]} * ${_ar2[$((z*$col_2+y))]}))
            done
            matrix_mult_out+=($result)
        done
    done
}

inplace_multiplication() {
    # Computes inplace multiplication of two matricies
    #
    # Args:
    #   ar1 (n,m): matrix 1 formatted as an array
    #   ar2 (n,m): matrix 2 formatted as an array
    #   rows: num rows
    #   cols: num cols
    #
    # Returns:
    #   Stores output into inplace_mult_out global variable, view output with: echo ${inplace_mult_out[@]}
    
    local -n _ar1=$1
    local -n _ar2=$2
    local rows=$3
    local cols=$4
    local idx=0
    inplace_mult_out=()
    for i in "${!_ar1[@]}";
    do
        inplace_mult_out+=($((${_ar1[i]} * ${_ar2[i]})))
    done
}

dot_product() {
    echo Dot Product Incomplete
}