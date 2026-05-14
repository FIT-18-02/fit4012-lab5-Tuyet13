#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Multi-Block Plaintext Test
# =========================================================

set -euo pipefail

echo "========================================="
echo " AES-128 Multi-Block Test"
echo "========================================="

# ---------------------------------------------------------
# Build project
# ---------------------------------------------------------
echo "[INFO] Building project ..."

make all >/dev/null

echo "[PASS] Build completed successfully."

# ---------------------------------------------------------
# Create keyfile
# ---------------------------------------------------------
echo "[INFO] Creating AES keyfile ..."

cat > keyfile <<'KEY'
01 04 02 03 01 03 04 0A 09 0B 07 0F 0F 06 03 00
KEY

echo "[PASS] Keyfile created."

# ---------------------------------------------------------
# Define multi-block plaintext
# ---------------------------------------------------------
PLAINTEXT="AES message longer than one block"

echo "[INFO] Plaintext:"
echo "       $PLAINTEXT"

# ---------------------------------------------------------
# Run encryption
# ---------------------------------------------------------
echo "[INFO] Encrypting plaintext ..."

printf "%s\n" "$PLAINTEXT" | ./encrypt >/tmp/aes_encrypt_multiblock.log

echo "[PASS] Encryption completed."

# ---------------------------------------------------------
# Run decryption
# ---------------------------------------------------------
echo "[INFO] Decrypting ciphertext ..."

OUTPUT=$(./decrypt 2>&1 | tr -d '\000')

# ---------------------------------------------------------
# Validate recovered plaintext
# ---------------------------------------------------------
echo "[INFO] Validating decrypted output ..."

if ! grep -q "$PLAINTEXT" <<< "$OUTPUT"; then
    echo "-----------------------------------------"
    echo "[ERROR] Decryption output:"
    echo "$OUTPUT"
    echo "-----------------------------------------"
    echo "[FAIL] Multi-block plaintext was not recovered."
    exit 1
fi

echo "[PASS] Multi-block plaintext with zero padding is recovered."

# ---------------------------------------------------------
# Final Result
# ---------------------------------------------------------
echo "========================================="
echo "[SUCCESS] Multi-block AES test passed."
echo "========================================="
