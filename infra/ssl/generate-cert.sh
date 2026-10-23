#!/bin/bash
# Tao chung chi SSL tu ky (self-signed) cho lab local
# Su dung:  bash generate-cert.sh  wordpress.local  192.168.195.129

set -e

DOMAIN="${1:-wordpress.local}"
IP="${2:-192.168.195.129}"
DAYS=365

cd "$(dirname "$0")"

echo "[+] Tao khoa rieng va chung chi tu ky cho: $DOMAIN (IP SAN: $IP)"

openssl req -x509 -nodes -days $DAYS -newkey rsa:2048 \
  -keyout "${DOMAIN}.key" \
  -out "${DOMAIN}.crt" \
  -subj "/C=VN/ST=HaNoi/L=HaNoi/O=LabWordPress/OU=De3/CN=${DOMAIN}" \
  -addext "subjectAltName=DNS:${DOMAIN},DNS:localhost,IP:${IP}"

chmod 600 "${DOMAIN}.key"
chmod 644 "${DOMAIN}.crt"

echo "[+] Da tao:"
ls -la "${DOMAIN}.key" "${DOMAIN}.crt"
echo "[+] Kiem tra SAN (Subject Alternative Name):"
openssl x509 -in "${DOMAIN}.crt" -noout -text | grep -A1 "Subject Alternative Name"
