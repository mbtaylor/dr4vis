#!/bin/sh

# Convert is the ImageMagick command

if [ "$1" = "-ramp" ]
then
   shift
   ramp="$1"
   shift
fi

if [ "$#" != 6 ]
then
   echo "Usage: $0 in_1 in_2 in_3 in_4 in_5 out"
   exit 1
fi

if [ -z "$ramp" ]
then
   convert \( "$1" "$2" +append \) \
           \( "$3" "$4" +append \) \
           \( "$5"      +append \) -append "$6"
else
   convert \( \( $1 $2 +append \) \
              \( $3 $4 +append \) \
              \( $5    +append \) -append \) \
           $ramp +append "$6"
fi
