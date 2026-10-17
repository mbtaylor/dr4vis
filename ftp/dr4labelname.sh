#!/bin/sh

case $1 in
dr4gs)
   echo 1. gaia_source
   ;;
dr4ncf)
   echo 2. gaia_source, excluding CF
   ;;
dr4asq0)
   echo 3. all_source, quality_flag=0
   ;;
dr4cf)
   echo 4. crowded_field_source
   ;;
*)
   echo $1
esac
