
.SUFFIXES: .png .view -size0.png -size1.png

.png.view:
	test -f $< && $(VIEW) $<

# Some kind of image viewing command, used only for view target.
VIEW = display

# These files are built by the makefile in the parent directory.
# Could add some recursive make to get them built, but for now I'm
# just running make build in the parent directory.
DATA_FILES = center.fits sky.fits smc.fits lmc.fits m31.fits baade.fits

# These are the actual files to be uploaded to the SFTP.
FTP_FIGS = $(NOBS_MONTAGE_FIGS) $(CENTER_MONTAGE_FIGS) \
           $(CENTERDR4_MONTAGE_FIGS) $(CENTERFRAC_MONTAGE_FIGS) \
           $(SMC_MONTAGE_FIGS) $(LMCFRAC_MONTAGE_FIGS) \
           $(M31_MONTAGE_FIGS) $(BAADE_MONTAGE_FIGS)

OTHER_FIGS = $(NOBS_OTHER_FIGS) $(CENTER_OTHER_FIGS) \
             $(CENTERDR4_OTHER_FIGS) $(CENTERFRAC_OTHER_FIGS) \
             $(SMC_OTHER_FIGS) $(LMCFRAC_OTHER_FIGS) \
             $(M31_OTHER_FIGS) $(BAADE_OTHER_FIGS)

$(DATA_FILES):
	ln -s ../$@ ./

build: build-ftp-figs

view-size0: build
	display `ls $(FTP_FIGS) | grep size0`

view-size1: build
	display `ls $(FTP_FIGS) | grep size1`

clean:
	rm -f $(DATA_FILES) $(FTP_FIGS) $(OTHER_FIGS)

veryclean:
	rm -f stilts stilts.jar

stilts.jar:
	curl -OL http://www.starlink.ac.uk/stilts/$@

stilts: stilts.jar
	unzip stilts.jar stilts
	touch stilts
	chmod +x stilts

DR_FROM_TARGET_FIG = `echo $@ | sed -e's/.*\(dr[1234][a-z0]*\).*/\1/'`
FONT_SIZE0 = fontsize=18 texttype=antialias
FONT_SIZE1 = fontsize=36 texttype=antialias
DR_LEGLABEL = `sh labelname.sh $$dr`
LABEL_LAYER = \
   layer_l=mark size_l=0 color_l=white lon_l=0 lat_l=0 icmd_l='head 0' legseq=_l

NOBS_FIGS_BASE = nobs-dr1 nobs-dr2 nobs-dr3 nobs-dr4gs
NOBS_FIGS_SIZE0 = $(NOBS_FIGS_BASE:=-size0.png)
NOBS_FIGS_SIZE1 = $(NOBS_FIGS_BASE:=-size1.png)
NOBS_MONTAGE_FIGS = nobs-size0.png nobs-size1.png
NOBS_OTHER_FIGS = $(NOBS_FIGS_SIZE0) $(NOBS_FIGS_SIZE1) \
                  nobs-ramp-size0.png nobs-ramp-size1.png

CENTER_FIGS_BASE = center-dr1 center-dr2 center-dr3 center-dr4gs
CENTER_FIGS_SIZE0 = $(CENTER_FIGS_BASE:=-size0.png)
CENTER_FIGS_SIZE1 = $(CENTER_FIGS_BASE:=-size1.png)
CENTER_MONTAGE_FIGS = center-size0.png center-size1.png
CENTER_OTHER_FIGS = $(CENTER_FIGS_SIZE0) $(CENTER_FIGS_SIZE1) \
                    center-ramp-size0.png center-ramp-size1.png

CENTERDR4_FIGS_BASE = centerdr4-dr4gs centerdr4-dr4ncf \
                      centerdr4-dr4asq0 centerdr4-dr4cf
CENTERDR4_FIGS_SIZE0 = $(CENTERDR4_FIGS_BASE:=-size0.png)
CENTERDR4_FIGS_SIZE1 = $(CENTERDR4_FIGS_BASE:=-size1.png)
CENTERDR4_MONTAGE_FIGS = centerdr4-size0.png centerdr4-size1.png
CENTERDR4_OTHER_FIGS = $(CENTERDR4_FIGS_SIZE0) $(CENTERDR4_FIGS_SIZE1) \
                       centerdr4-ramp-size0.png centerdr4-ramp-size1.png

CENTERFRAC_FIGS_BASE = centerfrac-dr1 centerfrac-dr2 \
                       centerfrac-dr3 centerfrac-dr4gs
