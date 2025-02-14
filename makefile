
# Requirements:
#   java (to construct the data)
#   ImageMagick (to manipulate some of the figures)

# For access to the embargoed data products, if you have authorization,
# you should also put your cosmos username and password into files named
# "username" and "password" so you don't have to keep typing them
# in response to prompts.

# make build generates a bunch of visualisations, mostly density maps.
# At time of writing, this takes about 6 hours to run, mostly waiting for
# queries to execute remotely on the Gaia archive.
# It's OK to interrupt it or lose the network connection: it should
# generally pick up from where it left off.

# This is the ImageMagick convert command.  Depending on your ImageMagick
# version you might need to set it to "magick" instead.
CONVERT = convert

# Some kind of image viewing command, used only for view target.
VIEW = eog

DATA_FILES = center.fits sky.fits smc.fits lmc.fits
MONTAGE_FIGS = center.png center5p.png nobs.png lmcfrac.png centerfrac.png
OTHER_FIGS = sky-dr34.png sky5p-dr34.png center-dr34.png center5p-dr34.png

CENTER_FIGS = center-dr1.png center-dr2.png center-dr3.png center-dr4.png
CENTER5P_FIGS = center5p-dr1.png center5p-dr2.png \
                center5p-dr3.png center5p-dr4.png
CENTERFRAC_FIGS = centerfrac-dr1.png centerfrac-dr2.png \
                  centerfrac-dr3.png centerfrac-dr4.png
NOBS_FIGS = nobs-dr1.png nobs-dr2.png nobs-dr3.png nobs-dr4.png
LMCFRAC_FIGS = lmcfrac-dr1.png lmcfrac-dr2.png lmcfrac-dr3.png lmcfrac-dr4.png

build: $(MONTAGE_FIGS) $(OTHER_FIGS)

data: $(DATA_FILES)

center.fits: stilts
	sh drmap.sh -stilts ./stilts -name center -hpx 12 \
           -where "NOT (l BETWEEN 15 AND 345) AND (b BETWEEN -10 AND 10)"

sky.fits: stilts
	sh drmap.sh -stilts ./stilts -name sky -hpx 8

sky10.fits: stilts
	sh drmap.sh -stilts "./stilts -Xmx16G" -name sky10 -authall -hpx 10

lmc.fits: stilts
	sh drmap.sh -stilts ./stilts -name lmc -hpx 12 \
           -where "l BETWEEN 265 AND 295 AND b BETWEEN -43 AND -21"

smc.fits: stilts
	sh drmap.sh -stilts ./stilts -name smc -hpx 12 \
           -where "l BETWEEN 290 AND 315 AND b BETWEEN -50 AND -38"

m31.fits: stilts
	sh drcat.sh -stilts ./stilts -name m31 -sync \
           -where "ra BETWEEN 9.2 AND 12.2 AND dec BETWEEN 39.8 AND 42.8"

view: build
	$(VIEW) $(MONTAGE_FIGS) $(OTHER_FIGS)

clean:
	rm -f $(CENTER_FIGS) $(CENTER5P_FIGS) $(NOBS_FIGS)
	rm -f $(LMCFRAC_FIGS) $(CENTERFRAC_FIGS)
	rm -f $(MONTAGE_FIGS) $(OTHER_FIGS)

veryclean: clean
	rm -f stilts.jar stilts
	rm -f $(DATA_FILES)
	rm -rf $(DATA_FILES:.fits=)

# STILTS version 3.5 works, so should later versions
stilts.jar:
	curl -OL http://www.starlink.ac.uk/stilts/stilts.jar

stilts: stilts.jar
	unzip stilts.jar stilts
	touch stilts
	chmod +x stilts

sky-dr34.png: sky.fits stilts
	./stilts plot2sky \
                 in=sky.fits \
                 viewsys=galactic datasys=equatorial projection=aitoff \
                 grid=true labelpos=none \
                 xpix=1200 ypix=580 \
                 auxmap=gnuplot auxmin=1.0 auxmax=2.01 auxfunc=log auxcrowd=.5 \
                 auxlabel='ratio of DR4 to DR3 sources' \
                 layer=healpix degrade=0 healpix=hpx8 datalevel=8 \
                 value=nsrc_dr4*1.0/nsrc_dr3 \
                 out=$@

sky5p-dr34.png: sky.fits stilts
	./stilts plot2sky \
                 in=sky.fits \
                 viewsys=galactic datasys=equatorial projection=aitoff \
                 grid=true labelpos=none \
                 xpix=1200 ypix=580 \
                 auxmap=gnuplot auxmin=1.0 auxmax=2.01 auxfunc=log auxcrowd=.5 \
                 auxlabel='ratio of DR4 to DR3 5+-parameter sources' \
                 layer=healpix degrade=0 healpix=hpx8 datalevel=8 \
                 value=nsrc_5p_dr4*1.0/nsrc_5p_dr3 \
                 out=$@

center-dr34.png: center.fits stilts
	./stilts plot2sky \
                 in=center.fits \
                 viewsys=galactic datasys=equatorial clon=0 clat=0 radius=10 \
                 sex=false scalebar=false \
                 xpix=1200 ypix=800 \
                 auxmap=rainforest auxmin=1.0 auxmax=9 auxfunc=log \
                 auxlabel='ratio of DR4 to DR3 sources' \
                 layer=healpix healpix=hpx12 \
                 datalevel=12 degrade=1 combine=median \
                 value=nsrc_dr4*1.0/nsrc_dr3 \
                 out=$@

