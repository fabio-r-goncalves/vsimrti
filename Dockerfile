FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN mkdir /home/vsimrti
VOLUME /home/vsimrti
RUN wget https://www.dcaiti.tu-berlin.de/research/simulation/download/get/vsimrti-$
RUN unzip vsimrti-bin-0.16.1.zip -d /home
RUN rm vsimrti-bin-0.16.1.zip
WORKDIR /home/vsimrti
RUN mv /home/vsimrti-allinone/vsimrti/* /home/vsimrti
RUN rm -rf /home/vsimrti-allinone
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo yes | apt-get install -y oracle-java8-installer
RUN add-apt-repository -y ppa:sumo/stable
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated sumo sumo-tools sumo-doc
ENTRYPOI
