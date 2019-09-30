FROM nimlang/nim:alpine AS builder

WORKDIR /work

COPY . .
RUN ["nim", "c", "-o:server", "--useVersion:1.0", "-d:release", "server.nim"]


FROM alpine

WORKDIR /work

COPY --from=builder /work/server /work/server
CMD ["/work/server"]
