FROM amd64/ubuntu:latest
RUN apt update && \
apt-get install -y tzdata && \
apt install -y gcc git make binutils libc6-dev gdb sudo vim