center5p-dr34.png: center.fits stilts
	./stilts plot2sky \
                 in=center.fits \
                 viewsys=galactic datasys=equatorial clon=0 clat=0 radius=10 \
                 sex=false scalebar=false \
                 xpix=1200 ypix=800 \
                 auxmap=rainforest auxmin=1.0 auxmax=9 auxfunc=log \
                 auxlabel='ratio of DR4 to DR3 5+-parameter sources' \
                 layer=healpix healpix=hpx12 \
                 datalevel=12 degrade=1 combine=median \
                 value=nsrc_5p_dr4*1.0/nsrc_5p_dr3 \
                 out=$@
               
$(CENTER_FIGS): center.fits stilts
	dr=`echo $@ | sed -e's/.*\(dr.\).*/\1/'`; \
	./stilts plot2sky \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 \
               sex=false scalebar=false \
               legend=true legpos=0.9,0.9 leglabel=$$dr \
               xpix=600 ypix=400 \
               auxmap=ember auxclip=0,1 auxmin=0 auxmax=670 \
               auxlabel='sources per square arcminute' \
               layer=healpix healpix=hpx12 value=density_$$dr \
               datalevel=12 degrade=2 combine=median datasys=equatorial \
               out=$@

$(CENTER5P_FIGS): center.fits stilts
	dr=`echo $@ | sed -e's/.*\(dr.\).*/\1/'`; \
        degrade=`test $$dr = dr1 && echo 4 || echo 2`; \
	./stilts plot2sky \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 \
               sex=false scalebar=false \
               legend=true legpos=0.9,0.9 leglabel=$$dr \
               xpix=600 ypix=400 \
               auxmap=ember auxclip=0,1 auxmin=0 auxmax=670 \
               auxlabel='5+-parameter sources per square arcminute'\
               layer=healpix healpix=hpx12 value=density_5p_$$dr \
               datalevel=12 degrade=$$degrade combine=median datasys=equatorial\
               out=$@

$(NOBS_FIGS): sky.fits stilts
	dr=`echo $@ | sed -e's/.*\(dr.\).*/\1/'`; \
        ./stilts plot2sky \
               in=sky.fits \
               xpix=600 ypix=270 \
               projection=aitoff labelpos=none \
               datasys=equatorial viewsys=equatorial \
               legend=true legpos=1.0,1.0 leglabel=$$dr \
               auxclip=0,1 auxmin=0 auxmax=1620 auxmap=voltage \
               auxlabel='observations per source' \
               layer=healpix healpix=hpx8 value=nobs_$$dr datalevel=8 \
               out=$@

$(LMCFRAC_FIGS): lmc.fits stilts
	dr=`echo $@ | sed -e's/.*\(dr.\).*/\1/'`; \
        degrade=`test $$dr = dr1 && echo 5 || echo 2`; \
        ./stilts plot2sky \
               in=lmc.fits \
               xpix=650 ypix=500 \
               viewsys=galactic clon=279 clat=-32.5 radius=7.5 \
               sex=false scalebar=false grid=false \
               legend=true legpos=0.9,0.9 leglabel=$$dr \
               auxmap=light auxfunc=linear auxmin=0.5 auxmax=1.0 \
               auxlabel="Fraction of sources with 5+-parameter astrometry" \
               layer=healpix healpix=hpx12 \
               value=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel=12 degrade=$$degrade combine=mean datasys=equatorial \
               out=$@

$(CENTERFRAC_FIGS): center.fits stilts
	dr=`echo $@ | sed -e's/.*\(dr.\).*/\1/'`; \
        degrade=`test $$dr = dr1 && echo 5 || echo 2`; \
        ./stilts plot2sky \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 \
               xpix=600 ypix=400 \
               sex=false scalebar=false \
               legend=true legpos=0.9,0.9 leglabel=$$dr \
               auxmap=light auxfunc=square auxmin=0.0 auxmax=1.0 \
               auxlabel="Fraction of sources with 5+-parameter astrometry" \
               layer=healpix healpix=hpx12 \
               value=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel=12 degrade=$$degrade combine=mean datasys=equatorial \
               out=$@

center.png: $(CENTER_FIGS)
	$(CONVERT) \( center-dr1.png center-dr2.png +append \) \
                   \( center-dr3.png center-dr4.png +append \) \
                   -append $@

center5p.png: $(CENTER5P_FIGS)
	$(CONVERT) \( center5p-dr1.png center5p-dr2.png +append \) \
                   \( center5p-dr3.png center5p-dr4.png +append \) \
                   -append $@

nobs.png: $(NOBS_FIGS)
	$(CONVERT) \( nobs-dr1.png nobs-dr2.png +append \) \
                   \( nobs-dr3.png nobs-dr4.png +append \) \
                   -append $@

lmcfrac.png: $(LMCFRAC_FIGS)
	$(CONVERT) \( lmcfrac-dr1.png lmcfrac-dr2.png +append \) \
                   \( lmcfrac-dr3.png lmcfrac-dr4.png +append \) \
                   -append $@

centerfrac.png: $(CENTERFRAC_FIGS)
	$(CONVERT) \( centerfrac-dr1.png centerfrac-dr2.png +append \) \
                   \( centerfrac-dr3.png centerfrac-dr4.png +append \) \
                   -append $@


