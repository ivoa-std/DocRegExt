# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = DocRegExt

IVOA_GROUP=registry

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.0

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2025-11-02

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = PR

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex role_diagram.pdf

# List of pixel image files to be included in submitted package
FIGURES = role_diagram.svg

# List of PDF figures (for vector graphics)
VECTORFIGURES =

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES = m1distance-example.xml DocRegExt-v1.0.xsd


AUTHOR_EMAIL=msdemlei@ari.uni-heidelberg.de

-include ivoatex/Makefile

ivoatex/Makefile:
	@echo "*** ivoatex submodule not found.  Initialising submodules."
	@echo
	git submodule update --init

STILTS ?= stilts
SCHEMA_FILE=DocRegExt-v1.0.xsd

# The example targets are only relevant in case we add features in the
# future and want to re-make the example records.
.PHONY: m1distance-example.xml dfbs-example.xml
m1distance-example.xml:
	curl -s "http://dc.g-vo.org/oai.xml?verb=GetRecord&metadataPrefix=ivo_vor&identifier=ivo://edu.euro-vo.org/tutorials/08_m1_distance" \
		| xmlstarlet sel --indent -N ri=http://www.ivoa.net/xml/RegistryInterface/v1.0 -t -c //ri:Resource \
		| xmlstarlet fo -o -s 2 | grep -v "?xml-stylesheet" > $@

dfbs-example.xml:
	curl -s "http://dc.g-vo.org/oai.xml?verb=GetRecord&metadataPrefix=ivo_vor&identifier=ivo://edu.gavo.org/hd/arvo_dfbs" \
		| xmlstarlet sel --indent -N ri=http://www.ivoa.net/xml/RegistryInterface/v1.0 -t -c //ri:Resource \
		| xmlstarlet fo -o -s 2 | grep -v "?xml-stylesheet" > $@


test:
	@$(STILTS) xsdvalidate $(SCHEMA_FILE)
	@$(STILTS) xsdvalidate \
		schemaloc="http://www.ivoa.net/xml/DocRegExt/v1=$(SCHEMA_FILE)" \
		m1distance-example.xml
	@$(STILTS) xsdvalidate \
		schemaloc="http://www.ivoa.net/xml/DocRegExt/v1=$(SCHEMA_FILE)" \
		dfbs-example.xml

install-schema:
	scp DocRegExt-1.0.xsd alnilam:/var/www/docs/xml/
