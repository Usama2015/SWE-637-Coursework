#!/bin/bash
# This script runs a comprehensive suite of 100 test cases for Assignment 2.
# It is designed to test valid inputs, edge cases, formatting issues, and invalid arguments.

echo "--- Running Comprehensive Verification Suite (100 Tests) ---"

# ==============================================================================
# Category 1: Basic "Happy Path" Tests (Tests 1-10)
# ==============================================================================
echo ""
echo "--- Category 1: Basic Valid Inputs ---"
# Mean
java -cp . Assignment2 -ln "10 20 30" -sm 1
java -cp . Assignment2 -ln "7.5 2.5" -sm 1
# Median
java -cp . Assignment2 -ln "1 2 3 4 5" -sm 2
java -cp . Assignment2 -ln "1 2 3 4" -sm 2
# Mode
java -cp . Assignment2 -ln "5 6 7 6 8 6" -sm 3
java -cp . Assignment2 -ln "1 2 3 4 5" -sm 3
# All
java -cp . Assignment2 --list-of-numbers "10 20 10" --statistics-mode 4
java -cp . Assignment2 -sm 4 -ln "1 1 2 3 5" # different order
java -cp . Assignment2 --list-of-numbers "-10 -20 -10" --statistics-mode 4
java -cp . Assignment2 -ln "0 0 0" -sm 4

# ==============================================================================
# Category 2: Input Sanitizing and Formatting (Tests 11-35)
# ==============================================================================
echo ""
echo "--- Category 2: Input Sanitizing and Formatting ---"
# Delimiters
java -cp . Assignment2 -ln "1;2;3;4" -sm 1
java -cp . Assignment2 -ln "1,2,3,4" -sm 1
java -cp . Assignment2 -ln "1 2;3,4" -sm 1
java -cp . Assignment2 -ln "1;;2" -sm 1 # Extra delimiters
# Whitespace
java -cp . Assignment2 -ln "  1 2 3  " -sm 1
java -cp . Assignment2 -ln "1 	2	3" -sm 1 # Tabs
java -cp . Assignment2 -ln "1   2   3" -sm 1 # Multiple spaces
# Signs and Zeroes
java -cp . Assignment2 -ln "+1 +2 +3" -sm 1
java -cp . Assignment2 -ln "-1 -2 -3" -sm 1
java -cp . Assignment2 -ln "01 02 03" -sm 1
java -cp . Assignment2 -ln "0.5 00.5" -sm 3
# Malformed and Non-numeric
java -cp . Assignment2 -ln "1.2.3 4 5" -sm 1
java -cp . Assignment2 -ln "abc 1 def 2" -sm 1
java -cp . Assignment2 -ln "1, 2, three" -sm 1
java -cp . Assignment2 -ln "5." -sm 1
java -cp . Assignment2 -ln ".5" -sm 1
java -cp . Assignment2 -ln "--5" -sm 1
java -cp . Assignment2 -ln "1 - 2" -sm 1
java -cp . Assignment2 -ln "1-2" -sm 1 # This is a valid number: -1
# Mixed Content
java -cp . Assignment2 -ln "7 apples, 8 oranges, 9.5 pears" -sm 4
java -cp . Assignment2 -ln "no numbers here" -sm 1
java -cp . Assignment2 -ln "1a 2b 3c" -sm 1
java -cp . Assignment2 -ln "   " -sm 1
java -cp . Assignment2 -ln " . " -sm 1
java -cp . Assignment2 -ln " , " -sm 1

# ==============================================================================
# Category 3: Boundary and Edge Cases (Tests 36-60)
# ==============================================================================
echo ""
echo "--- Category 3: Boundary and Edge Cases ---"
# List size
java -cp . Assignment2 -ln "42" -sm 4 # Single element
java -cp . Assignment2 -ln "" -sm 4 # Empty list for 'All'
java -cp . Assignment2 -ln "1 2" -sm 2 # Two elements (even median)
# Data values
java -cp . Assignment2 -ln "0" -sm 4
java -cp . Assignment2 -ln "-10" -sm 4
java -cp . Assignment2 -ln "1000000000 2000000000" -sm 1 # Large numbers
java -cp . Assignment2 -ln "-1000000000 -2000000000" -sm 1 # Large negative numbers
java -cp . Assignment2 -ln "0 0 0 0 0" -sm 4 # All zeros
java -cp . Assignment2 -ln "7 7 7 7 7" -sm 4 # All same number
# Integer and Double representation
java -cp . Assignment2 -ln "5 5.0" -sm 3
java -cp . Assignment2 -ln "5.0 5" -sm 3
java -cp . Assignment2 -ln "5.0000 5.0" -sm 3
java -cp . Assignment2 -ln "-3 -3.0" -sm 3
java -cp . Assignment2 -ln "10.1 10.2 10.1" -sm 3
java -cp . Assignment2 -ln "10.0 10.1 10.0" -sm 3
# Special Mode cases
java -cp . Assignment2 -ln "1 2 3 1 2 3" -sm 3 # All are modes
java -cp . Assignment2 -ln "1 2 3 4" -sm 3 # No repeating numbers
java -cp . Assignment2 -ln "1 1 2 2 3 4" -sm 3 # Two modes
# More empty/invalid checks
java -cp . Assignment2 -ln "" -sm 1
java -cp . Assignment2 -ln "" -sm 2
java -cp . Assignment2 -ln "" -sm 3
java -cp . Assignment2 -ln "a b c" -sm 2
java -cp . Assignment2 -ln ", ;" -sm 3
java -cp . Assignment2 -ln "null" -sm 1