CENTERFRAC_FIGS_SIZE0 = $(CENTERFRAC_FIGS_BASE:=-size0.png)
CENTERFRAC_FIGS_SIZE1 = $(CENTERFRAC_FIGS_BASE:=-size1.png)
CENTERFRAC_MONTAGE_FIGS = centerfrac-size0.png centerfrac-size1.png
CENTERFRAC_OTHER_FIGS = $(CENTERFRAC_FIGS_SIZE0) $(CENTERFRAC_FIGS_SIZE1) \
                        centerfrac-ramp-size0.png centerfrac-ramp-size1.png

SMC_FIGS_BASE = smc-dr1 smc-dr2 smc-dr3 smc-dr4gs
SMC_FIGS_SIZE0 = $(SMC_FIGS_BASE:=-size0.png)
SMC_FIGS_SIZE1 = $(SMC_FIGS_BASE:=-size1.png)
SMC_MONTAGE_FIGS = smc-size0.png smc-size1.png
SMC_OTHER_FIGS = $(SMC_FIGS_SIZE0) $(SMC_FIGS_SIZE1)

LMCFRAC_FIGS_BASE = lmcfrac-dr1 lmcfrac-dr2 lmcfrac-dr3 lmcfrac-dr4gs
LMCFRAC_FIGS_SIZE0 = $(LMCFRAC_FIGS_BASE:=-size0.png)
LMCFRAC_FIGS_SIZE1 = $(LMCFRAC_FIGS_BASE:=-size1.png)
LMCFRAC_MONTAGE_FIGS = lmcfrac-size0.png lmcfrac-size1.png
LMCFRAC_OTHER_FIGS = $(LMCFRAC_FIGS_SIZE0) $(LMCFRAC_FIGS_SIZE1) \
                     lmcfrac-ramp-size0.png lmcfrac-ramp-size1.png

M31_FIGS_BASE = m31-dr1 m31-dr2 m31-dr3 m31-dr4gs
M31_FIGS_SIZE0 = $(M31_FIGS_BASE:=-size0.png)
M31_FIGS_SIZE1 = $(M31_FIGS_BASE:=-size1.png)
M31_MONTAGE_FIGS = m31-size0.png m31-size1.png
M31_OTHER_FIGS = $(M31_FIGS_SIZE0) $(M31_FIGS_SIZE1)

BAADE_FIGS_BASE = baade-dr1 baade-dr2 baade-dr3 baade-dr4gs
BAADE_FIGS_SIZE0 = $(BAADE_FIGS_BASE:=-size0.png)
BAADE_FIGS_SIZE1 = $(BAADE_FIGS_BASE:=-size1.png)
BAADE_MONTAGE_FIGS = baade-size0.png baade-size1.png
BAADE_OTHER_FIGS = $(BAADE_FIGS_SIZE0) $(BAADE_FIGS_SIZE1) \
                   baade-ramp-size0.png baade-ramp-size1.png



build-ftp-figs: $(FTP_FIGS)

NOBS_AUX = auxclip=0,1 auxmin=0 auxmax=1620 auxmap=voltage

$(NOBS_FIGS_SIZE0): sky.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
               xpix=500 ypix=250 $(FONT_SIZE0) \
               in=sky.fits \
               projection=aitoff labelpos=none \
               datasys=equatorial viewsys=galactic \
               layer_h=healpix healpix_h=hpx8 value_h=nobs_$$dr datalevel_h=8 \
               auxvisible=false $(NOBS_AUX) \
               legend=true legpos=1.0,1.0 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

$(NOBS_FIGS_SIZE1): sky.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
               xpix=1000 ypix=500 $(FONT_SIZE1) \
               in=sky.fits \
               projection=aitoff labelpos=none \
               datasys=equatorial viewsys=galactic \
               layer_h=healpix healpix_h=hpx8 value_h=nobs_$$dr datalevel_h=8 \
               auxvisible=false $(NOBS_AUX) \
               legend=true legpos=1.0,1.0 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

nobs-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=16 $(NOBS_AUX) \
                 auxlabel="observations per source" \
                 xpix=140 ypix=500 insets=,,,120 \
                 out=$@

nobs-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=32 auxcrowd=0.5 $(NOBS_AUX) \
                 auxlabel="observations per source" \
                 xpix=280 ypix=1000 insets=,,,240 \
                 out=$@

nobs-size0.png: stilts $(NOBS_FIGS_SIZE0) nobs-ramp-size0.png
	sh montage.sh -ramp nobs-ramp-size0.png $(NOBS_FIGS_SIZE0) $@

