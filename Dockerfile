# Reference: http://docs.shippable.com/ci_configure/#build_images
FROM drydock/u14:prod

ENV DEBIAN_FRONTEND noninteractive

# `mkdir /tmp` -> Fixes apt-get update error: `[2 InRelease gpgv 3724 B] [Waiting for headers] [Waiting for headers]Couldn't create tempfiles for splitting up /var/lib/apt/listsIgn http://packages.cloud.google.com cloud-sdk-trusty InRelease' error`
# It appears that this is an issue because /tmp is removed in the base image.
RUN mkdir /tmp \
    && git clone https://github.com/AGWA/git-crypt.git /tmp/git-crypt \
    && (cd /tmp/git-crypt && make && sudo make install) \
    && rm -rf /tmp/git-crypt
    
RUN curl https://install.meteor.com/ | sh