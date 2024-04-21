# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    zsh \
    wget \
    valgrind \
    curl \
    python3 \
    python3-pip \
    build-essential \
    libreadline-dev \
    psmisc \
    php \
    git

# Install LazyGit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && mv lazygit /usr/local/bin \
    && chmod +x /usr/local/bin/lazygit \
    && rm -f lazygit.tar.gz

# Set up zsh
RUN sh -c "$(wget -O /root/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc)"

# Install Norminette
RUN pip3 install setuptools \
    && pip3 install norminette

# Set working directory
WORKDIR /host/
