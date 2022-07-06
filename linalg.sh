#!/bin/bash
# matrix_multiply(){
#     res_matrix=()
#     for((x=0; x<row1; x++))
#     do
#         for((y=0; y<col2; y++))
#         do
#             for((z=0; z<row1; z++))
#             do
#                 idx1=$((x*$row1+z))
#                 idx2=$((z*$col2+y))
#                 result=$((result+${arr1[indx1]} * ${arr2[indx2]}))
#             done
#             matrix3+=($result)
#         done
#     done
# }

dot_product() {
    echo Dot Product Incomplete
}

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
    #   Stores output into m global variable, view output with: echo ${matrix_add_out[@]}

    local -n _ar1=$1
    local -n _ar2=$2
    local rows=$3
    local cols=$4
    local idx=0
    for v in "${_ar1[@]}";
    do
        matrix_add_out[idx]=$(($v+${_ar2[idx]}))
        idx=$((idx+1))
    done
}