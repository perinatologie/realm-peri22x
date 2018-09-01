<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs" version="1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="realm">
        <schema>
            <pattern>
                <rule context="value">
                    <xsl:text disable-output-escaping="yes">&lt;report test="</xsl:text>
                    <xsl:for-each select="concept">
                        <xsl:text disable-output-escaping="yes">not(@concept='</xsl:text>
                        <xsl:value-of select="@id"/>
                        <xsl:text disable-output-escaping="yes">')</xsl:text>
                        <xsl:if test="count(following-sibling::concept)!=0">
                            <xsl:text disable-output-escaping="yes"> and </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
                    <xsl:text disable-output-escaping="yes">unknown concept used 
                        (&lt;value-of select="@concept"/&gt;) used in section "&lt;value-of select="../../@type"/&gt;"
                        (id: &lt;value-of select="../../@id"/&gt;)&lt;/report&gt;</xsl:text>
                </rule>
            </pattern>
        </schema>
    </xsl:template>
</xsl:stylesheet>
