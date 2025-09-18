
ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1

WORKDIR /app

COPY rootfs /

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="waxgourd" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="waxgourd" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="wghaos/zigstargw-mt-web-${BUILD_ARCH}" \
    org.opencontainers.image.source="https://github.com/waxgourd-ha/waxgourd-addons/tree/main/zigstargw-mt-web-addons" \
    org.opencontainers.image.documentation="https://github.com/waxgourd-ha/waxgourd-addons/tree/main/zigstargw-mt-web-addons/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}


EXPOSE 5550

HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl --fail "http://127.0.0.1:5550/api/healthcheck" &>/dev/null || exit 1