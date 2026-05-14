#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Build Verification Script
# =========================================================

set -euo pipefail

echo "========================================="
echo " AES-128 Build Test"
echo "========================================="

# ---------------------------------------------------------
# Compile encrypt.cpp
# ---------------------------------------------------------
echo "[INFO] Compiling encrypt.cpp ..."

g++ -std=c++17 -Wall -Wextra -pedantic encrypt.cpp -o encrypt

echo "[PASS] encrypt.cpp compiled successfully."

# ---------------------------------------------------------
# Compile decrypt.cpp
# ---------------------------------------------------------
echo "[INFO] Compiling decrypt.cpp ..."

g++ -std=c++17 -Wall -Wextra -pedantic decrypt.cpp -o decrypt

echo "[PASS] decrypt.cpp compiled successfully."

# ---------------------------------------------------------
# Verify executables
# ---------------------------------------------------------
echo "[INFO] Checking generated executables ..."

if [[ ! -x ./encrypt ]]; then
    echo "[FAIL] Missing encrypt executable."
    exit 1
fi

if [[ ! -x ./decrypt ]]; then
    echo "[FAIL] Missing decrypt executable."
    exit 1
fi

echo "[PASS] Executable files verified."

# ---------------------------------------------------------
# Final Result
# ---------------------------------------------------------
echo "========================================="
echo "[SUCCESS] AES encrypt/decrypt programs"
echo "compiled successfully."
echo "========================================="
