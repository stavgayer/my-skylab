#Credit: https://github.com/ray-project/ray/blob/master/docker/base-deps/Dockerfile

ARG FROM
FROM $FROM

ENV TZ=Asia/Tokyo
# TODO(ilr) $HOME seems to point to result in "" instead of "/home/ray"
ENV PATH "/home/ray/anaconda3/bin:$PATH"
ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.7.7

ARG RAY_UID=1000
ARG RAY_GID=100

RUN apt-get update -y \
    && apt-get install -y sudo tzdata \
    && useradd -ms /bin/bash -d /home/ray ray --uid $RAY_UID --gid $RAY_GID \
    && usermod -aG sudo ray \
    && echo 'ray ALL=NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

USER $RAY_UID
ENV HOME=/home/ray

RUN sudo apt-get update -y && sudo apt-get upgrade -y \
    && sudo apt-get install -y \
        git \
        wget \
        cmake \
        g++ \ 
        zlib1g-dev \
    && wget \
        --quiet "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" \
        -O /tmp/miniconda.sh \
    && /bin/bash /tmp/miniconda.sh -b -u -p $HOME/anaconda3 \
    && $HOME/anaconda3/bin/conda init \ 
    && echo 'export PATH=$HOME/anaconda3/bin:$PATH' >> /home/ray/.bashrc \
    && rm /tmp/miniconda.sh \
    && $HOME/anaconda3/bin/conda install -y \
        libgcc python=$PYTHON_VERSION \
    && $HOME/anaconda3/bin/conda clean -y --all \
    && $HOME/anaconda3/bin/pip install --no-cache-dir \
        flatbuffers \
        cython==0.29.0 \
        numpy==1.15.4 \
        psutil \
        blist \ 
        atari-py \
    # blist is needed for numpy (which is re-installed when ray is installed)
    # atari-py is built from source for Python 3.8 (requires g++ & zlib1g-dev)
    # To avoid the following error on Jenkins:
    # AttributeError: 'numpy.ufunc' object has no attribute '__module__'
    && $HOME/anaconda3/bin/pip uninstall -y dask \ 
    # We install cmake temporarily to get psutil, blist & atari-py
    && sudo apt-get autoremove -y cmake zlib1g-dev \
        # We keep g++ on GPU images, because uninstalling removes CUDA Devel tooling
        $(if [ "$BASE_IMAGE" = "ubuntu:focal" ]; then echo \
        g++; fi) \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo apt-get clean

WORKDIR $HOME

COPY requirements.txt ./

RUN pip install -r requirements.txt; 

RUN pip install cupy-cuda92==9.1.0 thinc-gpu-ops==0.0.4