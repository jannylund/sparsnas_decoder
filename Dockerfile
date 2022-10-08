FROM alpine:edge as BUILD_ENV

COPY ./sparsnas_decode.cpp /build/

RUN apk add --no-cache g++ mosquitto-dev && \
    g++ -o /build/sparsnas_decode -O2 -Wall /build/sparsnas_decode.cpp -lmosquitto

FROM alpine:edge
ENV MQTT_HOST=${MQTT_HOST:-localhost}
ENV MQTT_PORT=${MQTT_PORT:-1883}
ENV MQTT_USERNAME=${MQTT_USERNAME:-user}
ENV MQTT_PASSWORD=${MQTT_PASSWORD:-password}
ENV SPARSNAS_SENSORS=${SPARSNAS_SENSORS}

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
      rtl-sdr \
      mosquitto-libs++ \
      zsh

COPY --from=BUILD_ENV /build/sparsnas_decode /usr/bin/
COPY sparsnas.sh /

ENTRYPOINT ["/sparsnas.sh"]
