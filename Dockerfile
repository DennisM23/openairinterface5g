FROM ubuntu:18.04
MAINTAINER Dennis Mejicanos
RUN DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/France
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y tzdata
RUN apt-get install -y git
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential cmake 
RUN mkdir gitlab
WORKDIR gitlab
RUN git clone https://gitlab.eurecom.fr/oai/openairinterface5g.git
WORKDIR openairinterface5g
RUN git checkout develop
RUN /bin/bash -c 'source oaienv'
WORKDIR cmake_targets
RUN /bin/bash -c './build_oai'
#RUN /bin/bash -c './build_oai --gNB --nrUE'
WORKDIR ran_build/build
#RUN make rfsimulator
#RUN ln -s librfsimulator.so liboai_device.so 
