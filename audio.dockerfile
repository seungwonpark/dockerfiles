ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:21.11-py3
ARG AUTHOR="Seung-won Park <yyyyy@snu.ac.kr>"
FROM ${BASE_IMAGE}
LABEL maintainer="${AUTHOR}"

RUN --mount=type=cache,id=apt-dev,target=/var/cache/apt \
    apt update && apt install -y --no-install-recommends \
	tmux \
	htop \
	ncdu \
	ffmpeg \
	zip && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 uninstall -y torchtext tensorboard-plugin-dlprof
RUN pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
RUN pip3 install gpustat
RUN pip3 install omegaconf
RUN pip3 install youtube-dl
RUN mkdir /root/git
WORKDIR /root/git
RUN git clone --branch 1.0.0 https://github.com/seungwonpark/dotfiles
WORKDIR /root/git/dotfiles
RUN ./setup.sh
WORKDIR /root/git
