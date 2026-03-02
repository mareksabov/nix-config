#!/usr/bin/env bash
echo "=== applications.menu search ==="
find /run/current-system/sw/etc/xdg/menus/ -name "*.menu" 2>/dev/null || echo "NO MENUS in /run/current-system/sw"
find /etc/profiles/per-user/$USER/etc/xdg/menus/ -name "*.menu" 2>/dev/null || echo "NO MENUS in user profile"
find /etc/xdg/menus/ -name "*.menu" 2>/dev/null || echo "NO MENUS in /etc/xdg"

echo ""
echo "=== kservice package menu file ==="
find /nix/store -maxdepth 2 -path "*/kservice*/etc" 2>/dev/null | head -5

echo ""
echo "=== XDG_CONFIG_DIRS ==="
echo "$XDG_CONFIG_DIRS" | tr ':' '\n'

echo ""
echo "=== desktop-directories ==="
ls /run/current-system/sw/share/desktop-directories/ 2>/dev/null | head -10 || echo "NONE"

echo ""
echo "=== kbuildsycoca6 ==="
which kbuildsycoca6 2>/dev/null && kbuildsycoca6 2>&1 || echo "NOT FOUND"
