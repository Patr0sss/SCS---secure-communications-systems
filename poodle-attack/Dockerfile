FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENSSL_VER=1.0.2u
ENV PREFIX=/usr/local/openssl

RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid && \
    apt-get update && \
    apt-get install -y build-essential wget perl ca-certificates gawk && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://www.openssl.org/source/old/1.0.2/openssl-${OPENSSL_VER}.tar.gz && \
    tar xzf openssl-${OPENSSL_VER}.tar.gz && \
    cd openssl-${OPENSSL_VER} && \
    ./config enable-ssl3 enable-ssl3-method no-shared --prefix=${PREFIX} && \
    make -j$(nproc) && make install_sw

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
COPY gen-cert.sh /app/gen-cert.sh
COPY show-ciphers.sh /app/show-ciphers.sh
RUN chmod +x /app/entrypoint.sh /app/gen-cert.sh /app/show-ciphers.sh

VOLUME ["/certs"]
EXPOSE 4433

ENV PATH="${PREFIX}/bin:${PATH}"
ENTRYPOINT ["/app/entrypoint.sh"]