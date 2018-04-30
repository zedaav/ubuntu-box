FROM ubuntu:latest

# Add some requirements
RUN apt update && \
	apt install -y sudo lsb-release openssl bash-completion command-not-found openssh-client inetutils-ping

# Customize system-level bashrc
ADD bash.bashrc.sh /tmp
RUN cat /tmp/bash.bashrc.sh >> /etc/bash.bashrc  && \
	rm /tmp/bash.bashrc.sh

# Remove docker customization that cleans apt cache every time
# so that completion works for apt install
RUN rm /etc/apt/apt.conf.d/docker-clean

# Add user
RUN useradd -d /home/user -ms /bin/bash -G sudo -p $(echo "password" | openssl passwd -1 -stdin) user
USER user
WORKDIR /home/user