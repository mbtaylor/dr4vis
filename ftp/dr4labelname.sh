#!/bin/sh

case $1 in
dr4gs)
   echo gaia_source
   ;;
dr4asq0)
   echo all_source, quality_flag=0
   ;;
dr4ncf)
   echo gaia_source, excluding CF
   ;;
dr4cf)
   echo crowded_field_source
   ;;
*)
   echo $1
esac
