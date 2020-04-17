from ocaml/opam2:ubuntu-18.04
USER root

# Install a new enough git
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
  make m4 perl wget swi-prolog mercurial pkg-config build-essential \
  libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev build-essential autoconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src
RUN sudo wget https://github.com/git/git/archive/v2.18.0.tar.gz -O git.tar.gz;
RUN sudo tar -xf git.tar.gz;
WORKDIR git-2.18.0
RUN sudo make prefix=/usr/local all
RUN sudo make prefix=/usr/local install

# Install Python 3.7
WORKDIR /tmp
COPY ./install-python.sh install-python.sh
RUN ./install-python.sh
RUN echo "OK."
