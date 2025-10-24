#!/bin/bash
set -e

CERT_DIR=/certs
mkdir -p "${CERT_DIR}"

if [ -f "${CERT_DIR}/server.pem" ]; then
  echo "Cert exists, skipping generation."
  exit 0
fi

echo "Generowanie klucza i certyfikatu w ${CERT_DIR}/server.pem..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -subj "/C=PL/ST=Test/L=Test/O=Demo/CN=sslv3-demo.local" \
  -keyout "${CERT_DIR}/key.pem" -out "${CERT_DIR}/cert.pem"

cat "${CERT_DIR}/key.pem" "${CERT_DIR}/cert.pem" > "${CERT_DIR}/server.pem"
chmod 600 "${CERT_DIR}/server.pem"
echo "Gotowe."