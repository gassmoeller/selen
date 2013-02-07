#=====================================================================
#
#  SELEN: a program for solving the "Sea Level Equation"  Version 2.9
#  ------------------------------------------------------------------
#
#          Main authors: Giorgio Spada and Daniele Melini
#
# SELEN is free software: you can redistribute it and/or modify it under the 
# terms of the GNU General Public License as published by the Free Software 
# Foundation, either version 3 of the License, or at your option) any later 
# version. 
#
# SELEN is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more 
# details. 
# 
# You should have received a copy of the GNU General Public License along 
# with SELEN.  If not, see <http://www.gnu.org/licenses/>.
#
#=====================================================================

EXEEXT = .exe
FC = g95
GMT = gmt
FCFLAGS = -g -O2 -ffixed-line-length-132 -I${SETUP} -I${B} -w -fmod=${SETUP} ${OPENMP_FCFLAGS}
FCCOMPILE = ${FC} ${FCFLAGS}

## compilation directories
# B : build directory
B = .
# E : executables directory
E = ${B}/bin
# O : objects directory
O = ${B}/obj
# S : source file directory
S = ${B}/src
## setup file directory
SETUP = ${B}/tmp

#######################################

CONFIG_OBJECTS = \
	$O/shtools.o \
	$O/config.o \
	$O/harmonics.o

# Equivalent sea level
ESL_OBJECTS = \
	$O/harmonics.o \
	$O/esl.o

# 3D veolcity and \dot S, N, U at sites
GEO_OBJECTS = \
	$O/harmonics.o \
	$O/geo.o

# Global maps 
GMAPS_OBJECTS = \
	$O/harmonics.o \
	$O/gmaps.o

# Ice sheets contours
MS_OBJECTS = \
	$O/harmonics.o \
	$O/ms.o

# OF DV computation 
OFDV_OBJECTS = \
	$O/harmonics.o \
	$O/of_dv.o

# Pixelization (i)
PX_OBJECTS = \
	$O/harmonics.o \
	$O/px.o

# Retrieve pixelization info from existing table
PXREBUILD_OBJECTS = \
	$O/harmonics.o \
	$O/px_rebuild.o

# Pixelization (ii) 
PXREC_OBJECTS = \
	$O/harmonics.o \
	$O/px_rec.o

# Ice sheets Rechonstruction 
RECICE_OBJECTS = \
	$O/harmonics.o \
	$O/rec_ice.o

# OF Rechonstruction 
RECOF_OBJECTS = \
	$O/harmonics.o \
	$O/rec_of.o

# Regional maps  
RMAPS_OBJECTS = \
	$O/harmonics.o \
	$O/rmaps.o

# RSL at RSL sites  
RSL_OBJECTS = \
	$O/harmonics.o \
	$O/rsl.o

# RSL at virtual sites for RSL contours 
RSLC_OBJECTS = \
	$O/harmonics.o \
	$O/rslc.o

# RSL Zones 
RSLZONES_OBJECTS = \
	$O/harmonics.o \
	$O/rsl_zones.o

# Spherical harmonics 
SH_OBJECTS = \
	$O/harmonics.o \
	$O/sh.o

# Ocean function (OF) harmonics 
SHOF_OBJECTS = \
	$O/harmonics.o \
	$O/sh_of.o

# Computation of ice Shape factors and SH dechomposition
SHAPE_FACTORS_OBJECTS = \
	$O/harmonics.o \
	$O/shape_factors.o

SHICE_OBJECTS = \
	$O/harmonics.o \
	$O/shice.o

# SH at virtual sites for RSL contours 
SHRSL_OBJECTS = \
	$O/harmonics.o \
	$O/sh_rsl.o

# SH at virtual sites for RSL contours 
SHRSLC_OBJECTS = \
	$O/harmonics.o \
	$O/sh_rslc.o

# SH at tide gauges
SHTGAUGES_OBJECTS = \
	$O/harmonics.o \
	$O/sh_tgauges.o

SLE_OBJECTS = \
	$O/harmonics.o \
	$O/sle.o

# Stokes coefficients
STOKES_OBJECTS = \
	$O/harmonics.o \
	$O/stokes.o

