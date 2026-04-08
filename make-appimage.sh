#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q haruna | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:get-yt-dlp.src.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/haruna.png
export DESKTOP=/usr/share/applications/org.kde.haruna.desktop
export DEPLOY_QT=1
export QT_DIR=qt6
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_PYTHON=1

# Deploy dependencies
if [ "${ARCH}" = x86_64 ]; then
  quick-sharun /usr/bin/haruna /usr/bin/bun /usr/bin/yt-dlp
else
  quick-sharun /usr/bin/haruna /usr/bin/yt-dlp
fi

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
