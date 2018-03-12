# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = edumatters

IVOA_GROUP=Education

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.0

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2018-03-12

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = NOTE

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex m1distance-example.xml

# List of pixel image files to be included in submitted package 
FIGURES = curation.png

# List of PDF figures (for vector graphics)
VECTORFIGURES = 

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES = 

AUTHOR_EMAIL=msdemlei@ari.uni-heidelberg.de

include ivoatex/Makefile

install-schema:
	scp DocRegExt-1.xsd alnilam:/var/www/docs/xml/
