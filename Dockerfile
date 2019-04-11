FROM ubuntu:16.04

########################################################### ENVIRONMENT: base ################################################
USER root

RUN apt-get update
RUN apt-get install -y software-properties-common
# RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

RUN apt-get install -y build-essential python2.7 python2.7-dev python-pip git wget
RUN python2.7 -m pip install pip --upgrade

########################################################### Application needed: ################################################

# Install Radare2
RUN git clone https://github.com/radare/radare2.git && cd radare2 && ./sys/install.sh

# Install Python Libraries
RUN apt-get install -y build-essential gcc-multilib libffi-dev libtool automake autoconf bison debootstrap debian-archive-keyring
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && apt-get update && apt-get build-dep -y qemu-system
RUN apt-get install -y libacl1-dev libtool-bin
# RUN git clone https://github.com/HexHive/T-Fuzz && cd T-Fuzz && pip install -r req.txt

# WORKDIR T-Fuzz

# ENTRYPOINT ./TFuzz  --program  target_programs/md5sum  --work_dir workdir_md5sum --target_opts "-c @@"

# ------- Install additionnal libraries with "apt-get -y"
# RUN apt-get install -y libsm6 libxext6 libglib2.0-0 libxrender-dev
# ------- Or annd needed libraries into "requirements.txt" file and use it:
# RUN python3.6 -m pip install -r requirements.txt