nobs-size1.png: stilts $(NOBS_FIGS_SIZE1) nobs-ramp-size1.png
	sh montage.sh -ramp nobs-ramp-size1.png $(NOBS_FIGS_SIZE1) $@

CENTER_AUX = auxmap=ember auxclip=0,1 auxmin=0 auxmax=670

$(CENTER_FIGS_SIZE0): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
	./stilts plot2sky \
               xpix=500 ypix=350 $(FONT_SIZE0) \
               insets='10,10,10,10' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 value_h=density_$$dr \
               datalevel_h=12 degrade_h=2 combine_h=median \
               datasys_h=equatorial \
               auxvisible=false $(CENTER_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

center-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=20 auxcrowd=0.8 $(CENTER_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=120 ypix=700 insets=,,,140 \
                 out=$@

center-size0.png: $(CENTER_FIGS_SIZE0) center-ramp-size0.png 
	sh montage.sh -ramp center-ramp-size0.png $(CENTER_FIGS_SIZE0) $@

$(CENTER_FIGS_SIZE1): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
	./stilts plot2sky \
               xpix=1000 ypix=700 $(FONT_SIZE1) \
               insets='20,20,20,20' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 value_h=density_$$dr \
               datalevel_h=12 degrade_h=2 combine_h=median \
               datasys_h=equatorial \
               auxvisible=false $(CENTER_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

center-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=40 auxcrowd=0.4 $(CENTER_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=240 ypix=1400 insets=,,,280 \
                 out=$@

center-size1.png: $(CENTER_FIGS_SIZE1) center-ramp-size1.png 
	sh montage.sh -ramp center-ramp-size1.png $(CENTER_FIGS_SIZE1) $@


CENTERDR4_AUX = auxmap=ember auxclip=0,1 auxmin=0 auxmax=2300

$(CENTERDR4_FIGS_SIZE0): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
	./stilts plot2sky \
               xpix=500 ypix=350 $(FONT_SIZE0) \
               insets='10,10,10,10' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 value_h=density_$$dr \
               datalevel_h=12 degrade_h=2 combine_h=median \
               datasys_h=equatorial \
               auxvisible=false $(CENTERDR4_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l="`sh dr4labelname.sh $$dr`" \
               out=$@

centerdr4-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=20 auxcrowd=0.6 $(CENTERDR4_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=120 ypix=700 insets=,,,140 \
                 out=$@

centerdr4-size0.png: $(CENTERDR4_FIGS_SIZE0) centerdr4-ramp-size0.png 
	sh montage.sh -ramp centerdr4-ramp-size0.png $(CENTERDR4_FIGS_SIZE0) $@

$(CENTERDR4_FIGS_SIZE1): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
	./stilts plot2sky \
               xpix=1000 ypix=700 $(FONT_SIZE1) \
               insets='20,20,20,20' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 value_h=density_$$dr \
               datalevel_h=12 degrade_h=2 combine_h=median \
               datasys_h=equatorial \
               auxvisible=false $(CENTERDR4_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

centerdr4-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=40 auxcrowd=0.3 $(CENTERDR4_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=240 ypix=1400 insets=,,,280 \
                 out=$@

centerdr4-size1.png: $(CENTERDR4_FIGS_SIZE1) centerdr4-ramp-size1.png 
	sh montage.sh -ramp centerdr4-ramp-size1.png $(CENTERDR4_FIGS_SIZE1) $@


CENTERFRAC_AUX = auxmap=light auxfunc=square auxmin=0.0 auxmax=1.0

$(CENTERFRAC_FIGS_SIZE0): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        degrade=`test $$dr = dr1 && echo 5 || echo 2`; \
        ./stilts plot2sky \
               xpix=500 ypix=350 $(FONT_SIZE0) \
               insets='10,10,10,10' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 \
               value_h=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel_h=12 degrade_h=$$degrade combine_h=mean \
               datasys_h=equatorial \
               auxvisible=false $(CENTERFRAC_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

centerfrac-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=20 auxcrowd=0.8 $(CENTERFRAC_AUX) \
                 auxlabel='Fraction of sources with proper motions' \
                 xpix=120 ypix=700 insets=,,,140 \
                 out=$@

centerfrac-size0.png: $(CENTERFRAC_FIGS_SIZE0) centerfrac-ramp-size0.png 
	sh montage.sh -ramp centerfrac-ramp-size0.png $(CENTERFRAC_FIGS_SIZE0) \
                      $@

$(CENTERFRAC_FIGS_SIZE1): center.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        degrade=`test $$dr = dr1 && echo 5 || echo 2`; \
        ./stilts plot2sky \
               xpix=1000 ypix=700 $(FONT_SIZE1) \
               insets='20,20,20,20' \
               in=center.fits \
               viewsys=galactic clon=0 clat=0 radius=10 labelpos=none \
               sex=false scalebar=false \
               layer_h=healpix healpix_h=hpx12 \
               value_h=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel_h=12 degrade_h=$$degrade combine_h=mean \
               datasys_h=equatorial \
               auxvisible=false $(CENTERFRAC_AUX) \
               legend=true legpos=0.9,0.9 \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

centerfrac-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=40 auxcrowd=0.4 $(CENTERFRAC_AUX) \
                 auxlabel='Fraction of sources having proper motions' \
                 xpix=240 ypix=1400 insets=,,,280 \
                 out=$@

centerfrac-size1.png: $(CENTERFRAC_FIGS_SIZE1) centerfrac-ramp-size1.png 
	sh montage.sh -ramp centerfrac-ramp-size1.png $(CENTERFRAC_FIGS_SIZE1) \
                      $@


SMC_AUX = auxmap=cubehelix auxfunc=log auxvisible=false

$(SMC_FIGS_SIZE0): smc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=500 ypix=400 $(FONT_SIZE0) \
                 $(SMC_AUX) auxmin=10 auxmax=950 \
                 insets=4,4,4,4 \
                 in=smc.fits#smc-$$dr \
                 viewsys=galactic clon=302.6 clat=-44.2 radius=1.1 \
                 labelpos=none \
                 sex=false scalebar=true grid=false \
                 layer_m=mark lon_m=ra lat_m=dec \
                 shading_m=weighted combine_=count \
                 datasys_m=equatorial \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
                 out=$@

smc-size0.png: $(SMC_FIGS_SIZE0)
	sh montage.sh $(SMC_FIGS_SIZE0) $@

$(SMC_FIGS_SIZE1): smc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=1000 ypix=800 $(FONT_SIZE1) \
                 $(SMC_AUX) auxmin=1 auxmax=250 \
                 insets=8,8,8,8 \
                 in=smc.fits#smc-$$dr \
                 viewsys=galactic clon=302.6 clat=-44.2 radius=1.1 \
                 labelpos=none \
                 sex=false scalebar=true grid=false \
                 layer_m=mark lon_m=ra lat_m=dec \
                 shading_m=weighted combine_=count \
                 datasys_m=equatorial \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
                 out=$@

smc-size1.png: $(SMC_FIGS_SIZE1)
	sh montage.sh $(SMC_FIGS_SIZE1) $@


LMCFRAC_AUX = auxmap=light auxfunc=linear auxmin=0.5 auxmax=1.0

$(LMCFRAC_FIGS_SIZE0): lmc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        degrade=`test $$dr = dr1 && echo 5 || echo 2`; \
        ./stilts plot2sky \
               in=lmc.fits \
               xpix=500 ypix=420 $(FONT_SIZE0) \
               insets='10,10,10,10' \
               viewsys=galactic clon=279 clat=-32.5 radius=7.5 \
               sex=false scalebar=true grid=false \
               legend=true legpos=0.9,0.9 \
               labelpos=none \
               layer_h=healpix healpix_h=hpx12 \
               value_h=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel_h=12 degrade_h=$$degrade combine_h=mean \
               datasys_h=equatorial \
               auxvisible=false $(LMCFRAC_AUX) \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

lmcfrac-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=20 auxcrowd=0.6 $(LMCFRAC_AUX) \
                 auxlabel='Fraction of sources with proper motions' \
                 xpix=120 ypix=840 insets=,,,100 \
                 out=$@

lmcfrac-size0.png: $(LMCFRAC_FIGS_SIZE0) lmcfrac-ramp-size0.png 
	sh montage.sh -ramp lmcfrac-ramp-size0.png $(LMCFRAC_FIGS_SIZE0) \
                      $@

$(LMCFRAC_FIGS_SIZE1): lmc.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        degrade=`test $$dr = dr1 && echo 5 || echo 1`; \
        ./stilts plot2sky \
               in=lmc.fits \
               xpix=1000 ypix=840 $(FONT_SIZE1) \
               insets='20,20,20,20' \
               viewsys=galactic clon=279 clat=-32.5 radius=7.5 \
               sex=false scalebar=true grid=false \
               legend=true legpos=0.9,0.9 \
               labelpos=none \
               layer_h=healpix healpix_h=hpx12 \
               value_h=nsrc_5p_$$dr*1.0/nsrc_$$dr \
               datalevel_h=12 degrade_h=$$degrade combine_h=mean \
               datasys_h=equatorial \
               auxvisible=false $(LMCFRAC_AUX) \
               $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
               out=$@

lmcfrac-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=40 auxcrowd=0.3 $(LMCFRAC_AUX) \
                 auxlabel='Fraction of sources with proper motions' \
                 xpix=240 ypix=1680 insets=,,,200 \
                 out=$@

lmcfrac-size1.png: $(LMCFRAC_FIGS_SIZE1) lmcfrac-ramp-size1.png 
	sh montage.sh -ramp lmcfrac-ramp-size1.png $(LMCFRAC_FIGS_SIZE1) \
                      $@


M31_AUX = auxmap=cubehelix auxfunc=log auxvisible=false

$(M31_FIGS_SIZE0): m31.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=500 ypix=550 $(FONT_SIZE0) \
                 insets=4,4,4,4 \
                 $(M31_AUX) auxmin=1 auxmax=580 \
                 in=m31.fits#m31-$$dr \
                 clon=10.70 clat=41.29 radius=0.89 \
                 sex=false scalebar=true grid=false labelpos=none \
                 layer_m=mark lon_m=ra lat_m=dec \
                            shading_m=weighted combine_m=count \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
                 out=$@

m31-size0.png: $(M31_FIGS_SIZE0)
	sh montage.sh $(M31_FIGS_SIZE0) $@

$(M31_FIGS_SIZE1): m31.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=1000 ypix=1100 $(FONT_SIZE1) \
                 insets=8,8,8,8 \
                 $(M31_AUX) auxmin=1 auxmax=580 \
                 in=m31.fits#m31-$$dr \
                 clon=10.70 clat=41.29 radius=0.89 \
                 sex=false scalebar=true grid=false labelpos=none \
                 layer_m=mark lon_m=ra lat_m=dec \
                            shading_m=weighted combine_m=count \
                            size_m=2 \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel_l=$(DR_LEGLABEL) \
                 out=$@

m31-size1.png: $(M31_FIGS_SIZE1)
	sh montage.sh $(M31_FIGS_SIZE1) $@


BAADE_AUX = auxmin=95 auxmax=9000 auxfunc=log auxmap=rainforest auxclip=0,1

$(BAADE_FIGS_SIZE0): baade.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=500 ypix=400 $(FONT_SIZE0) \
                 insets=4,4,4,4 \
                 in=baade.fits#baade-$$dr \
                 viewsys=galactic \
                 clon=1.03 clat=-3.93 radius=0.4 \
                 sex=false grid=false \
                 layer_d=skydensity lon_d=ra lat_d=dec level_d=14 \
                       combine_d=count-per-unit perunit_d=arcmin2 \
                       datasys_d=equatorial \
                 auxvisible=false $(BAADE_AUX) \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel=$(DR_LEGLABEL) \
                 out=$@

baade-ramp-size0.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE0) \
                 auxvisible=true auxwidth=20 auxcrowd=0.8 $(BAADE_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=140 ypix=800 insets=,,,120 \
                 out=$@

baade-size0.png: $(BAADE_FIGS_SIZE0) baade-ramp-size0.png
	sh montage.sh -ramp baade-ramp-size0.png $(BAADE_FIGS_SIZE0) $@

$(BAADE_FIGS_SIZE1): baade.fits stilts
	dr=$(DR_FROM_TARGET_FIG); \
        ./stilts plot2sky \
                 xpix=1000 ypix=800 $(FONT_SIZE1) \
                 insets=8,8,8,8 \
                 in=baade.fits#baade-$$dr \
                 viewsys=galactic \
                 clon=1.03 clat=-3.93 radius=0.4 \
                 sex=false grid=false \
                 layer_d=skydensity lon_d=ra lat_d=dec level_d=15 \
                       combine_d=count-per-unit perunit_d=arcmin2 \
                       datasys_d=equatorial \
                 auxvisible=false $(BAADE_AUX) \
                 legend=true legpos=0.9,0.9 \
                 $(LABEL_LAYER) leglabel=$(DR_LEGLABEL) \
                 out=$@

baade-ramp-size1.png: stilts
	./stilts plot2sky \
                 grid=false $(FONT_SIZE1) \
                 auxvisible=true auxwidth=40 auxcrowd=0.8 $(BAADE_AUX) \
                 auxlabel='sources per square arcminute' \
                 xpix=280 ypix=1600 insets=,,,240 \
                 out=$@

baade-size1.png: $(BAADE_FIGS_SIZE1) baade-ramp-size1.png
	sh montage.sh -ramp baade-ramp-size1.png $(BAADE_FIGS_SIZE1) $@