# Love numbers tools (TABOO)
TB_OBJECTS = \
	$O/harmonics.o \
	$O/tb.o

# SL change at tide gauges
TGAUGES_OBJECTS = \
	$O/harmonics.o \
	$O/tgauges.o

# Window function
WNW_OBJECTS = \
	$O/harmonics.o \
	$O/wnw.o

# Pixelization partitioning - missing source file px_part.f90
# Copy to local storage - missing source file px_copy.f90
# Parallel wet/dry pixel separation - missing source file px_select.f90
# 3D veolcity and \dot U at pixels on maps - missing source file geo_maps.f90

#######################################
####
#### targets
####

# default targets
DEFAULT = \
	config$(EXEEXT) \
	esl$(EXEEXT) \
	gmaps$(EXEEXT) \
	ms$(EXEEXT) \
	ofdv$(EXEEXT) \
	px$(EXEEXT) \
	pxrebuild$(EXEEXT) \
	pxrec$(EXEEXT) \
	recice$(EXEEXT) \
	recof$(EXEEXT) \
	rmaps$(EXEEXT) \
	rsl$(EXEEXT) \
	rslc$(EXEEXT) \
	rslzones$(EXEEXT) \
	sle$(EXEEXT) \
	sh$(EXEEXT) \
	shice$(EXEEXT) \
	shof$(EXEEXT) \
	shapefactors$(EXEEXT) \
	shrsl$(EXEEXT) \
	shrslc$(EXEEXT) \
	shtgauges$(EXEEXT) \
	stokes$(EXEEXT) \
	tb$(EXEEXT) \
	tgauges$(EXEEXT) \
	wnw$(EXEEXT)

#	geo$(EXEEXT) \

default: $(DEFAULT)

all: default

run: default
	(cd ${SETUP} && PATH=${PATH}:`pwd`/../${E} GMT=${GMT} ./selen.sh)

req_dirs:
	mkdir -p ${E}; mkdir -p ${O}; mkdir -p ${SETUP}

#######################################
#### rules for executables
#######################################

config$(EXEEXT): req_dirs $(CONFIG_OBJECTS)
	${FCCOMPILE} -o ${E}/config$(EXEEXT) $(CONFIG_OBJECTS)

esl$(EXEEXT): req_dirs $(ESL_OBJECTS)
	${FCCOMPILE} -o ${E}/esl$(EXEEXT) $(ESL_OBJECTS)

geo$(EXEEXT): req_dirs $(GEO_OBJECTS)
	${FCCOMPILE} -o ${E}/geo$(EXEEXT) $(GEO_OBJECTS)

gmaps$(EXEEXT): req_dirs $(GMAPS_OBJECTS)
	${FCCOMPILE} -o ${E}/gmaps$(EXEEXT) $(GMAPS_OBJECTS)

ms$(EXEEXT): req_dirs $(MS_OBJECTS)
	${FCCOMPILE} -o ${E}/ms$(EXEEXT) $(MS_OBJECTS)

ofdv$(EXEEXT): req_dirs $(OFDV_OBJECTS)
	${FCCOMPILE} -o ${E}/ofdv$(EXEEXT) $(OFDV_OBJECTS)

px$(EXEEXT): req_dirs $(PX_OBJECTS)
	${FCCOMPILE} -o ${E}/px$(EXEEXT) $(PX_OBJECTS)

pxrebuild$(EXEEXT): req_dirs $(PXREBUILD_OBJECTS)
	${FCCOMPILE} -o ${E}/pxrebuild$(EXEEXT) $(PXREBUILD_OBJECTS)

pxrec$(EXEEXT): req_dirs $(PXREC_OBJECTS)
	${FCCOMPILE} -o ${E}/pxrec$(EXEEXT) $(PXREC_OBJECTS)

recice$(EXEEXT): req_dirs $(RECICE_OBJECTS)
	${FCCOMPILE} -o ${E}/recice$(EXEEXT) $(RECICE_OBJECTS)

recof$(EXEEXT): req_dirs $(RECOF_OBJECTS)
	${FCCOMPILE} -o ${E}/recof$(EXEEXT) $(RECOF_OBJECTS)

