#!/bin/sh

usage="\nUsage: $0: \
       -name name -hpx n [-where txt] [-authall] [-stilts stilts-cmd]\n"

stilts=stilts
hpx=
where=
name=
authall=

while test "$1"
do
   if [ "$1" = "-name" -a -n "$2" ]
   then
      shift
      name="$1"
      shift
   elif [ "$1" = "-hpx" -a -n "$2" ]
   then
      shift
      hpx="$1"
      shift
   elif [ "$1" = "-where" -a -n "$2" ]
   then
      shift
      where="$1"
      shift
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

if [ -z "$hpx" -o -z "$name" ]
then
   echo "$usage"
   exit 1
fi

opstap=https://gea.esac.esa.int/tap-server/tap
pretap=https://geapre.esac.esa.int/tap-server/tap
authprops="-Dauth.username=@username -Dauth.password=@password"
authparam="auth=true"

cols2p="CAST(gaia_healpix_index($hpx, source_id) AS INT) as hpx$hpx, \
        COUNT(*) as nsrc, \
        AVG(astrometric_n_obs_al) AS nobs"
cols5p="$cols2p, \
        AVG(parallax) AS parallax, \
        AVG(SQRT(pmra*pmra+pmdec*pmdec)) AS pm, \
        AVG(SQRT(ra_error*ra_error+dec_error*dec_error)) AS pos_error, \
        AVG(parallax_error) AS parallax_error, \
        AVG(SQRT(pmra_error*pmra_error+pmdec_error*pmdec_error)) AS pm_error"
grouping="GROUP BY hpx$hpx ORDER BY hpx$hpx"
densefact=`$stilts calc expression="1./(4*PI*square(180*60/PI)/(12L<<2*$hpx))"`
densecmd="addcol -units arcmin**-2 density nsrc*`echo $densefact`"

if [ -n "$where" ]
then
   where2p="WHERE $where"
   where5p="$where2p AND parallax IS NOT NULL"
else
   where2p=
   where5p="WHERE parallax IS NOT NULL"
fi

mkdir -p $name

for dr in dr1 dr2 dr3
do
   table=gaia$dr.gaia_source
   file2p=$name/$name-2p-$dr.fits
   file5p=$name/$name-5p-$dr.fits
   if [ "$authall" = "1" ]
   then
      authprops123=$authprops
      authparam123=$authparam
   else
      authprops123=
      authparam123=
   fi
   echo $file2p
   if [ ! -e $file2p ]
   then
      $stilts $authprops123 -bench \
              tapquery $authparam123 sync=false delete=always tapurl=$opstap \
              adql="SELECT $cols2p FROM $table $where2p $grouping" \
              ocmd="$densecmd" \
              out=$file2p
   fi
   echo $file5p
   if [ ! -e $file5p ]
   then
      $stilts $authprops123 -bench \
              tapquery $authparam123 sync=false delete=always tapurl=$opstap \
              adql="SELECT $cols5p FROM $table $where5p $grouping" \
              ocmd="$densecmd" \
              out=$file5p
   fi
done

table=user_dr4int5.gaia_source
file2p=$name/$name-2p-dr4.fits
file5p=$name/$name-5p-dr4.fits
echo $file2p
if [ ! -e $file2p ]
then
   $stilts $authprops -bench \
           tapquery $authparam sync=false delete=always tapurl=$pretap \
           adql="SELECT $cols2p FROM $table $where2p $grouping" \
           ocmd="$densecmd" \
           out=$file2p
fi
echo $file5p
if [ ! -e $file5p ]
then
   $stilts $authprops -bench \
           tapquery $authparam sync=false delete=always tapurl=$pretap \
           adql="SELECT $cols5p FROM $table $where5p $grouping" \
           ocmd="$densecmd" \
           out=$file5p
fi

$stilts tmatchn \
        multimode=pairs nin=8 iref=4 matcher=exact \
        in1=$name/$name-2p-dr1.fits suffix1=_dr1 values1=hpx$hpx \
        in2=$name/$name-2p-dr2.fits suffix2=_dr2 values2=hpx$hpx \
        in3=$name/$name-2p-dr3.fits suffix3=_dr3 values3=hpx$hpx \
        in4=$name/$name-2p-dr4.fits suffix4=_dr4 values4=hpx$hpx \
        in5=$name/$name-5p-dr1.fits suffix5=_5p_dr1 values5=hpx$hpx \
        in6=$name/$name-5p-dr2.fits suffix6=_5p_dr2 values6=hpx$hpx \
        in7=$name/$name-5p-dr3.fits suffix7=_5p_dr3 values7=hpx$hpx \
        in8=$name/$name-5p-dr4.fits suffix8=_5p_dr4 values8=hpx$hpx \
        icmd1='clearparams RELEASE' icmd2='clearparams RELEASE' \
        icmd3='clearparams RELEASE' icmd4='clearparams RELEASE' \
        icmd5='clearparams RELEASE' icmd6='clearparams RELEASE' \
        icmd7='clearparams RELEASE' icmd8='clearparams RELEASE' \
        ocmd="addcol -before 1 hpx$hpx hpx${hpx}_dr4" \
        ocmd="delcols hpx${hpx}_*" \
        ocmd="healpixmeta -level $hpx -column hpx$hpx -csys C -nested" \
        out=$name/$name-tmp.fits
cols="hpx$hpx `$stilts tpipe in=$name/$name-tmp.fits cmd="delcols hpx$hpx" cmd='meta name' cmd='sort name' ofmt='csv(header=false)'`"
$stilts tpipe in=$name/$name-tmp.fits cmd="keepcols '$cols'" out=$name.fits && \
rm -f $name/$name-tmp.fits



