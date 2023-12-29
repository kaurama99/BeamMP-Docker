FROM debian:11 as builder

MAINTAINER Vagahbond

RUN printf "deb http://deb.debian.org/debian bullseye-backports main\n" > /etc/apt/sources.list.d/bullseye-backports.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates

RUN mkdir /beammp

WORKDIR /beammp

RUN git clone --depth 1 -b v3.2.1 --recurse-submodules --shallow-submodules https://github.com/BeamMP/BeamMP-Server.git BeamMP-Server

WORKDIR /beammp/BeamMP-Server

RUN ./scripts/debian-11/1-install-deps.sh

RUN ./scripts/debian-11/2-configure.sh

RUN ./scripts/debian-11/3-build.sh

# Production server
FROM debian:11

RUN mkdir /beammp

WORKDIR /beammp

COPY --from=builder /beammp/BeamMP-Server/scripts/debian-11/4-install-runtime-deps.sh .

RUN ./4-install-runtime-deps.sh

COPY --from=builder /beammp/BeamMP-Server/bin/BeamMP-Server .

COPY entrypoint.sh .

EXPOSE 30814
ENTRYPOINT ["./entrypoint.sh" ]
