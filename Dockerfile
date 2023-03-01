# build
FROM elixir:1.14-alpine AS build

RUN apk add --update git build-base nodejs npm yarn python3

RUN mkdir /app
WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

COPY lib lib
RUN mix compile

RUN mix release

# app
FROM elixir:1.14-alpine AS app

RUN apk add --update bash openssl postgresql-client

EXPOSE 9090
ENV MIX_ENV=prod

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/miser .
CMD ["/app/bin/miser", "start"]
