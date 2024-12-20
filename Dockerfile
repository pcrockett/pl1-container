FROM docker.io/library/debian:12-slim AS base
ARG DEBIAN_FRONTEND=noninteractive
ENV IRON_SPRING_PLI_VERSION=1.3.1

# don't need to pin apt package versions
# hadolint ignore=DL3008
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
rm -f /etc/apt/apt.conf.d/docker-clean && \
apt-get update && \
apt-get install --yes --no-install-recommends \
    curl ca-certificates make binutils gcc-multilib nano file

FROM base AS downloader

ADD --checksum=sha256:3b3a3667a452cc42887054fdbc4e9bed08ab47a5c29d7e7794be7f2e90806e72 \
    --chown=root:root \
    "http://www.iron-spring.com/pli-${IRON_SPRING_PLI_VERSION}.tgz" /opt/

RUN \
tar -xzf "/opt/pli-${IRON_SPRING_PLI_VERSION}.tgz" --directory /opt && \
chown -R root:root "/opt/pli-${IRON_SPRING_PLI_VERSION}"


FROM base

COPY --from=downloader "/opt/pli-${IRON_SPRING_PLI_VERSION}" "/opt/pli-${IRON_SPRING_PLI_VERSION}"

RUN \
ln --symbolic "/opt/pli-${IRON_SPRING_PLI_VERSION}/plic" "/usr/bin/plic-${IRON_SPRING_PLI_VERSION}" && \
ln --symbolic --force "/usr/bin/plic-${IRON_SPRING_PLI_VERSION}" "/usr/bin/plic" && \
ln --symbolic "/opt/pli-${IRON_SPRING_PLI_VERSION}/lib/libprf.a" "/usr/lib/libprf-${IRON_SPRING_PLI_VERSION}" && \
ln --symbolic --force "/usr/lib/libprf-${IRON_SPRING_PLI_VERSION}" "/usr/lib/libprf.a" && \
useradd --create-home user && \
mkdir /app && \
chown -R user:user /app

USER user
