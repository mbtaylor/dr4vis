#!/bin/sh

case $1 in
dr4gs)
   echo 1. gaia_source
   ;;
dr4ncf)
   echo 2. gaia_source, excluding CF
   ;;
dr4as)
   echo 3. all_source
   ;;
dr4asq0)
   echo 4. all_source, quality_flag=0
   ;;
dr4cf)
   echo 5. crowded_field_source
   ;;
*)
   echo $1
esac
