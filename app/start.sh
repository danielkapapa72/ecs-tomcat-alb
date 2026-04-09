#!/bin/bash
set -e

echo "Starting Tomcat with mTLS..."

TOMCAT_CONF="/opt/tomcat/conf"

# Ensure directory exists
mkdir -p "$TOMCAT_CONF"

# 🔐 Decode server keystore safely
if [ -n "$KEYSTORE_B64" ]; then
  echo "$KEYSTORE_B64" | base64 -d | tee "$TOMCAT_CONF/keystore.jks" > /dev/null
  echo "✅ Server keystore loaded."
else
  echo "❌ ERROR: KEYSTORE_B64 not provided!"
  exit 1
fi

# 🔐 Decode truststore safely
if [ -n "$TRUSTSTORE_B64" ]; then
  echo "$TRUSTSTORE_B64" | base64 -d | tee "$TOMCAT_CONF/truststore.jks" > /dev/null
  echo "✅ Truststore loaded."
else
  echo "❌ ERROR: TRUSTSTORE_B64 not provided!"
  exit 1
fi

# 🔎 Debug (VERY helpful)
echo "Checking permissions..."
ls -l "$TOMCAT_CONF"

# 🚀 Start Tomcat
exec /opt/tomcat/bin/catalina.sh run
