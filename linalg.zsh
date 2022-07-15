#!/bin/zsh

matrix_addition() {
    # Computes addition of two matricies
    #
    # Args:
    #   _ar1 (n,m): matrix 1 formatted as an array
    #   _ar2 (n,m): matrix 2 formatted as an array
    #
    # Returns:
    #   Stores output into matrix_add_out global variable, view output with: echo ${matrix_add_out[@]}
    
    local _ar1=(${(P)1[@]})
    local _ar2=(${(P)2[@]})
    matrix_add_out=()
    for i in {1..$#_ar1};
    do
        matrix_add_out+=($(($_ar1[i] + $_ar2[i])))
    done 
}

matrix_subtraction() {
    # Computes subtraction of two matricies
    #
    # Args:
    #   _ar1 (n,m): matrix 1 formatted as an array
    #   _ar2 (n,m): matrix 2 formatted as an array
    #
    # Returns:
    #   Stores output into matrix_sub_out global variable, view output with: echo ${matrix_sub_out[@]}
    
    local _ar1=(${(P)1[@]})
    local _ar2=(${(P)2[@]})
    matrix_sub_out=()
    for i in {1..$#_ar1};
    do
        matrix_sub_out+=($(($_ar1[i] - $_ar2[i])))
    done 
}

matrix_multiply(){
    # Computes multiplication of two matricies
    #
    # Args:
    #   _ar1 (n,m): matrix 1 formatted as an array
    #   _ar2 (n,m): matrix 2 formatted as an array
    #   row_1: num rows for matrix 1
    #   col_1: num cols for matrix 1
    #   col_2: num cols for matrix 2
    #
    # Returns:
    #   Stores output into matrix_mult_out global variable, view output with: echo ${matrix_mult_out[@]}

    local _ar1=(${(P)1[@]})
    local _ar2=(${(P)2[@]})
    local row_1=$3
    local col_1=$4
    local col_2=$5
    local result=0
    matrix_mult_out=()
    for ((i=0; i<$row_1; i++))
    do
        for ((j=0; j<$col_2; j++))
        do
            result=0
            for ((k=0; k<$col_1; k++))
            do
                # result=$(($result+${_ar1[$((i*$row_1+k+1))]} * ${_ar2[$((k*$col_2+j+1))]}))
                result=$(($result+${_ar1[$((i*$col_1+k+1))]} * ${_ar2[$((k*$col_2+j+1))]}))
            done
            matrix_mult_out+=( $result ) 
        done
    done
}

inplace_multiplication() {
    # Computes inplace multiplication of two matricies
    #
    # Args:
    #   _ar1 (n,m): matrix 1 formatted as an array
    #   _ar2 (n,m): matrix 2 formatted as an array
    #
    # Returns:
    #   Stores output into inplace_mult_out global variable, view output with: echo ${inplace_mult_out[@]}
    
    local _ar1=(${(P)1[@]})
    local _ar2=(${(P)2[@]})
    inplace_mult_out=()
    for i in {1..$#_ar1};
    do
        inplace_mult_out+=($(($_ar1[i] * $_ar2[i])))
    done
}

transpose() {
    # Transposes matrix
    #
    # Args:
    #   _ar1 (n,m): matrix 1 formatted as an array
    #   rows: num rows for matrix
    #   cols: num cols for matrix
    #
    # Returns:
    #   Stores output into transpose_out global variable, view output with: echo ${transpose_out[@]}
    
    local _ar1=(${(P)1[@]})
    local rows=$2
    local cols=$3
    transpose_out=()
    for ((j=0; j<$cols; j++))
    do
        for ((i=0; i<$rows; i++))
        do
            transpose_out+=( ${_ar1[$((i*$cols+j+1))]} )
        done
    done
}