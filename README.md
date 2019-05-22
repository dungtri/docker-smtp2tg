# smtp2tg Container
[![Downloads](https://img.shields.io/docker/pulls/dungtri/smtp2tg.svg)](https://hub.docker.com/r/dungtri/smtp2tg/)
[![Build Status](https://drone.dungtri.be/api/badges/dungtri/docker-smtp2tg/status.svg)](https://drone.dungtri.be/dungtri/docker-smtp2tg)
Work in progress: Add multi arch support: x86, arm and arm64.

Containerised version of ircop's smtp2tg golang app (https://github.com/ircop/smtp2tg)

smtp2tg is a tiny application to relay messages via SMTP to a Telegram User.

* You will need a Telegram Bot API Key which you can get from talking to [@BotFather](https://telegram.me/BotFather)

* Create your own smtp2tg.toml from my example and update the path in either the run command or my compose example.

---
#### 0.0.3

Dramatically reduced image size

---
#### smtp2tg.toml Example
```
[bot]
token = "YourBotTokenHere"

[receivers]
"*" = "YourChatIDHere"

[smtp]
listen = "0.0.0.0:25"
name = "domain.com"

[logging]
debug = true
```

#### Example Run Command
```
    $ docker run \
  --name=smtp2tg \
  --restart=always \
  -v $(pwd)/smtp2tg.toml:/config/smtp2tg.toml:ro \
  -p 25:25 \
  dungtri/smtp2tg
```
