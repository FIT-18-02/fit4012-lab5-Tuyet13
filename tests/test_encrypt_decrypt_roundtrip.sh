#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Round-Trip Encryption/Decryption Test
# =========================================================

set -euo pipefail

echo "========================================="
echo " AES-128 Round-Trip Test"
echo "========================================="

# ---------------------------------------------------------
# Build project
# ---------------------------------------------------------
echo "[INFO] Building project using Makefile ..."

make all >/dev/null

echo "[PASS] Build completed successfully."

# ---------------------------------------------------------
# Create AES key file
# ---------------------------------------------------------
echo "[INFO] Creating keyfile ..."

cat > keyfile <<'KEY'
01 04 02 03 01 03 04 0A 09 0B 07 0F 0F 06 03 00
KEY

echo "[PASS] Keyfile created."

# ---------------------------------------------------------
# Define plaintext
# ---------------------------------------------------------
PLAINTEXT="hello FIT4012 AES"

echo "[INFO] Plaintext:"
echo "       $PLAINTEXT"

# ---------------------------------------------------------
# Run encryption
# ---------------------------------------------------------
echo "[INFO] Running encryption ..."

printf "%s\n" "$PLAINTEXT" | ./encrypt >/tmp/aes_encrypt_roundtrip.log

echo "[PASS] Encryption completed."

# ---------------------------------------------------------
# Run decryption
# ---------------------------------------------------------
echo "[INFO] Running decryption ..."

OUTPUT=$(./decrypt 2>&1 | tr -d '\000')

# ---------------------------------------------------------
# Validate result
# ---------------------------------------------------------
echo "[INFO] Validating decrypted output ..."

if ! grep -q "$PLAINTEXT" <<< "$OUTPUT"; then
    echo "-----------------------------------------"
    echo "[ERROR] Decryption output:"
    echo "$OUTPUT"
    echo "-----------------------------------------"
    echo "[FAIL] Round-trip encrypt/decrypt failed."
    exit 1
fi

echo "[PASS] Round-trip encrypt/decrypt recovers plaintext."

# ---------------------------------------------------------
# Final Result
# ---------------------------------------------------------
echo "========================================="
echo "[SUCCESS] AES round-trip test passed."
echo "========================================="
