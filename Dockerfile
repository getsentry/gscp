FROM golang:1.15

RUN mkdir -p /usr/src/gscp
WORKDIR /usr/src/gscp

COPY go.mod go.sum ./

RUN go mod download

COPY . ./

ENV PLATFORMS \
        linux/amd64 linux/386 \
        darwin/amd64 darwin/386 \
        freebsd/amd64 freebsd/386

CMD set -ex ; \
    for platform in $PLATFORMS; do \
        GOOS=${platform%/*} GOARCH=${platform##*/} go build -v -o bin/gscp-${platform%/*}-${platform##*/}; \
    done ; \
    ls -l bin/
