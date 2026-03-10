#!/bin/sh

usage="\nUsage: $0: -name name [-where txt] [-[no]sync] [-stilts stilts-cmd]\n"

stilts=stilts
where=
name=
authall=
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
   elif [ "$1" = "-authall" ]
   then
      shift
      authall=1
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
authprops="-Dauth.username=@username -Dauth.password=@password"
authparam="auth=true"


# The TO_DOUBLEs here are to avoid cryptic "underflow" errors reported
# for dr4int6 - see C9GACS-1094.  It sounds like these will disappear
# in the final DR4 release?
cols="source_id, ra, dec, parallax, pmra, pmdec,
      SQRT(pmra*pmra+pmdec*pmdec) AS pm, \
      SQRT(TO_DOUBLE(ra_error)*TO_DOUBLE(ra_error) + \
           TO_DOUBLE(dec_error)*TO_DOUBLE(dec_error)) AS pos_error, \
      SQRT(TO_DOUBLE(pmra_error)*TO_DOUBLE(pmra_error) + \
           TO_DOUBLE(pmdec_error)*TO_DOUBLE(pmdec_error)) AS pm_error, \
      astrometric_n_obs_al"

mkdir -p $name

for dr in dr1 dr2 dr3
do
   if [ "$authall" = "1" ]
   then 
      authprops123=$authprops
      authparam123=$authparam
   else
      authprops123=
      authparam123=
   fi
   table=gaia$dr.gaia_source
   file=$name/$name-$dr.fits
   echo $file
   if [ ! -e $file ]
   then
      $stilts $authprops123 -bench tapquery $authparam123 \
              $syncparams tapurl=$opstap \
              adql="SELECT $cols FROM $table WHERE $where" \
              ocmd="tablename $name-$dr" \
              ocmd='addcol has5p pm>=0' \
              out=$file
   fi
done

for cft in gs asq0
do
   if [ $cft = gs ]
   then
      table=user_dr4int6.gaia_source
      where4=$where
   elif [ $cft = asq0 ]
   then
      table=user_dr4int6.all_source_astrometry
      if [ -n "$where" ]
      then
          where4="$where AND quality_flag=0"
      else
          where4="quality_flag=0"
      fi
   else
      echo "unknown dr4 variant $cft"
      exit 1
   fi
   dr4name=dr4$cft
   file=$name/$name-$dr4name.fits
   echo $file
   if [ ! -e $file ]
   then
echo "SELECT $cols FROM $table WHERE $where4"
      $stilts $authprops -bench \
              tapquery $authparam $syncparams tapurl=$pretap \
              adql="SELECT $cols FROM $table WHERE $where4" \
              ocmd="tablename $name-$dr4name" \
              ocmd='addcol has5p pm>=0' \
              out=$file
   fi
done

echo $name.fits
$stilts tmulti in=$name/$name-dr1.fits in=$name/$name-dr2.fits \
               in=$name/$name-dr3.fits \
               in=$name/$name-dr4gs.fits in=$name/$name-dr4asq0.fits \
               ofmt="fits(primary=basic)" out=$name.fits

