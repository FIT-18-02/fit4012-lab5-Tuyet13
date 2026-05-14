#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Sample Encrypt/Decrypt Run
# =========================================================

set -euo pipefail

echo "========================================="
echo " Building AES-128 Project"
echo "========================================="

make all

PLAINTEXT="hello FIT4012 AES"

{
    echo
    echo "[INFO] Plaintext:"
    echo "$PLAINTEXT"
    echo

    # -----------------------------------------------------
    # Encryption
    # -----------------------------------------------------
    echo "========================================="
    echo " Running AES Encryption"
    echo "========================================="

    echo "[INFO] Executing ./encrypt"

    printf "%s\n" "$PLAINTEXT" | ./encrypt

    echo
    echo "[PASS] Encryption completed."
    echo

    # -----------------------------------------------------
    # Decryption
    # -----------------------------------------------------
    echo "========================================="
    echo " Running AES Decryption"
    echo "========================================="

    echo "[INFO] Executing ./decrypt"

    ./decrypt

    echo
    echo "[PASS] Decryption completed."
    echo

    # -----------------------------------------------------
    # Final Status
    # -----------------------------------------------------
    echo "========================================="
    echo "[SUCCESS] AES sample run completed."
    echo "========================================="

} | tee logs/sample-run.log
