#!/bin/bash
matrix_multiply(){
    echo Matrix multiply Not Complete
}

dot_product() {
    echo Dot Product Incomplete
}

matrix_addition() {
    # Computes addition of two matricies
    #
    # Args:
    #   m1 (n,m): matrix 1
    #   m2 (n,m): matrix 2
    #   rows: num rows
    #   cols: num cols
    #
    # Returns:
    #   Stores output into m global variable, view output with: echo ${matrix_add_out[@]}
    m1=$1
    m2=$2
    rows=$3
    cols=$4
    k=0
    for((i=0; i<rows; i++))
    do
        for((j=0; j<cols; j++))
        do
            index=$((i*cols+j))
            matrix_add_out[$k]=$((${m1[index]} + ${m2[index]}))
            k=$((k+1))
        done
    done
}