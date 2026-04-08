#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    haruna         \
    kvantum        \
    lxqt-qtplugin  \
    pipewire-audio \
    pipewire-jack  \
    qt6ct

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
#if [ "${ARCH}" = x86_64 ]; then
#pacman -S --noconfirm bun

# yt-dlp-ejs archlinux package has a hard dependency on deno
# but this can actually use bun instead
#pacman -Rdd --noconfirm deno

# yt-dlp also gives a warning that only deno is supported by default
#sed -i -e "s|default=\['deno'\]|default=['bun']|" /usr/lib/python*/site-packages/yt_dlp/options.py
#fi
