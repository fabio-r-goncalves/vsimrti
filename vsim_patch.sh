#!/usr/bin/env bash

ns3_version="3.25"
vsimrti_version="17.0"
ns3_installation_path="/home/vsimrti-allinone/vsimrti/bin/fed/ns3"
ns3_version_affix="ns-allinone"
ns3_version_affix_unified="ns-allinone"
ns3_short_affix="ns"
ns3_federate_url="https://www.dcaiti.tu-berlin.de/research/simulation/download/get/ns-3-patch-$vsimrti_version.zip"
ns3_federate_filename="$(basename "$ns3_federate_url")"

log() {
   STRING_ARG=$1
   printf "${STRING_ARG//%/\\%%}\n" ${*:2}
   return $?
}

warn() {
   log "${bold}${red}\nWARNING: $1\n${restore}" ${*:2}
}

fail() {
   log "${bold}${red}\nERROR: $1\n${restore}" ${*:2}
   clean_up
   exit 1
}

has() {
   return $( which $1 >/dev/null )
}



patch_ns3()
{
   ### copy the run file
 

   ### apply the VSimRTI patch
   patchfiles=$(find patch/ns-VERSION_patches/ -name "*.patch")
   for cur_patch in $patchfiles; do
      log "Applying patch: $cur_patch\n" 
	  echo "$ns3_installation_path/$ns3_version_affix/$ns3_short_affix"
      patch -Np1 -d "$ns3_installation_path/$ns3_version_affix/$ns3_short_affix" < "$cur_patch"
   done
}

download() {
   if [ ! -f "$(basename "$1")" ]; then
      basen=$(basename "$1")
      if has wget; then
         wget --no-check-certificate -q "$1" || fail "The download URL seems to have changed. File not found: "$1"";
         downloaded_files="$downloaded_files $basen"
      elif has curl; then
         curl -s -O "$1" || fail "The download URL seems to have changed. File not found: "$1"";
         downloaded_files="$downloaded_files $basen"
      else
         fail "Can't download "$1".";
      fi
   else
      fail "File $(basename "$1") already exists."
   fi
}


download_federate() {
   if [ ! -z "$arg_federate_file" ]; then
      log "federate given as argument"
      return
   fi
   log "Downloading federate from "$ns3_federate_url"..."
   download "$ns3_federate_url"
}

extract_ns3_federate()
{
   if [ ! -d "./src" ]; then
      arg1="$1"
      unzip --qq -o "$arg1"
   elif [ ! -d "./scratch" ]; then
      arg1="$1"
      unzip --qq -o "$arg1"
   elif [ ! -d "./patch" ]; then
      arg1="$1"
      unzip --qq -o "$arg1"
   else
      fail "Directory in "." already exists.";
   fi
}


echo "Downloading patch"
download_federate
echo "extracting patch"
extract_ns3_federate "$ns3_federate_filename"
echo "patching ns3"
patch_ns3
echo "exit with success"
exit 0;
