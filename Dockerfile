FROM golang:1.11 AS build

ARG arch=arm
ENV ARCH=$arch

RUN git clone https://github.com/ircop/smtp2tg /go/src/smtp2tg && \
    go get gopkg.in/telegram-bot-api.v4 && \
    go get github.com/spf13/viper && \
    go get github.com/veqryn/go-email/email
RUN go build /go/src/smtp2tg/main.go

FROM alpine:3.6 as alpine
RUN apk add -U --no-cache ca-certificates

FROM scratch
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /go/main /usr/local/bin/smtp2tg
EXPOSE 25
VOLUME /config
CMD ["/usr/local/bin/smtp2tg","-c","/config/smtp2tg.toml"]
