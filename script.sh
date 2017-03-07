#! /bin/bash
DIR="/home/vsimrti"

if [ "$(ls -A $DIR)" ]; then
echo "empty"
else 
mv /home/vsimrti-allinone/vsimrti/* /home/vsimrti
#yes "y" | bash /home/vsimrti/bin/fed/ns3/ns3_installer.sh
chown -R 1000:1000 /home/vsimrti
bash /home/vsimrti/bin/fed/ns3/vsim_patch.sh
cp -R src/* ns-ndn/ns-3/src
cp scratch/* ns-ndn/ns-3/scratch
rm -rf src
rm -rf scratch
rm -rf patch
./waf configure
./waf
fi
top -b
