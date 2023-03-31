# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = DocRegExt

IVOA_GROUP=registry

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.0

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2023-03-29

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = WD

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex role_diagram.pdf

# List of pixel image files to be included in submitted package
FIGURES = curation.png role_diagram.svg

# List of PDF figures (for vector graphics)
VECTORFIGURES =

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES = m1distance-example.xml DocRegExt-1.0.xsd

.PHONY: m1distance-example.xml
m1distance-example.xml:
	# only in case there's nice new features in there in the future
	curl -s "http://localhost:8080/oai.xml?verb=GetRecord&metadataPrefix=ivo_vor&identifier=ivo://edu.euro-vo.org/tutorials/08_m1_distance" \
		| xmlstarlet sel --indent -N ri=http://www.ivoa.net/xml/RegistryInterface/v1.0 -t -c //ri:Resource \
		| xmlstarlet fo -o -s 2 | grep -v "?xml-stylesheet" > $@

AUTHOR_EMAIL=msdemlei@ari.uni-heidelberg.de

-include ivoatex/Makefile

ivoatex/Makefile:
	@echo "*** ivoatex submodule not found.  Initialising submodules."
	@echo
	git submodule update --init

STILTS ?= stilts
SCHEMA_FILE=DocRegExt-v1.0.xsd

test:
	@$(STILTS) xsdvalidate $(SCHEMA_FILE)
	@$(STILTS) xsdvalidate \
		schemaloc="http://www.ivoa.net/xml/DocRegExt/v1=$(SCHEMA_FILE)" \
		m1distance-example.xml


install-schema:
	scp DocRegExt-1.0.xsd alnilam:/var/www/docs/xml/
