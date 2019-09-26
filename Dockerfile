FROM ubuntu:latest
EXPOSE 46587
EXPOSE 4100
ADD https://polo.uminho.pt:8080/index.php/s/YpoOzUinWY92XW8/download ./jdk-13.tar
RUN apt-get update && apt-get install -y --allow-unauthenticated \
	wget \ 
	unzip \
	nano \
	gcc \
	g++ \
	pkg-config \
	lbzip2 \
	libprotobuf-dev \
	libsqlite3-dev \
	libsqlite3++ \
	libxml2-dev \
	protobuf-compiler \
	patch \
	patch \
	unzip \
	rsync \
	wget \
	git \
	gedit \
	software-properties-common
RUN mkdir /usr/lib/jvm && tar xvfz jdk-13.tar && cp -R jdk-13 /usr/lib/jvm/ && echo "export PATH=$PATH:/usr/lib/jvm/jdk-13/bin" > /root/.bashrc
RUN mkdir /home/vsimrti
RUN chown 1000:1000 -R /home/vsimrti
RUN wget https://www.dcaiti.tu-berlin.de/research/simulation/download/get/vsimrti-bin-19.0.zip &&  unzip vsimrti-bin-19.0.zip -d /home && rm vsimrti-bin-19.0.zip
ADD ./ns3_installer.sh /home/vsimrti-allinone/vsimrti/bin/fed/ns3/ns3_installer.sh
RUN add-apt-repository -y ppa:sumo/stable && apt-get update && apt-get install -y --allow-unauthenticated sumo sumo-tools sumo-doc

WORKDIR /home/vsimrti
VOLUME /home/vsimrti
ADD ./script.sh /script.sh
RUN chmod 777 /script.sh
ENTRYPOINT ["/bin/bash","/script.sh"]
