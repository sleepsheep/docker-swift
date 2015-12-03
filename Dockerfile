FROM phusion/baseimage:0.9.17
MAINTAINER Haris Amin <aminharis7@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libicu52 rsync && \
    rm -rf /var/lib/apt/lists/*

# Download Swift Ubuntu 14.04 Snapshot
RUN wget https://swift.org/builds/ubuntu1404/swift-2.2-SNAPSHOT-2015-12-01-b/swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu14.04.tar.gz

RUN tar -xvzf swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu14.04.tar.gz && cd swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu14.04

# Move extracted Swift Snapshot
RUN rsync -a -v --ignore-existing swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu14.04/usr/ /usr

# Clean up
RUN cd / && rm -rf swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu14.04*

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version
