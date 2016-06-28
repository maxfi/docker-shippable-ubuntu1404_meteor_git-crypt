# Reference: http://docs.shippable.com/ci_configure/#build_images
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates libssl-dev git curl \
    && git clone https://github.com/AGWA/git-crypt.git /tmp/git-crypt \
    && (cd /tmp/git-crypt && make && make install) \
    && rm -rf /tmp/git-crypt \
    && apt-get remove -y build-essential libssl-dev git curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# See https://github.com/meteor/meteor/issues/4526
RUN curl https://install.meteor.com/ | sh