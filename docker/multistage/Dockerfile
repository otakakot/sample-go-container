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

FROM cgr.dev/chainguard/static:latest@sha256:fc42af33e643f20d08baf03cddcc1c02ba57052dfb02edb0d79f3fc47bcea8d9

COPY --from=build /bin/server /bin/

ENTRYPOINT ["/bin/server"]
