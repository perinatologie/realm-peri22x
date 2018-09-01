#!/bin/bash

xsltproc realm2schematron.xslt ../../dist/peri22x.xml  > peri22x.sch
xsltproc iso_dsdl_include.xsl peri22x.sch > step1.xsl
xsltproc iso_abstract_expand.xsl step1.xsl > step2.xsl
xsltproc iso_svrl_for_xslt1.xsl step2.xsl > ../../xsl/peri22x-schematron.xsl
