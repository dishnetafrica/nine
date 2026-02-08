#!/usr/bin/env bash
set -euo pipefail

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter is not installed. Install Flutter first: https://docs.flutter.dev/get-started/install"
  exit 1
fi

if [ ! -d android ] || [ ! -d ios ]; then
  flutter create --platforms=android,ios --project-name nine .
fi

# Patch Android Gradle settings for machines that fail to connect to Kotlin compile daemon.
if [ -f android/gradle.properties ]; then
  if ! grep -q "kotlin.compiler.execution.strategy" android/gradle.properties; then
    cat >> android/gradle.properties <<'PROPS'

# Stabilize Kotlin compilation on environments where Kotlin daemon repeatedly disconnects.
kotlin.compiler.execution.strategy=in-process
kotlin.daemon.jvmargs=-Xmx2048M -XX:-UseParallelGC
org.gradle.jvmargs=-Xmx4096M -Dkotlin.daemon.jvm.options\=-Xmx2048M,-XX\:-UseParallelGC
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
PROPS
  fi
fi

flutter pub get

echo "Project is ready. Open in Android Studio and run."
echo "If build cache is stale, run: flutter clean && ./gradlew --stop (inside android/) && flutter run"
