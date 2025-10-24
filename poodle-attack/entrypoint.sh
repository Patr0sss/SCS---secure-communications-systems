#!/bin/bash
set -e

CERT_FILE=/certs/server.pem

if [ ! -f "${CERT_FILE}" ]; then
  echo "Brak certyfikatu w /certs — uruchamiam gen-cert.sh"
  /app/gen-cert.sh
fi

if command -v openssl >/dev/null 2>&1; then
  echo "Uruchamiam openssl s_server (flaga -ssl3)..."
  exec openssl s_server -accept 4433 -cert "${CERT_FILE}" -ssl3 -www -debug
else
  echo "openssl not found in PATH — przerywam."
  exit 1
fi