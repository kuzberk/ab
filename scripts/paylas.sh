#!/usr/bin/env bash
# Kullanım: scripts/paylas.sh "Metin" [etiket1,etiket2]
set -euo pipefail
cd "$(dirname "$0")/.."

if [ $# -lt 1 ] || [ -z "${1// }" ]; then
  echo 'Kullanım: scripts/paylas.sh "Metin" [etiket1,etiket2]' >&2
  exit 1
fi

metin="$1"
etiketler="${2:-}"
z="$(date +%z)"
tarih="$(date +%Y-%m-%dT%H:%M:%S)${z:0:3}:${z:3:2}"
dosya="content/akis/$(date +%Y-%m-%d-%H%M%S).md"

etiket_listesi="[]"
if [ -n "$etiketler" ]; then
  etiket_listesi="[$(echo "$etiketler" | sed 's/[[:space:]]//g; s/[^,][^,]*/"&"/g')]"
fi

printf -- '---\ndate: %s\ntags: %s\n---\n\n%s\n' "$tarih" "$etiket_listesi" "$metin" > "$dosya"

git add "$dosya"
git commit -m "akış: $(date +%Y-%m-%d\ %H:%M)"
git push
echo "Paylaşıldı: $dosya"
