#!/bin/bash

port=$*

cd ns-allinone/ns
./waf configure --build-profile=debug --disable-python --disable-nsclick --enable-modules=VSimRTI 
./waf --run "scratch/VSimRTI_Starter outport="$port";" 2> /dev/null
