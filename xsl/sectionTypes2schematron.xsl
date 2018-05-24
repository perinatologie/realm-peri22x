<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="sectionType">
        <sch:pattern id="{@id}">
            <xsl:variable name="ids" select="concat('(''', string-join(.//@concept/string(), ''', '''), ''')')"/>
            <sch:let name="{@id}-ids" value="{$ids}"></sch:let>
            <sch:rule context="section[@type='{@id}']//value">
                <sch:assert test="@concept=${@id}-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section <xsl:value-of select="@id"/>.</sch:assert>
            </sch:rule>
        </sch:pattern>
    </xsl:template>
</xsl:stylesheet>