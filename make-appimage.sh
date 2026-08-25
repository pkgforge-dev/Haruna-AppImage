#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q haruna | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook:get-yt-dlp.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/haruna.png
export DESKTOP=/usr/share/applications/org.kde.haruna.desktop
export DEPLOY_QT=1
export QT_DIR=qt6
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /usr/bin/haruna

# Turn AppDir into AppImage
quick-sharun --make-appimage