rmaps$(EXEEXT): req_dirs $(RMAPS_OBJECTS)
	${FCCOMPILE} -o ${E}/rmaps$(EXEEXT) $(RMAPS_OBJECTS)

rsl$(EXEEXT): req_dirs $(RSL_OBJECTS)
	${FCCOMPILE} -o ${E}/rsl$(EXEEXT) $(RSL_OBJECTS)

rslc$(EXEEXT): req_dirs $(RSLC_OBJECTS)
	${FCCOMPILE} -o ${E}/rslc$(EXEEXT) $(RSLC_OBJECTS)

rslzones$(EXEEXT): req_dirs $(RSLZONES_OBJECTS)
	${FCCOMPILE} -o ${E}/rslzones$(EXEEXT) $(RSLZONES_OBJECTS)

sh$(EXEEXT): req_dirs $(SH_OBJECTS)
	${FCCOMPILE} -o ${E}/sh$(EXEEXT) $(SH_OBJECTS)

shof$(EXEEXT): req_dirs $(SHOF_OBJECTS)
	${FCCOMPILE} -o ${E}/shof$(EXEEXT) $(SHOF_OBJECTS)

shapefactors$(EXEEXT): req_dirs $(SHAPE_FACTORS_OBJECTS)
	${FCCOMPILE} -o ${E}/shapefactors$(EXEEXT) $(SHAPE_FACTORS_OBJECTS)

shice$(EXEEXT): req_dirs $(SHICE_OBJECTS)
	${FCCOMPILE} -o ${E}/shice$(EXEEXT) $(SHICE_OBJECTS)

shrsl$(EXEEXT): req_dirs $(SHRSL_OBJECTS)
	${FCCOMPILE} -o ${E}/shrsl$(EXEEXT) $(SHRSL_OBJECTS)

shrslc$(EXEEXT): req_dirs $(SHRSLC_OBJECTS)
	${FCCOMPILE} -o ${E}/shrslc$(EXEEXT) $(SHRSLC_OBJECTS)

shtgauges$(EXEEXT): req_dirs $(SHTGAUGES_OBJECTS)
	${FCCOMPILE} -o ${E}/shtgauges$(EXEEXT) $(SHTGAUGES_OBJECTS)

sle$(EXEEXT): req_dirs $(SLE_OBJECTS)
	${FCCOMPILE} -o ${E}/sle$(EXEEXT) $(SLE_OBJECTS)

stokes$(EXEEXT): req_dirs $(STOKES_OBJECTS)
	${FCCOMPILE} -o ${E}/stokes$(EXEEXT) $(STOKES_OBJECTS)

tb$(EXEEXT): req_dirs $(TB_OBJECTS)
	${FCCOMPILE} -o ${E}/tb$(EXEEXT) $(TB_OBJECTS)

tgauges$(EXEEXT): req_dirs $(TGAUGES_OBJECTS)
	${FCCOMPILE} -o ${E}/tgauges$(EXEEXT) $(TGAUGES_OBJECTS)

wnw$(EXEEXT): req_dirs $(WNW_OBJECTS)
	${FCCOMPILE} -o ${E}/wnw$(EXEEXT) $(WNW_OBJECTS)

clean:
	rm -rf ${E} ${O} ${SETUP}

#######################################
# Rule for creating the data.inc header file
#######################################

${SETUP}/data.inc: config$(EXEEXT) config.dat
	(cp config.dat tmp && cd tmp && ../${E}/config$(EXEEXT) && chmod u+x selen.sh && cd ..)

#######################################
# rules for object files
#######################################

$O/config.o: $S/harmonics.f90 $S/config.f90 $S/shtools.f90
	${FCCOMPILE} -c -o $O/config.o $S/config.f90

$O/esl.o: ${SETUP}/data.inc $S/harmonics.f90 $S/esl.f90
	${FCCOMPILE} -c -o $O/esl.o $S/esl.f90

$O/geo.o: ${SETUP}/data.inc $S/harmonics.f90 $S/geo.f90
	${FCCOMPILE} -c -o $O/geo.o $S/geo.f90

$O/gmaps.o: ${SETUP}/data.inc $S/harmonics.f90 $S/gmaps.f90
	${FCCOMPILE} -c -o $O/gmaps.o $S/gmaps.f90

