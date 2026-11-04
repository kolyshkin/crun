#!/bin/sh
# Cross compile crun for $ARCH, as a static (the default) or, with "shared"
# as the argument, a shared build.

set -e
cd /crun
git config --global --add safe.directory '*'
host=$(dpkg-architecture -a "$ARCH" -qDEB_HOST_GNU_TYPE)
./autogen.sh
if [ "$1" = shared ]; then
    set -- --enable-shared --disable-static
else
    set --
fi
./configure --host="$host" --enable-embedded-blake3 --enable-werror "$@"
make -j "$(nproc)"
