FROM ubuntu:26.04

# A Debian architecture name, such as armhf or riscv64.
ARG ARCH

RUN sed -i '/^Components:/a Architectures: amd64' /etc/apt/sources.list.d/ubuntu.sources && \
    . /etc/os-release && \
    printf '%s\n' "Types: deb" \
        "URIs: http://ports.ubuntu.com/ubuntu-ports/" \
        "Suites: $VERSION_CODENAME $VERSION_CODENAME-updates $VERSION_CODENAME-security" \
        "Components: main universe" \
        "Architectures: $ARCH" > /etc/apt/sources.list.d/ports.sources && \
    dpkg --add-architecture "$ARCH" && \
    apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        crossbuild-essential-"$ARCH" dpkg-dev pkgconf:"$ARCH" \
        automake libtool make git gperf python3 \
        libseccomp-dev:"$ARCH" libcap-dev:"$ARCH" libsystemd-dev:"$ARCH" \
        libjson-c-dev:"$ARCH" libprotobuf-c-dev:"$ARCH"

ENV ARCH=$ARCH

COPY run-tests.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/run-tests.sh"]
