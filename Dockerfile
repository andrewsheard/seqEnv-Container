FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  gcc \
#   libc6-dev \
  python-dev \
  build-essential \
#   libssl-dev \
#   libffi-dev \
#   libxml2-dev \
#   libxslt1-dev \
#   zlib1g-dev \
  make \
  libgraphviz-dev \
  python2.7-dev \
  python-pip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --upgrade pip setuptools wheel
RUN pip install numpy==1.16.6 Cython==0.29.21 
RUN pip install biom-format==2.1.7 
RUN pip install Orange-Bioinformatics==2.6.19
RUN pip install -r requirements.txt

COPY . .

# CMD [ "python", "./your-daemon-or-script.py" ]
CMD ["/bin/bash"]