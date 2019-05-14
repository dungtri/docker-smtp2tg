FROM golang:alpine AS build

ARG arch=arm
ENV ARCH=$arch

COPY qemu/qemu-$ARCH-static* /usr/bin/

RUN apk add git --no-cache && \
    git clone https://github.com/ircop/smtp2tg /go/src/smtp2tg && \
    go get gopkg.in/telegram-bot-api.v4 && \
    go get github.com/spf13/viper && \
    go get github.com/veqryn/go-email/email
RUN go build /go/src/smtp2tg/main.go

FROM alpine:latest
COPY --from=build /go/main /usr/local/bin/smtp2tg
RUN apk add ca-certificates --no-cache
EXPOSE 25
VOLUME /config
CMD ["/usr/local/bin/smtp2tg","-c","/config/smtp2tg.toml"]