$O/harmonics.o: $S/harmonics.f90
	${FCCOMPILE} -c -o $O/harmonics.o $S/harmonics.f90

$O/ms.o: ${SETUP}/data.inc $S/harmonics.f90 $S/ms.f90
	${FCCOMPILE} -c -o $O/ms.o $S/ms.f90

$O/of_dv.o: ${SETUP}/data.inc $S/harmonics.f90 $S/of_dv.f90
	${FCCOMPILE} -c -o $O/of_dv.o $S/of_dv.f90

$O/px.o: ${SETUP}/data.inc $S/harmonics.f90 $S/px.f90
	${FCCOMPILE} -c -o $O/px.o $S/px.f90

$O/px_rebuild.o: ${SETUP}/data.inc $S/px_rebuild.f90
	${FCCOMPILE} -c -o $O/px_rebuild.o $S/px_rebuild.f90

$O/px_rec.o: ${SETUP}/data.inc $S/px_rec.f90
	${FCCOMPILE} -c -o $O/px_rec.o $S/px_rec.f90

$O/rec_ice.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rec_ice.f90
	${FCCOMPILE} -c -o $O/rec_ice.o $S/rec_ice.f90

$O/rec_of.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rec_of.f90
	${FCCOMPILE} -c -o $O/rec_of.o $S/rec_of.f90

$O/rmaps.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rmaps.f90
	${FCCOMPILE} -c -o $O/rmaps.o $S/rmaps.f90

$O/rsl.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rsl.f90
	${FCCOMPILE} -c -o $O/rsl.o $S/rsl.f90

$O/rsl_zones.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rsl_zones.f90
	${FCCOMPILE} -c -o $O/rsl_zones.o $S/rsl_zones.f90

$O/rslc.o: ${SETUP}/data.inc $S/harmonics.f90 $S/rslc.f90
	${FCCOMPILE} -c -o $O/rslc.o $S/rslc.f90

$O/sh.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sh.f90
	${FCCOMPILE} -c -o $O/sh.o $S/sh.f90

$O/sh_of.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sh_of.f90
	${FCCOMPILE} -c -o $O/sh_of.o $S/sh_of.f90

$O/sh_rsl.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sh_rsl.f90
	${FCCOMPILE} -c -o $O/sh_rsl.o $S/sh_rsl.f90

$O/sh_rslc.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sh_rslc.f90
	${FCCOMPILE} -c -o $O/sh_rslc.o $S/sh_rslc.f90

$O/sh_tgauges.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sh_tgauges.f90
	${FCCOMPILE} -c -o $O/sh_tgauges.o $S/sh_tgauges.f90

$O/shape_factors.o: ${SETUP}/data.inc $S/harmonics.f90 $S/shape_factors.f90
	${FCCOMPILE} -c -o $O/shape_factors.o $S/shape_factors.f90

$O/shice.o: ${SETUP}/data.inc $S/harmonics.f90 $S/shice.f90
	${FCCOMPILE} -c -o $O/shice.o $S/shice.f90

$O/shtools.o: $S/harmonics.f90 $S/shtools.f90
	${FCCOMPILE} -c -o $O/shtools.o $S/shtools.f90

$O/sle.o: ${SETUP}/data.inc $S/harmonics.f90 $S/sle.f90
	${FCCOMPILE} -c -o $O/sle.o $S/sle.f90

$O/stokes.o: ${SETUP}/data.inc $S/harmonics.f90 $S/stokes.f90
	${FCCOMPILE} -c -o $O/stokes.o $S/stokes.f90

$O/tb.o: ${SETUP}/data.inc $S/harmonics.f90 $S/tb.F90
	${FCCOMPILE} -c -o $O/tb.o $S/tb.F90

$O/tgauges.o: ${SETUP}/data.inc $S/harmonics.f90 $S/tgauges.f90
	${FCCOMPILE} -c -o $O/tgauges.o $S/tgauges.f90

$O/wnw.o: ${SETUP}/data.inc $S/harmonics.f90 $S/wnw.f90
	${FCCOMPILE} -c -o $O/wnw.o $S/wnw.f90

