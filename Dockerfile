FROM elixir:1.10-alpine as builder
ENV MIX_ENV=prod
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .
RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix release

# ---- Application Stage ----
# bitwalker a docker image of alpine with installed erlang.
FROM bitwalker/alpine-erlang:latest
WORKDIR /app
COPY --from=builder _build/prod/rel/bst_server/ .
CMD ["/app/bin/bst_server", "start"]