# Use the official Ubuntu base image
FROM ubuntu:latest

# Set timezone to Europe/Berlin
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install essential tools and utilities
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    unzip \
    build-essential \
    software-properties-common

# Install Neovim and dependencies
RUN add-apt-repository ppa:neovim-ppa/stable && \
    apt-get update && \
    apt-get install -y \
    neovim \
    python3-neovim \
    python3-pip

# Install LazyGit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar -xvf lazygit.tar.gz && \
    mv lazygit /usr/local/bin && \
    chmod +x /usr/local/bin/lazygit && \
    rm lazygit.tar.gz

# Clone your Neovim configuration from your GitHub repository
RUN git clone https://github.com/ygalsk/myNvim ~/.config/nvim

# Set the default editor to Neovim
ENV EDITOR=nvim

WORKDIR /host/
