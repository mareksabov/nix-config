#!/usr/bin/env bash
echo "Building KDE sycoca cache..."
kbuildsycoca6 2>&1
echo ""
echo "Done. Restart Dolphin and try Open With again."
