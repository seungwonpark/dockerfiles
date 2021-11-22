ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:21.11-py3
ARG AUTHOR="Seung-won Park <yyyyy@snu.ac.kr>"
FROM ${BASE_IMAGE}
LABEL maintainer="${AUTHOR}"

# needed to skip tzdata configuration, (https://stackoverflow.com/a/58264927)
# which is needed for software-properties-common,
# which is needed to use add-apt-repository,
# which is needed to install ffmpeg 4.
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,id=apt-dev,target=/var/cache/apt \
    apt update && apt install -y --no-install-recommends \
	tmux \
	htop \
	ncdu \
	ffmpeg && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 uninstall -y torchtext
RUN pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
RUN pip3 install gpustat
RUN mkdir /root/git
WORKDIR /root/git
RUN git clone --branch 1.0.0 https://github.com/seungwonpark/dotfiles
WORKDIR /root/git/dotfiles
RUN ./setup.sh
