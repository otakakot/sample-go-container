# syntax=docker/dockerfile:1
# check=error=true

FROM golang:1.26-alpine AS build

WORKDIR /app

RUN --mount=type=cache,id=gomodcache,target=/go/pkg/mod/,sharing=locked \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download -x

RUN --mount=type=cache,id=gomodcache,target=/go/pkg/mod/,sharing=locked \
    --mount=type=cache,id=gobuildcache,target=/root/.cache/go-build,sharing=locked \
    --mount=type=bind,target=. \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -trimpath -o /bin/server .

FROM cgr.dev/chainguard/static:latest@sha256:17367e4d3ae2b46c3290858e483fac09be085c92b372360fe3bf6a6150848fde

COPY --from=build /bin/server /bin/

ENTRYPOINT ["/bin/server"]
