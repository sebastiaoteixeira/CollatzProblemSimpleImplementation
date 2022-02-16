# Collatz Problem Simple Implementation - Python, C, Assembly
This repository contains three simple implementations of Collatz Problem (Python, C, Assembly).

## Collatz Problem
This mathematical conjecture tells us to, from any positive integer, if this number is even, divide it by 2, and if it is odd, to multiply by 3 and add 1. From a certain term in the sequence, the presence of the number 4 must always be verified, forming the series 4, 2, 1, 4, 2, 1, 4, 2, 1, ... . For example, if we start with the number 7 we get: 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1, 4, 2, ... .

## Algorithm
To test this conjecture we will use the following algorithm:

    i ← 1
    REPEAT:
      x ← i
        WHILE (x <> 1):
          IF x is even:
            x ← x / 2
          ELSE:
            x ← x * 3 + 1

          IF x < i AND x % 100000:  // To optimize, stop while loop when x < i  
                                    // WARNING: This is only valid if the conjecture has been tested for all positive integers less than i
            print(i)                // Print i for every 100000 successfull cases
            BREAK

## Running
Python:

    cd Python
    python main.py

C:

    cd C
    ./mainc

Assembly:

    cd Assembly
    ./Assembly

## Performance Observations
Note: The C implementation was compiled with the GNU GCC Compiler with the [-O3] optimization flag.

It was found that in C there was a significant performance increase compared to the same algorithm in Python. Regarding the algorithm in C, there was a not so significant increase in its performance in Assembly.

Note: These performance tests were not performed with the care necessary for a rigorous experience, therefore, they should not be interpreted in any way as scientifically rigorous data.
