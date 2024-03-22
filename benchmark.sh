#!/bin/bash

fetch_data() {
    url=$1
    echo "Benchmarking $url"

    # Initialize accumulators
    total_time=0
    min_time=999
    max_time=0

    # Number of iterations
    iterations=10

    for ((i=1; i<=iterations; i++))
    do
        # Use curl to perform the request and extract the time taken
        time_taken=$(curl -s -o /dev/null -w "%{time_starttransfer}\n" $url)

        # Accumulate total time for average calculation later
        total_time=$(echo "$total_time + $time_taken" | bc)

        # Determine min and max times
        [ $(echo "$time_taken < $min_time" | bc) -eq 1 ] && min_time=$time_taken
        [ $(echo "$time_taken > $max_time" | bc) -eq 1 ] && max_time=$time_taken

        echo "Iteration $i: $time_taken s"
    done

    # Calculate average
    avg_time=$(echo "scale=3; $total_time / $iterations" | bc)

    echo "Average Time: $avg_time s"
    echo "Min Time: $min_time s"
    echo "Max Time: $max_time s"
    echo "---------------------------"
}

echo "Comparing non-cached vs cached endpoint responses"

fetch_data "https://ddev-wordpress.ddev.site/wp-json/example/v1/nocache"
fetch_data "https://ddev-wordpress.ddev.site/wp-json/example/v1/cached"
