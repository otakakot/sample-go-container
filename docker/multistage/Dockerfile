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

FROM cgr.dev/chainguard/static:latest@sha256:fe55470f22d3259488d9d3739168d8f04da67755f0b69382bc26eda4a7d3d327

COPY --from=build /bin/server /bin/

ENTRYPOINT ["/bin/server"]
