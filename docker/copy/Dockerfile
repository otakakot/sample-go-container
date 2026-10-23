# syntax=docker/dockerfile:1
# check=error=true

FROM cgr.dev/chainguard/static:latest@sha256:17367e4d3ae2b46c3290858e483fac09be085c92b372360fe3bf6a6150848fde

COPY server /bin/server

ENTRYPOINT ["/bin/server"]
