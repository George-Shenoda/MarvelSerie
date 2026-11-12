#!/usr/bin/env bash
set -euo pipefail

KEYSTORE_FILE="marvel-chroniverse-shnwnw.jks"
ALIAS="shnwnw-release-key"

echo "Generating permanent Android signing keystore signed with CN=Shnwnw..."
read -rsp "Enter a strong keystore password: " STORE_PASS
echo ""

keytool -genkeypair -v \
  -keystore "$KEYSTORE_FILE" \
  -alias "$ALIAS" \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass "$STORE_PASS" \
  -keypass "$STORE_PASS" \
  -dname "CN=Shnwnw, OU=Mobile, O=Shnwnw, L=Cairo, ST=Cairo, C=EG"

echo ""
echo "✅ Keystore created: $KEYSTORE_FILE"
echo "------------------------------------------------------------"
echo "Add these 4 Repository Secrets in GitHub -> Settings -> Secrets and variables -> Actions:"
echo "  1. ANDROID_KEYSTORE_ALIAS    = $ALIAS"
echo "  2. ANDROID_KEYSTORE_PASSWORD = <the password you entered>"
echo "  3. ANDROID_KEY_PASSWORD      = <the password you entered>"
echo "  4. ANDROID_KEYSTORE_BASE64   = (output below)"
echo "------------------------------------------------------------"
if command -v base64 >/dev/null 2>&1; then
  base64 -w 0 "$KEYSTORE_FILE" 2>/dev/null || base64 -i "$KEYSTORE_FILE" | tr -d '\n'
  echo ""
fi
