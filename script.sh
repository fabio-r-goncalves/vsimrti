#! /bin/bash
DIR="/home/vsimrti"

if [ "$(ls -A $DIR)" ]; then
echo "empty"
else 
mv /home/vsimrti-allinone/vsimrti/* /home/vsimrti
yes "y" | bash /home/vsimrti/bin/fed/ns3/ns3_installer.sh
mv /sumo-0.29.0/ /home/vsimrti/sumo
cd /home/vsimrti/sumo && make && make install
chown -R 1000:1000 /home/vsimrti
fi
top -b
