#!/usr/bin/env bash

# =========================================================
# FIT4012 - AES-128 Lab 4
# Ciphertext Tamper Negative Test
# =========================================================

set -euo pipefail

echo "========================================="
echo " AES-128 Tamper Detection Test"
echo "========================================="

# ---------------------------------------------------------
# Build project
# ---------------------------------------------------------
echo "[INFO] Building project ..."

make all >/dev/null

echo "[PASS] Build completed successfully."

# ---------------------------------------------------------
# Create AES keyfile
# ---------------------------------------------------------
echo "[INFO] Creating AES keyfile ..."

cat > keyfile <<'KEY'
01 04 02 03 01 03 04 0A 09 0B 07 0F 0F 06 03 00
KEY

echo "[PASS] Keyfile created."

# ---------------------------------------------------------
# Define plaintext
# ---------------------------------------------------------
PLAINTEXT="tamper negative test"

echo "[INFO] Plaintext:"
echo "       $PLAINTEXT"

# ---------------------------------------------------------
# Encrypt plaintext
# ---------------------------------------------------------
echo "[INFO] Encrypting plaintext ..."

printf "%s\n" "$PLAINTEXT" | ./encrypt >/tmp/aes_encrypt_tamper.log

echo "[PASS] Encryption completed."

# ---------------------------------------------------------
# Tamper ciphertext
# ---------------------------------------------------------
echo "[INFO] Modifying ciphertext (flip 1 byte) ..."

python3 - <<'PY'
from pathlib import Path

p = Path('message.aes')

data = bytearray(p.read_bytes())

if not data:
    raise SystemExit('message.aes is empty')

# Flip first byte
data[0] ^= 0x01

p.write_bytes(data)
PY

echo "[PASS] Ciphertext modified successfully."

# ---------------------------------------------------------
# Run decryption
# ---------------------------------------------------------
echo "[INFO] Running decryption on tampered ciphertext ..."

OUTPUT=$(./decrypt 2>&1 | tr -d '\000' || true)

# ---------------------------------------------------------
# Validate tamper effect
# ---------------------------------------------------------
echo "[INFO] Validating decrypted result ..."

if grep -q "$PLAINTEXT" <<< "$OUTPUT"; then
    echo "-----------------------------------------"
    echo "[ERROR] Decryption output:"
    echo "$OUTPUT"
    echo "-----------------------------------------"
    echo "[FAIL] Tampered ciphertext should not recover original plaintext."
    exit 1
fi

echo "[PASS] Tamper / flip 1 byte negative test changes decrypted output."

# ---------------------------------------------------------
# Final Result
# ---------------------------------------------------------
echo "========================================="
echo "[SUCCESS] Ciphertext tamper test passed."
echo "========================================="
