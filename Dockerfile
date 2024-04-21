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
RUN wget -O lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.29.1/lazygit_0.29.1_Linux_x86_64.tar.gz && \
    tar -xvf lazygit.tar.gz && \
    mv lazygit /usr/local/bin && \
    chmod +x /usr/local/bin/lazygit && \
    rm lazygit.tar.gz

# Set up a default user with non-root privileges
ARG USERNAME=dkremer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    apt-get install sudo && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to the non-root user
USER $USERNAME

# Set the default editor to Neovim
ENV EDITOR=nvim

# Set the default entry point to Neovim
ENTRYPOINT ["nvim"]
