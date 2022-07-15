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
    for i in $_ar1; do sum=$((sum+$e**$i)); done
    for i in $_ar1; do softmax_out+=($(($e**$i/$sum))); done
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
    matrix_multiply w1 _ar1 10 784 1        # Output stored in matrix_mult_out
    matrix_addition matrix_mult_out b1      # Output stored in matrix_add_out
    z1=( $matrix_add_out )
    relu z1                                 # A1 stored in relu_out
    matrix_multiply w2 relu_out 10 10 1  
    matrix_addition matrix_mult_out b2
    z2=( $matrix_add_out )
    softmax z2                              # A2 stored in softmax_out
}

stochastic_gradient_descent(){
    # Function computes stochastic gradient updates
    #
    # Args:
    #   none
    #
    # Returns:
    #   none

    for i in {1..$#w1}; do w1[i]=$(($w1[$i]-$lr*$gw1[$i])); done
    for i in {1..$#w2}; do w2[i]=$(($w2[$i]-$lr*$gw2[$i])); done
    for i in {1..$#b1}; do b1[i]=$(($b1[$i]-$lr*$gb1[$i])); done
    for i in {1..$#b2}; do b2[i]=$(($b2[$i]-$lr*$gb2[$i])); done
}

logarithm(){
    # Computes logarithm of inputs
    #
    # Args:
    #   _ar1 (?,): input vector
    #
    # Returns:
    #   logarithm output stored in log_out global variable, view output with: echo ${log_out[@]}

    local _ar1=(${(P)1[@]})
    log_out=()
    for i in {1..$#_ar1}; 
    do 
        temp_log=0.0000001
        for j in {1..10}
        do
            temp_log=$((temp_log+(-1)**(j+1)/j*($_ar1[$i]-1)**j))
        done
        log_out+=($temp_log)
    done
}

cross_entropy_loss(){
    # Computes cross entropy loss
    #
    # Args:
    #   _ar1 (?,): one hot encoded labels
    #   _ar2 (?,): softmax output
    #
    # Returns:
    #   none

    local _ar1=(${(P)1[@]})
    local _ar2=(${(P)2[@]})
    local loss=0.0
    logarithm _ar2
    for i in {1..$#_ar1}; do loss=$(($loss+$_ar1[$i]*$log_out[$i])); done
    tot_loss=$((tot_loss-loss))
}

backpropagation(){
    # Function computes backpropagation from forward pass
    #
    # Args:
    #   none
    #
    # Returns:
    #   none

    matrix_subtraction softmax_out target
    matrix_multiply matrix_sub_out relu_out 10 1 10
    gw2=( $matrix_mult_out )                                # gradient of w2
    gb2=( $matrix_sub_out )                                 # gradient of b2
    transpose w2 10 10
    matrix_multiply transpose_out matrix_sub_out 10 10 1
    temp=( $matrix_mult_out )
    relu z1
    matrix_multiply temp relu_out 10 1 1
    gb1=( $matrix_mult_out )                                # gradient of b1
    matrix_multiply gb1 sample 10 1 784
    gw1=( $matrix_mult_out )                                # gradient of w1
    stochastic_gradient_descent
    cross_entropy_loss target softmax_out
}

iteration(){
    # Function runs iterations for all samples
    #
    # Args:
    #   none
    #
    # Returns:
    #   none

    epoch=$1
    echo Starting Epoch: $epoch
    {   
        read
        its=1
        start=$(date +%s.%N)
        while read l ; do
            sample=()
            target=()
            clean=(${=$(echo "$l" | tr ',' ' ' | tr -s ' ')})
            for i in {0..9}; do if [[ $i = $clean[1] ]]; then target+=(1); else target+=(0); fi; done
            shift clean
            for i in $clean; do sample+=($(($i/255.0))); done
            forward_pass sample 10 784
            backpropagation

            if [[ $(($its%50)) -eq 0 ]];
            then
                end=$(date +%s.%N)
                runtime=$( echo "$end - $start" | bc -l )
                echo Epoch: $epoch, Iteration: $its, Loss: $((tot_loss/$its)), Time taken: $runtime s
                start=$(date +%s.%N)
            fi
            its=$(($its+1))
        done
    } < fashion-mnist_train.csv
}