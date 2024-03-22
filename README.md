# Wordpress REST API Cache Example

This WordPress plugin demonstrates the impact of caching on REST API response times.
It provides two endpoints: one with caching implemented (`/cached`) and one without (`/nocache`).
Below is how to use the plugin and the results of a benchmark test comparing these two approaches.

## Usage

After installing and activating the plugin in your WordPress site, you can test the performance difference between using cached and non-cached responses.

- **No Cache Endpoint**:
  ```
  https://yourwordpresssite.com/wp-json/example/v1/nocache
  ```

- **Cache Endpoint**:
  ```
  https://yourwordpresssite.com/wp-json/example/v1/cached
  ```

You can access these endpoints through a browser, `curl`, or any HTTP client of your choice.

## Benchmark Results

A simple Bash script named `benchmark.sh` was used to measure the response times of both endpoints. Here are the findings:

```
Comparing non-cached vs cached endpoint responses
Benchmarking https://ddev-wordpress.ddev.site/wp-json/example/v1/nocache
Iteration 1: 0.097520 s
Iteration 2: 0.035990 s
Iteration 3: 0.036264 s
Iteration 4: 0.036372 s
Iteration 5: 0.036661 s
Iteration 6: 0.036357 s
Iteration 7: 0.036578 s
Iteration 8: 0.036415 s
Iteration 9: 0.036856 s
Iteration 10: 0.036431 s
Average Time: .042 s
Min Time: 0.035990 s
Max Time: 0.097520 s
---------------------------
Benchmarking https://ddev-wordpress.ddev.site/wp-json/example/v1/cached
Iteration 1: 0.018483 s
Iteration 2: 0.019750 s
Iteration 3: 0.020102 s
Iteration 4: 0.019473 s
Iteration 5: 0.019502 s
Iteration 6: 0.019059 s
Iteration 7: 0.020692 s
Iteration 8: 0.018964 s
Iteration 9: 0.019195 s
Iteration 10: 0.018628 s
Average Time: .019 s
Min Time: 0.018483 s
Max Time: 0.020692 s
---------------------------
```

The cached endpoint significantly outperforms the non-cached endpoint, showcasing the benefits of caching in WordPress REST API responses.

