
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

DATA_FILES = center.fits sky.fits smc.fits lmc.fits cfregions.fits
MONTAGE_FIGS = center.png center5p.png nobs.png lmcfrac.png centerfrac.png \
               smc.png m31.png
OTHER_FIGS = sky-dr34.png sky5p-dr34.png center-dr34.png center5p-dr34.png

CENTER_FIGS = center-dr1.png center-dr2.png center-dr3.png \
              center-dr4gs.png center-dr4asq0.png
CENTER5P_FIGS = center5p-dr1.png center5p-dr2.png center5p-dr3.png \
                center5p-dr4gs.png center5p-dr4asq0.png
CENTERFRAC_FIGS = centerfrac-dr1.png centerfrac-dr2.png centerfrac-dr3.png \
                  centerfrac-dr4gs.png centerfrac-dr4asq0.png
NOBS_FIGS = nobs-dr1.png nobs-dr2.png nobs-dr3.png \
            nobs-dr4gs.png nobs-dr4asq0.png
SMC_FIGS = smc-dr1.png smc-dr2.png smc-dr3.png smc-dr4gs.png
M31_FIGS = m31-dr1.png m31-dr2.png m31-dr3.png m31-dr4gs.png
LMC_FIGS = lmc-dr1.png lmc-dr2.png lmc-dr3.png lmc-dr4gs.png lmc-dr4asq0.png
LMCFRAC_FIGS = lmcfrac-dr1.png lmcfrac-dr2.png lmcfrac-dr3.png \
               lmcfrac-dr4gs.png lmcfrac-dr4asq0.png

F1 = dr2
F2 = dr3
F3 = dr4gs
F4 = dr4asq0

DR_FROM_TARGET_FIG = `echo $@ | sed -e's/.*\(dr[1234][a-z0]*\).*/\1/'`

build: $(MONTAGE_FIGS) $(OTHER_FIGS)

data: $(DATA_FILES)

center.fits: stilts
	sh drmap.sh -stilts ./stilts -name center -hpx 12 \
           -where "NOT (l BETWEEN 15 AND 345) AND (b BETWEEN -10 AND 10)"

sky.fits: stilts
	sh drmap.sh -stilts ./stilts -name sky -hpx 8

sky10.fits: stilts
	sh drmap.sh -stilts "./stilts -Xmx20G" -name sky10 -authall -hpx 10

lmc.fits: stilts
	sh drmap.sh -stilts ./stilts -name lmc -hpx 12 \
           -where "l BETWEEN 265 AND 295 AND b BETWEEN -43 AND -21"

smc.fits: stilts
	sh drcat.sh -stilts ./stilts -name smc -authall \
           -where "l BETWEEN 290 AND 315 AND b BETWEEN -50 AND -38"

m31.fits: stilts
	sh drcat.sh -stilts ./stilts -name m31 -sync \
           -where "ra BETWEEN 9.2 AND 12.2 AND dec BETWEEN 39.8 AND 42.8"

view: build
	$(VIEW) $(MONTAGE_FIGS) $(OTHER_FIGS)

clean:
	rm -f $(CENTER_FIGS) $(LMC_FIGS) $(CENTER5P_FIGS) $(NOBS_FIGS)
	rm -f $(LMCFRAC_FIGS) $(CENTERFRAC_FIGS)
	rm -f $(MONTAGE_FIGS) $(OTHER_FIGS) cfregions.fits cfmocs.fits

veryclean: clean
	rm -f stilts.jar stilts
	rm -f $(DATA_FILES)
	rm -f crowded_field_coverage_map.fits cfstats.fits
	rm -rf $(DATA_FILES:.fits=)

# Post-v3.5-4 stilts only required for indicesToMocAscii function
stilts.jar:
	curl -OL https://www.star.bristol.ac.uk/mbt/releases/stilts/pre/$@

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
                 value=nsrc_dr4gs*1.0/nsrc_dr3 \
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
                 value=nsrc_5p_dr4gs*1.0/nsrc_5p_dr3 \
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
                 value=nsrc_dr4gs*1.0/nsrc_dr3 \
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
                 value=nsrc_5p_dr4gs*1.0/nsrc_5p_dr3 \
                 out=$@
               
$(CENTER_FIGS): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
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

$(SMC_FIGS): smc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 in=smc.fits#smc-$$dr \
                 viewsys=galactic clon=302.6 clat=-44.2 radius=1.0 \
                 sex=false scalebar=false grid=false \
                 legend=true legpos=0.9,0.9 leglabel=$$dr \
                 xpix=500 ypix=400 \
                 auxmap=cubehelix auxfunc=log auxmin=3 auxmax=900 \
                 auxlabel='density' \
                 layer=mark lon=ra lat=dec shading=weighted combine=count \
                 datasys=equatorial \
                 out=$@

$(M31_FIGS): m31.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 in=m31.fits#m31-$$dr \
                 clon=10.70 clat=41.29 radius=0.85 \
                 xpix=500 ypix=550 \
                 sex=false scalebar=false grid=false \
                 legend=true legpos=0.9,0.9 leglabel=$$dr \
                 auxfunc=log auxmin=1 auxmax=580 auxmap=cubehelix \
                 auxvisible=true auxcrowd=0.8 auxlabel=density \
                 layer=mark lon=ra lat=dec \
                            shading=weighted combine=count \
                 out=$@

