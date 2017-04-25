FROM ubuntu:latest
EXPOSE 46587
EXPOSE 4100
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo yes | apt-get install -y oracle-java8-set-default
RUN apt-get install -y wget tar gcc
RUN apt-get install -y subversion make autoconf libproj-dev proj-bin proj-data  libtool libgdal1-dev libxerces-c3-dev libfox-1.6-0 libfox-1.6-dev
RUN apt-get install -y unzip
RUN apt-get install -y nano
RUN apt-get install -y g++ libsqlite3++ libxml2-dev libprotobuf-dev
RUN apt-get install -y gcc python unzip 
RUN apt-get install -y lbzip2 patch
RUN mkdir /home/vsimrti
RUN chown 1000:1000 -R /home/vsimrti
RUN wget https://www.dcaiti.tu-berlin.de/research/simulation/download/get/vsimrti-bin-17.0.zip
RUN unzip vsimrti-bin-17.0.zip -d /home
RUN rm vsimrti-bin-17.0.zip
RUN apt-get install -y build-essential libsqlite3-dev libcrypto++-dev libboost-all-dev libssl-dev git python-setuptools
RUN apt-get install -y python-dev python-pygraphviz python-kiwi python-pygoocanvas python-gnome2 python-rsvg ipython
RUN apt-get install -y git
RUN mkdir /home/vsimrti-allinone/vsimrti/bin/fed/ns3/ns-allinone
RUN cd /home/vsimrti-allinone/vsimrti/bin/fed/ns3/ns-allinone && git clone https://github.com/named-data-ndnSIM/ns-3-dev.git ns && git clone https://github.com/named-data-ndnSIM/pybindgen.git pybindgen &&  git clone --recursive https://github.com/named-data-ndnSIM/ndnSIM.git ns/src/ndnSIM
WORKDIR /home/vsimrti
VOLUME /home/vsimrti
ADD ./script.sh /script.sh
ADD ./vsim_patch.sh /home/vsimrti-allinone/vsimrti/bin/fed/ns3/
RUN cd /home/vsimrti-allinone/vsimrti/bin/fed/ns3/ && ./vsim_patch.sh && mv scratch/* ns-allinone/ns/scratch/ && mv src/* ns-allinone/ns/src/
ADD ./run.sh /home/vsimrti-allinone/vsimrti/bin/fed/ns3/
RUN chmod 777 /script.sh
RUN apt-get update --fix-missing
RUN apt-get install -y gedit
ENTRYPOINT ["/bin/bash","/script.sh"]
