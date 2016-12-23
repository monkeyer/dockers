# Format :FROM repository[:version]
FROM ubuntu:16.04
MAINTAINER Fan <15950194@qq.com>

# Install related packages and set LLVM 3.6 as the compiler
RUN apt-get update && \
    apt-get install -y build-essential wget clang-3.6 vim curl libedit-dev python2.7 python2.7-dev libicu-dev rsync libxml2 git libcurl4-openssl-dev && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set Swift Path
ENV PATH /usr/bin:$PATH
# Everything up to here should cache nicely between Swift versions, assuming dev dependencies change little
ENV SWIFT_BRANCH=swift-3.0.2-release SWIFT_VERSION=swift-3.0.2-RELEASE SWIFT_PLATFORM=ubuntu16.04

# Install Swift keys
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

# Install Swift Ubuntu Snapshot
RUN SWIFT_ARCHIVE_NAME=$SWIFT_VERSION-$SWIFT_PLATFORM && \
    SWIFT_URL=https://swift.org/builds/$SWIFT_BRANCH/$(echo "$SWIFT_PLATFORM" | tr -d .)/$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz && \
    wget $SWIFT_URL && \
    wget $SWIFT_URL.sig && \
    gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig && \
    tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 && \
    rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*

# Print Installed Swift Version
RUN swift --version

