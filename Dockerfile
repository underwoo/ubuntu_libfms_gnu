FROM ubuntu:latest

LABEL maintainer="Seth.Underwood@noaa.gov"

RUN apt-get update && \
    apt-get install -y git \
                       gzip \
                       zip \
                       gosu \
                       bats \
                       autoconf \
                       libtool \
                       gfortran \
                       netcdf-bin \
                       libnetcdf-dev \
                       libnetcdff-dev \
                       openmpi-bin \
                       libopenmpi-dev \
    && rm -rf /var/lib/apt/lists/*

# Create the user to perform the build
RUN useradd -ms /bin/bash builder

# Copy in the entrypoint and build scripts
COPY startup.sh /root/startup.sh
COPY build.sh /build.sh

# Set the permissions on the scripts
RUN chmod +x /root/startup.sh /build.sh

# Set the base working directory
WORKDIR /home/builder

# Default settings for the library build
ENV CC=mpicc
ENV FC=mpif90
ENV FCFLAGS="-I/usr/include"

ENTRYPOINT ["/root/startup.sh"]

CMD ["/build.sh"]

