FROM python:3.6.15

RUN git clone https://github.com/norkator/openalpr.git

WORKDIR /openalpr

# Install prerequisites
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    wget

# Setup the build directory
RUN mkdir /openalpr/src/build
WORKDIR /openalpr/src/build

# Setup the compile environment
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install

WORKDIR /

ENTRYPOINT ["alpr"]
