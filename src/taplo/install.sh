#!/bin/sh
set -e

echo "Activating feature 'taplo'"

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    i386|i686)
        TAPLO_ARCH="x86"
        ;;
    x86_64)
        TAPLO_ARCH="x86_64"
        ;;
    aarch64|arm64)
        TAPLO_ARCH="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Download and install taplo
echo "Installing taplo for $ARCH..."
TAPLO_URL="https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-linux-$TAPLO_ARCH.gz"
curl -fsSL "$TAPLO_URL" | gzip -d - | install -m 755 /dev/stdin /usr/local/bin/taplo

# Verify installation
if command -v taplo >/dev/null 2>&1; then
    echo "taplo has been successfully installed."
    taplo --version
else
    echo "Failed to install taplo."
    exit 1
fi
