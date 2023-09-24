FROM alpine:3.18.2

COPY ARKSCRIPT_* /tmp/
RUN apk add git cmake clang clang-dev make gcc g++ libc-dev linux-headers && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/ArkScript-lang/Ark.git -b v$(cat /tmp/ARKSCRIPT_VERSION) && \
    cd Ark && \
    git submodule update --init --recursive && \
    cmake . -Bbuild -DARK_BUILD_EXE=On && \
    cmake --build build --config Release && \
    cmake --install build --config Release && \
    cd / && \
    apk del git cmake clang make gcc g++ linux-headers && \
    rm -rf /opt/Ark
