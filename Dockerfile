FROM alpine:edge
RUN apk upgrade && apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers
RUN git clone https://github.com/xmrig/xmrig 
WORKDIR xmrig
RUN mkdir build && \
    cd scripts && ./build_deps.sh && cd ../build && \
    cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON && \
    make -j$(nproc)
RUN apk del git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers
ENTRYPOINT  ["build", "./xmrig"]
