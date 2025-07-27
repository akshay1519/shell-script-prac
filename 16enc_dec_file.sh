#!/bin/bash

# 16enc_dec_file.sh
# Simple File Encryption/Decryption Tool
# Uses openssl with AES-256-CBC

echo "File Encryption/Decryption Tool"
echo

read -p "Enter (e)ncrypt or (d)ecrypt [e/d]: " mode
if [[ "$mode" != "e" && "$mode" != "d" ]]; then
  echo "Invalid choice. Exiting."
  exit 1
fi

read -e -p "File path: " file
if [[ ! -f "$file" ]]; then
  echo "File does not exist. Exiting."
  exit 1
fi

read -s -p "Enter passphrase: " passphrase
echo

if [[ "$mode" == "e" ]]; then
  outfile="${file}.enc"
  openssl enc -aes-256-cbc -salt -in "$file" -out "$outfile" -pass pass:"$passphrase"
  if [[ $? -eq 0 ]]; then
    echo "File encrypted to $outfile"
  else
    echo "Encryption failed."
  fi
else
  # Remove .enc from filename for output if present
  outfile="${file%.enc}.dec"
  openssl enc -d -aes-256-cbc -in "$file" -out "$outfile" -pass pass:"$passphrase"
  if [[ $? -eq 0 ]]; then
    echo "File decrypted to $outfile"
  else
    echo "Decryption failed. Wrong passphrase?"
  fi
fi
