FROM elixir:1.14-alpine

ARG USER=default
ENV HOME /home/$USER

RUN apk --no-cache add \
    openssl \
    git \
    make \
    curl \
    bash \
    python3 \
    gcc \
    musl-dev \
    python3-dev \
    openssh


RUN wget https://github.com/pre-commit/pre-commit/releases/download/v2.20.0/pre-commit-2.20.0.pyz \
  && chmod +x pre-commit-2.20.0.pyz \
  && mv pre-commit-2.20.0.pyz /usr/local/bin/pre-commit

RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

CMD ["iex", "-S", "mix"]
