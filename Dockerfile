# https://github.com/jeffheaton/docker-jupyter-python-r/blob/master/Dockerfile

FROM ubuntu:18.04

# Common, note that two updates are needed
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata && \
    apt-get install -y  software-properties-common  && \
    apt-get install -y vim  && \
    apt-get install -y wget && \
    apt-get install -y libssl-dev

# Miniconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' >> /root/.bashrc && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

# Install python requirements.
RUN conda install pip
RUN pip install --upgrade pip

COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

RUN conda install jupyter

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# R
RUN apt-get update
RUN apt-get install -y r-base

#RUN conda install -c r ipython-notebook r-irkernel
RUN conda install -c r r-irkernel r-essentials -c conda-forge
COPY packages.r /root/packages.r

RUN ln -s /bin/tar /bin/gtar
RUN Rscript /root/packages.r

# Copy tutorial files
COPY ["Attribution with Markov Chains.ipynb", "/root/tutorial/Attribution with Markov Chains.ipynb"]
COPY ./Markov.r /root/tutorial/Markov.r
COPY ./Channel_attribution.csv /root/tutorial/Channel_attribution.csv

WORKDIR /root/

EXPOSE 8888

CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --allow-root"]