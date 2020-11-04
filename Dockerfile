FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  gcc \
  python-dev \
  build-essential \
  make \
  curl \
  libgraphviz-dev \
  python2.7-dev \
  python-pip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

COPY requirements.txt ./
RUN pip install --upgrade pip setuptools wheel
RUN pip install numpy==1.16.6 Cython==0.29.21 
RUN pip install biom-format==2.1.7 
RUN pip install Orange-Bioinformatics==2.6.19
RUN pip install -r requirements.txt

RUN mkdir /tmp/blastn

WORKDIR /tmp/blastn

RUN curl https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.10.1/ncbi-blast-2.10.1+-x64-linux.tar.gz --output ncbi-blast-2.10.1+-x64-linux.tar.gz
RUN tar -xf ncbi-blast-2.10.1+-x64-linux.tar.gz
RUN rm ncbi-blast-2.10.1+-x64-linux.tar.gz

ENV PATH "$PATH:/tmp/blastn/ncbi-blast-2.10.1+/bin"

WORKDIR /usr/src
RUN rm requirements.txt

CMD ["/bin/bash"]