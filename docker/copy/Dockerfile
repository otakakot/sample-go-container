# syntax=docker/dockerfile:1
# check=error=true

FROM cgr.dev/chainguard/static:latest@sha256:fc42af33e643f20d08baf03cddcc1c02ba57052dfb02edb0d79f3fc47bcea8d9

COPY server /bin/server

ENTRYPOINT ["/bin/server"]
