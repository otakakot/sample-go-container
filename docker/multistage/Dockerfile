# syntax=docker/dockerfile:1
# check=error=true

FROM golang:1.27-alpine AS build

WORKDIR /app

RUN --mount=type=cache,id=gomodcache,target=/go/pkg/mod/,sharing=locked \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download -x

RUN --mount=type=cache,id=gomodcache,target=/go/pkg/mod/,sharing=locked \
    --mount=type=cache,id=gobuildcache,target=/root/.cache/go-build,sharing=locked \
    --mount=type=bind,target=. \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -trimpath -o /bin/server .

FROM cgr.dev/chainguard/static:latest@sha256:8658e9eaeb2294fa0e49b0667f7d66b4e21fa7690b8d2a4c30cd1d013ceb9eb7

COPY --from=build /bin/server /bin/

ENTRYPOINT ["/bin/server"]
