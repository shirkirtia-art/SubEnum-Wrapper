#!/bin/bash

# Improved Subdomain Enumeration Wrapper
# Runs: subfinder + assetfinder + sublist3r + findomain
# Combines everything, removes duplicates, cleans output

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    echo "Example: $0 hackerone.com"
    echo "         $0 *.hackerone.com"
    exit 1
fi

DOMAIN="$1"
OUTPUT="subdomains.txt"
TEMP_DIR=$(mktemp -d)

echo "[+] Starting subdomain enumeration for $DOMAIN"
echo "[+] Output will be saved to $OUTPUT (duplicates removed)"

# 1. Subfinder
echo "[+] Running subfinder..."
subfinder -d "$DOMAIN" -all -silent -o "$TEMP_DIR/subfinder.txt" 2>/dev/null || true

# 2. Assetfinder
echo "[+] Running assetfinder..."
assetfinder --subs-only "$DOMAIN" > "$TEMP_DIR/assetfinder.txt" 2>/dev/null || true

# 3. Sublist3r (fixed - no -silent flag)
echo "[+] Running sublist3r..."
if command -v sublist3r >/dev/null 2>&1; then
    sublist3r -d "$DOMAIN" -o "$TEMP_DIR/sublist3r.txt" 2>/dev/null || true
else
    python3 -m sublist3r -d "$DOMAIN" -o "$TEMP_DIR/sublist3r.txt" 2>/dev/null || true
fi

# 4. Findomain
echo "[+] Running findomain..."
findomain -t "$DOMAIN" -u "$TEMP_DIR/findomain.txt" -q 2>/dev/null || true

# Combine + filter + remove duplicates
echo "[+] Combining results and removing duplicates..."
cat "$TEMP_DIR"/*.txt 2>/dev/null | \
    sed 's/\r$//' | \
    tr '[:upper:]' '[:lower:]' | \
    grep -E "^[a-z0-9.-]+\.${DOMAIN#*.}$" | \
    sort -u > "$OUTPUT"

COUNT=$(wc -l < "$OUTPUT" | tr -d ' ')

echo "[+] Done! Found $COUNT unique subdomains."
echo "[+] Saved to: $OUTPUT"

# Show first 15 results
echo -e "\nFirst 15 subdomains:"
head -15 "$OUTPUT"

# Cleanup
rm -rf "$TEMP_DIR"