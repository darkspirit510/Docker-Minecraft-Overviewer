FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        python3-pillow \
        python3-dev \
        python3-numpy \
        wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/overviewer
RUN git clone --progress --verbose https://github.com/overviewer/Minecraft-Overviewer.git .

# https://mcversions.net/download/1.16.1
ADD https://launcher.mojang.com/v1/objects/c9abbe8ee4fa490751ca70635340b7cf00db83ff/client.jar /tmp/overviewer/client.jar
ADD https://raw.githubusercontent.com/darkspirit510/Docker-Minecraft-Overviewer/master/scheduled_creator.sh /scheduled_creator.sh

RUN chmod +rx /scheduled_creator.sh && \
    chmod 664 /tmp/overviewer/client.jar && \
    mkdir -p /home/www-data/.minecraft/versions/1.16/ && \
    cp /tmp/overviewer/client.jar /home/www-data/.minecraft/versions/1.16/1.16.jar

RUN python3 setup.py build

WORKDIR /tmp/server
WORKDIR /tmp/export
WORKDIR /tmp/config

#RUN useradd -u 33 -g 33 -s /bin/bash www-data
USER www-data

ENTRYPOINT ["nice", "-n", "18", "/scheduled_creator.sh"]
