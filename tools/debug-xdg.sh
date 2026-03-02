#!/usr/bin/env bash
echo "=== Sycoca cache file ==="
find ~/.cache -name "ksycoca6*" 2>/dev/null -exec ls -la {} \;
echo ""

echo "=== Force rebuild sycoca ==="
kbuildsycoca6 --noincremental 2>&1
echo ""

echo "=== .desktop Categories sample ==="
for f in /etc/profiles/per-user/$USER/share/applications/{brave-browser,kitty,mpv,org.kde.dolphin,nvim}.desktop; do
  [ -f "$f" ] && echo "$(basename $f): $(grep '^Categories=' $f)"
done
echo ""

echo "=== Dolphin .desktop exists? ==="
find /etc/profiles/per-user/$USER/share/applications /run/current-system/sw/share/applications -name "*dolphin*" 2>/dev/null
echo ""

echo "=== applications.menu content ==="
cat /etc/xdg/menus/applications.menu 2>/dev/null | head -5
echo ""

echo "=== Kill dolphin and rebuild ==="
pkill -f dolphin 2>/dev/null
kbuildsycoca6 --noincremental 2>&1
echo ""
echo "Now open Dolphin fresh and try Open With."
