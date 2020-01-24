FROM ocaml/opam2:debian-stable
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends m4 perl wget swi-prolog mercurial pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER opam
WORKDIR /home/opam/opam-repository
# the ocaml-migrate-parsetree is a temporary fix for an issue in OPAM
# see https://github.com/ocaml/opam-repository/issues/15281
RUN git pull && opam update && opam switch 4.07 && \
  opam install ocamlfind camlp4 num ocamlgraph json-wheel conf-perl dune yaml
