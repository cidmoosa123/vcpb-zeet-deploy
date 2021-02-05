FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN apt-get update -y && \
    apt-get install -yqq locales  && \
    apt-get install -yqq \
        xfce4 \
        xfce4-goodies \
        pulseaudio \
        tightvncserver \
        python \
        python3-pip \
        sudo \
        curl \
        mpv \
        libmpv-dev \
        pavucontrol \
        wget \
        nano \
        git && \
    cd /home && \
    git clone https://github.com/rojserbest/vcpb.git vcbot && \
    cd /home/vcbot && \
    pip3 install -U -r requirements.txt && \
    cd /home && \
    wget https://telegram.org/dl/desktop/linux -O tdesktop.tar.xz && tar -xf tdesktop.tar.xz && rm tdesktop.tar.xz

COPY autostartup.sh /root/
COPY __init__.py /home/__init__.py
COPY script.sh /home/
COPY ml1.yml /home/vcbot/strings/
COPY text.png /home/vcbot/assets/png/
COPY vnc-start.sh /vnc-start.sh
COPY xstartup /home/
COPY createusers.txt /root/
CMD ["/bin/bash", "/root/autostartup.sh"]
EXPOSE 5901
