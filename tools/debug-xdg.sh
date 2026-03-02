#!/usr/bin/env bash
echo "=== XDG_DATA_DIRS ==="
echo "$XDG_DATA_DIRS" | tr ':' '\n'

echo ""
echo "=== System .desktop files ==="
ls /run/current-system/sw/share/applications/ 2>/dev/null | head -20 || echo "NONE"

echo ""
echo "=== User profile .desktop files ==="
ls /etc/profiles/per-user/$USER/share/applications/ 2>/dev/null | head -20 || echo "NONE"

echo ""
echo "=== Home .desktop files ==="
ls ~/.local/share/applications/ 2>/dev/null | head -20 || echo "NONE"

echo ""
echo "=== Nix profile .desktop files ==="
ls ~/.nix-profile/share/applications/ 2>/dev/null | head -20 || echo "NONE"

echo ""
echo "=== kbuildsycoca6 ==="
which kbuildsycoca6 2>/dev/null || echo "NOT FOUND"

echo ""
echo "=== MIME database ==="
ls /run/current-system/sw/share/mime/ 2>/dev/null | head -10 || echo "NONE"
ls /etc/profiles/per-user/$USER/share/mime/ 2>/dev/null | head -10 || echo "NONE"
