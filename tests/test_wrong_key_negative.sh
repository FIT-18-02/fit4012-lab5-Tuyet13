#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Wrong Key Negative Test
# =========================================================

set -euo pipefail

echo "========================================="
echo " AES-128 Wrong Key Test"
echo "========================================="

# ---------------------------------------------------------
# Build project
# ---------------------------------------------------------
echo "[INFO] Building project ..."

make all >/dev/null

echo "[PASS] Build completed successfully."

# ---------------------------------------------------------
# Create correct encryption key
# ---------------------------------------------------------
echo "[INFO] Creating original AES keyfile ..."

cat > keyfile <<'KEY'
01 04 02 03 01 03 04 0A 09 0B 07 0F 0F 06 03 00
KEY

echo "[PASS] Original keyfile created."

# ---------------------------------------------------------
# Define plaintext
# ---------------------------------------------------------
PLAINTEXT="wrong key negative test"

echo "[INFO] Plaintext:"
echo "       $PLAINTEXT"

# ---------------------------------------------------------
# Encrypt plaintext
# ---------------------------------------------------------
echo "[INFO] Encrypting plaintext ..."

printf "%s\n" "$PLAINTEXT" | ./encrypt >/tmp/aes_encrypt_wrong_key.log

echo "[PASS] Encryption completed."

# ---------------------------------------------------------
# Replace with wrong key
# ---------------------------------------------------------
echo "[INFO] Replacing with incorrect AES key ..."

cat > keyfile <<'KEY'
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
KEY

echo "[PASS] Wrong keyfile created."

# ---------------------------------------------------------
# Attempt decryption
# ---------------------------------------------------------
echo "[INFO] Running decryption using wrong key ..."

OUTPUT=$(./decrypt 2>&1 | tr -d '\000' || true)

# ---------------------------------------------------------
# Validate result
# ---------------------------------------------------------
echo "[INFO] Validating decrypted output ..."

if grep -q "$PLAINTEXT" <<< "$OUTPUT"; then
    echo "-----------------------------------------"
    echo "[ERROR] Decryption output:"
    echo "$OUTPUT"
    echo "-----------------------------------------"
    echo "[FAIL] Wrong key should not recover original plaintext."
    exit 1
fi

echo "[PASS] Wrong key / khóa sai negative test changes decrypted output."

# ---------------------------------------------------------
# Final Result
# ---------------------------------------------------------
echo "========================================="
echo "[SUCCESS] Wrong key negative test passed."
echo "========================================="
