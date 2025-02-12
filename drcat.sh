#!/bin/sh

usage="\nUsage: $0: -name name [-where txt] [-[no]sync] [-stilts stilts-cmd]\n"

stilts=stilts
where=
name=
sync=0

while test "$1"
do
   if [ "$1" = "-name" -a -n "$2" ]
   then
      shift
      name="$1"
      shift
   elif [ "$1" = "-where" -a -n "$2" ]
   then
      shift
      where="$1"
      shift
   elif [ "$1" = "-sync" ]
   then
      shift
      sync=1
   elif [ "$1" = "-nosync" ]
   then
      shift
      sync=0
   elif [ "$1" = "-stilts" -a -n "$2" ]
   then
      shift
      stilts="$1"
      shift
   elif [ "$1" = "-h" -o "$1" = "-help" -o "$1" = "--help" ]
   then
      echo "$usage"
      exit 0
   else
      echo "$usage"
      exit 1
   fi
done

if [ -z "$where" -o -z "$name" ]
then
   echo "$usage"
   exit 1
fi

if [ "$sync" = "1" ]
then
   syncparams="sync=true"
else
   syncparams="sync=false delete=always"
fi

opstap=https://gea.esac.esa.int/tap-server/tap
pretap=https://geapre.esac.esa.int/tap-server/tap

cols="source_id, ra, dec, parallax, pmra, pmdec, \
      SQRT(pmra*pmra+pmdec*pmdec) AS pm, \
      SQRT(ra_error*ra_error+dec_error*dec_error) AS pos_error, \
      SQRT(pmra_error*pmra_error+pmdec_error*pmdec_error) AS pm_error, \
      astrometric_n_obs_al"

mkdir -p $name

for dr in dr1 dr2 dr3
do
   table=gaia$dr.gaia_source
   file=$name/$name-$dr.fits
   echo $file
   if [ ! -e $file ]
   then
      $stilts -bench tapquery $syncparams tapurl=$opstap \
              adql="SELECT $cols FROM $table WHERE $where" \
              ocmd="tablename $name-$dr" \
              out=$file
   fi
done

table=user_dr4int3.gaia_source
file=$name/$name-dr4.fits
if [ ! -e $file ]
then
   echo $file
   $stilts -Dauth.username=@username -Dauth.password=@password -bench \
           tapquery auth=true $syncparams tapurl=$pretap \
           adql="SELECT $cols FROM $table WHERE $where" \
           ocmd="tablename $name-dr4" \
           out=$file
fi

echo $name.fits
$stilts tmulti in=$name/$name-dr1.fits in=$name/$name-dr2.fits \
               in=$name/$name-dr3.fits in=$name/$name-dr4.fits \
               ofmt="fits(primary=basic)" out=$name.fits

