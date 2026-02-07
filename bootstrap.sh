#!/usr/bin/env bash
set -euo pipefail

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter is not installed. Install Flutter first: https://docs.flutter.dev/get-started/install"
  exit 1
fi

if [ ! -d android ] || [ ! -d ios ]; then
  flutter create --platforms=android,ios --project-name nine .
fi

flutter pub get

echo "Project is ready. Open in Android Studio and run."
