FROM ubuntu:latest
EXPOSE 46587
EXPOSE 4100
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y nano
RUN apt-get install -y g++ libsqlite3++ libxml2-dev libprotobuf-dev
RUN apt-get install -y gcc python unzip tar
RUN apt-get install -y lbzip2 patch
RUN mkdir /home/vsimrti
RUN chown 1000:1000 -R /home/vsimrti
RUN wget https://www.dcaiti.tu-berlin.de/research/simulation/download/get/vsimrti-bin-0.16.1.zip
RUN unzip vsimrti-bin-0.16.1.zip -d /home
RUN rm vsimrti-bin-0.16.1.zip
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo yes | apt-get install -y oracle-java8-installer
RUN add-apt-repository -y ppa:sumo/stable
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated sumo sumo-tools sumo-doc
WORKDIR /home/vsimrti
VOLUME /home/vsimrti
ADD ./script.sh /script.sh
RUN chmod 777 /script.sh
RUN apt-get update --fix-missing
RUN apt-get install -y gedit
ENTRYPOINT ["/bin/bash","/script.sh"]
