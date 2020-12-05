FROM node:12.3.1-alpine
# Set environment variable
ARG RUN_AS=node
ARG HUGO_VERSION=0.79.0
ARG HUGO_BINARY="hugo_extended_${HUGO_VERSION}_Linux-64bit"

RUN apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

RUN apk update && apk add py-pygments
# Download and install hugo
RUN mkdir /usr/local/hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz \
    /usr/local/hugo/
RUN tar xzf /usr/local/hugo/${HUGO_BINARY}.tar.gz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && rm /usr/local/hugo/${HUGO_BINARY}.tar.gz \
    && apk del wget ca-certificates \
    && rm /var/cache/apk/*

CMD ["hugo"]