$(LMC_FIGS): lmc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 in=lmc.fits \
                 viewsys=galactic  clon=280 clat=-33 radius=1.8 \
                 sex=false scalebar=false grid=false \
                 legend=true legpos=0.9,0.9 leglabel=$$dr \
                 xpix=500 ypix=500 \
                 auxmap=ember auxfunc=log auxmin=100 auxmax=1800 \
                 auxlabel='sources per square arcminute' \
                 layer=healpix healpix=hpx12 value=density_$$dr \
                 datalevel=12 degrade=0 combine=median datasys=equatorial \
                 out=$@

$(CENTER5P_FIGS): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
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
	dr=$(DR_FROM_TARGET_FIG); \
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
	dr=$(DR_FROM_TARGET_FIG); \
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
	dr=$(DR_FROM_TARGET_FIG); \
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
	$(CONVERT) \( center-$(F1).png center-$(F2).png +append \) \
                   \( center-$(F3).png center-$(F4).png +append \) \
                   -append $@

smc.png: $(SMC_FIGS)
	$(CONVERT) \( smc-dr1.png smc-dr2.png +append \) \
                   \( smc-dr3.png smc-dr4gs.png +append \) \
                   -append $@

m31.png: $(M31_FIGS)
	$(CONVERT) \( m31-dr1.png m31-dr2.png +append \) \
                   \( m31-dr3.png m31-dr4gs.png +append \) \
                   -append $@

lmc.png: $(LMC_FIGS)
	$(CONVERT) \( lmc-$(F1).png lmc-$(F2).png +append \) \
                   \( lmc-$(F3).png lmc-$(F4).png +append \) \
                   -append $@

center5p.png: $(CENTER5P_FIGS)
	$(CONVERT) \( center5p-$(F1).png center5p-$(F2).png +append \) \
                   \( center5p-$(F3).png center5p-$(F4).png +append \) \
                   -append $@

nobs.png: $(NOBS_FIGS)
	$(CONVERT) \( nobs-dr1.png nobs-dr2.png +append \) \
                   \( nobs-dr3.png nobs-dr4gs.png +append \) \
                   -append $@

lmcfrac.png: $(LMCFRAC_FIGS)
	$(CONVERT) \( lmcfrac-$(F1).png lmcfrac-$(F2).png +append \) \
                   \( lmcfrac-$(F3).png lmcfrac-$(F4).png +append \) \
                   -append $@

centerfrac.png: $(CENTERFRAC_FIGS)
	$(CONVERT) \( centerfrac-$(F1).png centerfrac-$(F2).png +append \) \
                   \( centerfrac-$(F3).png centerfrac-$(F4).png +append \) \
                   -append $@

cfview: cfregions.fits stilts
	./stilts plot2sky in=cfregions.fits \
                          viewsys=galactic datasys=equatorial \
                          area=moc \
                          layer1=area \
                          layer2=arealabel label2=region_name color2=black

cfregions.fits: stilts cfstats.fits cfmocs.fits
	./stilts tmatch2 in1=cfstats.fits in2=cfmocs.fits \
                         matcher=exact values1=region_name values2=region_name \
                         progress=none \
                         suffix1= suffix2=_2 ocmd='delcols *_2' \
                         ocmd='sort -down nsrc' \
                         out=$@

cfstats.fits: stilts
	./stilts -Dauth.username=@username -Dauth.password=@password \
               tapquery auth=true \
                        sync=true \
                        tapurl=https://geapre.esac.esa.int/tap-server/tap \
                        adql="select region_name, ra, dec, nsrc, nimg \
                              from (select region_name, avg(ra) as ra, \
                                    avg(dec) as dec, count(*) as nsrc \
                                    from user_dr4int4.crowded_field_source \
                                    group by region_name) as s \
                              join (select region_name, count(*) as nimg \
                                 from user_dr4int4.crowded_field_image_summary \
                                    group by region_name) as f \
                              using (region_name)" \
                        out=$@

cfmocs.fits: crowded_field_coverage_map.fits stilts
	./stilts tgroup in=crowded_field_coverage_map.fits \
                        keys='region_name healpix_level' \
                        aggcols='(long)healpix_id;array;ipixs' \
                        ocmd="addcol -ucd meta.coverage -xtype moc moc \
                              indicesToMocAscii(healpix_level,ipixs)" \
                        ocmd='delcols healpix_level' \
                        ocmd='delcols ipixs' \
                        ofmt='fits(var=true,primary=basic)' \
                        out=$@

# Not present in dr4int6?
crowded_field_coverage_map.fits: stilts
	./stilts -Dauth.username=@username -Dauth.password=@password \
               tapquery auth=true \
                        tapurl=https://geapre.esac.esa.int/tap-server/tap \
                        sync=false \
                        adql="select * from user_dr4int4.$(@:.fits=)" \
                        out=$@