# ==============================================================================
# Category 4: Invalid Argument and Flag Handling (Tests 61-85)
# ==============================================================================
echo ""
echo "--- Category 4: Invalid Argument Handling ---"
# Missing arguments
java -cp . Assignment2
java -cp . Assignment2 -ln
java -cp . Assignment2 -sm
java -cp . Assignment2 -ln "1 2 3"
java -cp . Assignment2 -sm 1
# Invalid flags
java -cp . Assignment2 -x "1 2 3" -sm 1
java -cp . Assignment2 -ln "1 2 3" -s 1
java -cp . Assignment2 --list "1 2 3" --mode 1
# Invalid sm values
java -cp . Assignment2 -ln "1 2 3" -sm 0
java -cp . Assignment2 -ln "1 2 3" -sm 5
java -cp . Assignment2 -ln "1 2 3" -sm -1
java -cp . Assignment2 -ln "1 2 3" -sm 1.5
java -cp . Assignment2 -ln "1 2 3" -sm "abc"
java -cp . Assignment2 -ln "1 2 3" -sm ""
# Help flag combinations
java -cp . Assignment2 -h -ln "1 2 3" -sm 1
java -cp . Assignment2 -ln "1 2 3" -h -sm 1
java -cp . Assignment2 -ln "1 2 3" -sm 1 -h
java -cp . Assignment2 --help
# Extra arguments
java -cp . Assignment2 -ln "1 2 3" -sm 1 -extra
# Repeated arguments
java -cp . Assignment2 -ln "1 2" -ln "3 4" -sm 1
java -cp . Assignment2 -ln "1 2" -sm 1 -sm 2
# Case sensitivity
java -cp . Assignment2 -LN "1 2 3" -SM 1
# Long and short flags mixed
java -cp . Assignment2 --list-of-numbers "1 2" -sm 1
java -cp . Assignment2 -ln "1 2" --statistics-mode 1
java -cp . Assignment2 -ln "1 2 3" -sm 4 --extra-arg

# ==============================================================================
# Category 5: Complex and Combined Cases (Tests 86-100)
# ==============================================================================
echo ""
echo "--- Category 5: Complex and Combined Cases ---"
java -cp . Assignment2 -ln "1,2;3 4, 5;6" -sm 4
java -cp . Assignment2 -ln "0.1 0.2 0.3 0.1 0.2 0.1" -sm 3
java -cp . Assignment2 -ln "1e2 100" -sm 3 # Scientific notation (likely sanitized out)
java -cp . Assignment2 -ln "9999999999999999 1" -sm 1 # Potential double precision loss
java -cp . Assignment2 -ln "-0 0" -sm 3
java -cp . Assignment2 -ln "2.0000000000000001 2.0" -sm 3 # Floating point comparison
java -cp . Assignment2 -ln "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20" -sm 2 # Longer list median
java -cp . Assignment2 -ln "20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1" -sm 2 # Pre-sorted descending
java -cp . Assignment2 -ln "5; 5; 5; 5" -sm 4
java -cp . Assignment2 -ln "1, 1.0, 1.00" -sm 3
java -cp . Assignment2 -ln "1 2 3 -sm 4" -sm 1 # Flag as a number
java -cp . Assignment2 -ln "-ln 1 2 3" -sm 1
java -cp . Assignment2 -sm 3 -ln "9 8 7 8 9"
java -cp . Assignment2 -ln "-1.5 -1.5 0 1.5 1.5" -sm 4
java -cp . Assignment2 -ln "100, 200, 300" -sm 4

echo ""
echo "--- Comprehensive Suite Complete ---"
