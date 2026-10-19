Notes:

Each image is provided in two sizes, <name>-size0.png
and <name>-size1.png, as well as an animated gif <name>-size0.gif.

These don't correspond exactly to the sizes at
https://gaia.esac.esa.int/dpacsvn/DPAC/CU8/MPIA/software/skymap/README.rst
since they don't all have the same shape, but they have approximately
the same width (size0 is ~1000 pixels across, size1 ~2000 pixels across).

If you want size2 as well for some or all of them let me know,
however for some of the figures (galactic center and Baade's window)
there may be problems getting the resolution high enough to make
that worthwhile because of GACS limitations (currently blocked by
C9GACS-1201, since to do HEALPix aggregation for order>12
the gaia_healpix_index UDF doesn't work and ivo_healpix_index
is currently broken).

I've written captions as best I can, but I'm not an expert on the
science or data processing.  Before using them could you run the
text past somebody who knows what they're talking about?
Please add attribution as appropriate.

For the M31 and SMC montages I have removed the colour ramp because
I can't easily generate them in physical units like sources per square
arcmin (it's to do with the fact that the density is relatively low).
But I could reinstate it, either without units or with somewhat
arbitrary units, on request.
Conversely if you want to remove the colour ramp from the other
images I can regenerate them without it (or you can just clip it off) -
it's actually much easier to generate the montages without the
colour ramp.  Personally I think that the quantitative information
is interesting/useful, and it makes it clear that the same colour
map is in use for all of the 4 frames.

The galactic center figures have 5-degree grid lines on them,
but I could remove these if you think it looks better.
Other cosmetic changes you'd prefer, just let me know.

For the record, these figures are all reproducible using the
makefiles at https://github.com/mbtaylor/dr4vis/.

---------------------------------------------------------------

Credit: ESA/Gaia/DPAC
License: CC BY-SA 3.0 IGO
Acknowledgement: Mark Taylor/Tineke Roegiers, created using TOPCAT/STILTS

---------------------------------------------------------------
center:

Title:
   Galactic center source density in Gaia DR1/2/3/4

Short caption:
   Density of Gaia sources in a 30x20 degree region in the galactic center,
   shown for Gaia DR1, DR2, DR3 and DR4.

Long caption:
   Note that the scanning artifacts are all but absent in DR4.
   The data is from the gaia_source table in each release;
   at DR4 this table consolidates all sources considered to have
   both high-quality astrometry and high-quality photometry.
   The large black spots are regions for which SIF Crowded Field
   measurements were used, with densities up to around 2000
   sources per square arcminute.
   These correspond to the SGR I and Baade's Window regions.
   A third and less prominent Crowded Field region, NGC6656,
   is also visible towards the lower left.

---------------------------------------------------------------
centerdr4:

Title:
   Galactic center source densities in Gaia DR4

Short caption:
   The density of Gaia sources in a 30x20 degree region in the
   galactic center, taken from four different selections in Gaia DR4.
   1: the gaia_source table; 2: gaia_source excluding entries
   with astrometry from the crowded field processing;
   3: AGIS solutions from the all_source table;
   and 4: the crowded field processing results only.

Long caption:
   The selections are:
     1. FROM gaia_source
     2. FROM gaia_source WHERE astrometry_origin != 'crowded_field_source'
     3. FROM all_source_astrometry WHERE quality_flag = 0
     4. FROM crowded_field_source

   Claus Fabricius said (C9OUTR-298):
     "You may select sources with quality_flag=0 from
      user_dr4int6.all_source_astrometry That will give all acceptable
      AGIS solutions in cycle 4, and contributions from other pipelines
      (CF, SeaPipe) will be left out. It is therefore directly comparable
      to earlier cycles where gaia_source only included sources from AGIS."

Note:
   Claus should be added to the credits for this one.


---------------------------------------------------------------
centerfrac

Title:
   Proportion of Galactic center sources with measured proper motion
   in Gaia DR1/2/3/4

Short caption:
   This shows the fraction of Gaia sources in a 30x20 degree region in
   the galactic center for which proper motion as well as position
   has been measured, for Gaia DR1, DR2, DR3 and DR4.

Long caption:
   All sources in the gaia_source catalogue for each data release have
   high-quality positions determined by Gaia, but values for their
   proper motions require a large number of observations and can only
   be determined for some fraction of those sources.
   At DR1 very few proper motions could be determined so this fraction
   is near zero over the whole of this region.  Later data releases
   have accumulated more observations so that motions can be determined
   for a higher fraction of the observed sources.
   At DR4 around 90% of the sources in most of this region have
   proper motion as well as position values.  The stripes show the
   influence of the scanning law on this quantity.


---------------------------------------------------------------
smc:

Title:
   SMC source density in Gaia DR1/2/3/4

Short caption:
   Gaia sources in the Small Magellanic Cloud, shown in a
   galactic projection for Gaia DR1, DR2, DR3 and DR4.
   The colours indicate source density on a logarithmic scale.


---------------------------------------------------------------
lmcfrac:

Title:
   Proportion of LMC sources with measured proper motion in Gaia DR1/2/3/4

Short caption:
   This shows the fraction of Gaia sources in the region of the
   Large Magellanic Cloud for which proper motion as as well as
   position has been measured, for Gaia DR1, DR2, DR3 and DR4.

Long caption:
   All sources in the gaia_source catalogue for each data release have
   high-quality positions determined by Gaia, but values for their
   proper motions require a large number of observations and can only
   be determined for some fraction of those sources.
   At DR1 very few proper motions could be determined so this fraction
   is near zero over the whole of this region.  Later data releases
   have accumulated more observations so that motions can be determined
   for a higher fraction of the observed sources.
   At DR4 around 90% of the sources in most of this region have
   proper motion as well as position values, and the instrumental
   signature due to the scanning law evident in earlier releases
   is much reduced.  The dark shape in the middle for DR4 corresponds
   to SIF CF processing performed in this region in which proper
   motions have been determined for nearly all the sources.
   The astrometry is taken from the gaia_source catalogue in each
   data release.

---------------------------------------------------------------
m31:

Title:
   M31 sources in Gaia DR1/2/3/4

Short caption:
   Gaia sources in the region of M31, shown in an equatorial
   projection for Gaia DR1, DR2, DR3 and DR4.
   The colours in crowded regions indicate source density on
   a logarithmic scale.


---------------------------------------------------------------
baade:

Title:
   Baade's Window source density in Gaia DR1/2/3/4

Short caption:
   Density of Gaia sources in the region of Baade's window,
   shown in a galactic projection for Gaia DR1, DR2, DR3 and DR4.

Long caption:
   Baade's window is one of the SIF CF regions.
   The data is from the gaia_source table in each release.
   At DR4 this table consolidates all sources considered to have
   both high-quality astrometry and high-quality photometry,
   and most of the gaia_source astrometry in this region results
   from Crowded Field processing.

---------------------------------------------------------------
nobs:

Title:
   Observation count on the sky in Gaia DR1/2/3/4

Short Caption:
   The number of times that Gaia has observed sources in different
   parts of the sky, determined by its scanning law, is shown in
   a galactic projection for Gaia DR1, DR2, DR3 and DR4.



