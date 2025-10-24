#!/bin/bash
openssl ciphers 'ALL' | tr ':' '\n' | while read c; do
  RESULT=$(echo | openssl s_client -connect 127.0.0.1:4433 -ssl3 -cipher "$c" 2>/dev/null \
           | awk '/Cipher is/ {print; exit}')
  if [[ -n "$RESULT" && "$RESULT" != *"(NONE)"* ]]; then
    echo "$c => $RESULT"
  fi
done