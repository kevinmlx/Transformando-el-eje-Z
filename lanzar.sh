#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

PORT="${1:-8000}"
URL="http://localhost:$PORT/"

if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 no está instalado." >&2
  exit 1
fi

echo "Sirviendo el sitio en $URL (Ctrl+C para detener)"

(
  sleep 1
  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$URL" >/dev/null 2>&1 || true
  elif command -v open >/dev/null 2>&1; then
    open "$URL" >/dev/null 2>&1 || true
  fi
) &

trap 'echo ""; echo "Servidor detenido."; exit 0' INT TERM
python3 -m http.server "$PORT" --bind 127.0.0.1
