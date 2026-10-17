#!/usr/bin/env bash
# Content checks for the tadiWord privacy/support site. Exit 0 = all good.
cd "$(dirname "$0")"
fail=0
need() { # file, pattern (grep -E, case-sensitive)
  if [ ! -f "$1" ]; then echo "MISSING FILE: $1"; fail=1; return; fi
  grep -Eq -- "$2" "$1" || { echo "$1: missing /$2/"; fail=1; }
}
for f in index.html privacy/index.html support/index.html; do
  need "$f" '<html lang='
  need "$f" '<meta name="viewport"'
  need "$f" '<title>'
done
need privacy/index.html 'PostHog'
need privacy/index.html 'eu\.i\.posthog\.com'
need privacy/index.html 'IP'
need privacy/index.html 'kadirosmanust98@gmail\.com'
need privacy/index.html 'Yürürlük'
need privacy/index.html 'Effective'
need privacy/index.html '[Bb]ulduğun kelimeler(in kendisi)? gönderilmez'
need privacy/index.html 'words you find are (never|not) sent'
need privacy/index.html '[Çç]ökme'
need privacy/index.html '[Cc]rash'
need privacy/index.html '[Çç]ocuk'
need privacy/index.html '[Cc]hildren'
need support/index.html 'kadirosmanust98@gmail\.com'
need support/index.html 'iOS 18'
need support/index.html 'How to play'
need support/index.html 'Nasıl oynanır'
if grep -rqi boggle --include='*.html' --include='*.css' . ; then echo "forbidden word found"; fail=1; fi
[ $fail -eq 0 ] && echo "OK"
exit $fail
