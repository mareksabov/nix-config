#!/usr/bin/env bash
echo "Clearing old sycoca cache..."
rm -rf ~/.cache/ksycoca6*
echo "Rebuilding KDE sycoca cache..."
XDG_MENU_PREFIX=plasma- kbuildsycoca6 --noincremental 2>&1
echo ""
echo "Done. Kill Dolphin and reopen it."
pkill -f dolphin 2>/dev/null
