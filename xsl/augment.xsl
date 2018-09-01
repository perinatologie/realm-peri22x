<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="no"/>
  <xsl:param name="realm_filename" select="'realm.xml'"/>
  <xsl:variable name="realm_doc" select="document($realm_filename)"/>
  <xsl:param name="lang"/>
  <xsl:template match="value">
    <value>
      <xsl:copy-of select="@concept"/>
      <xsl:variable name="con" select="@concept"/>
      <xsl:variable name="value" select="@value"/>
      <xsl:if test="count($realm_doc//concept[@id=$con])!=0">
        <xsl:attribute name="dataType">
          <xsl:value-of select="$realm_doc//concept[@id=$con]/@dataType"/>
        </xsl:attribute>
        <xsl:attribute name="shortName">
          <xsl:value-of select="$realm_doc//concept[@id=$con]/@shortName"/>
        </xsl:attribute>
        <xsl:attribute name="label">
          <xsl:value-of select="$realm_doc//concept[@id=$con]/property[@name='name'][@language=$lang]"/>
        </xsl:attribute>
        <xsl:attribute name="value">
          <xsl:value-of select="$value"/>
        </xsl:attribute>
        <xsl:attribute name="conceptId">
          <xsl:value-of select="$realm_doc//concept[@id=$con]/@oid"/>
        </xsl:attribute>
        <xsl:if test="$realm_doc//concept[@id=$con]/@dataType = 'code'">
          <xsl:variable name="codelist" select="$realm_doc//concept[@id=$con]/@codelist"/>
          <xsl:attribute name="code">
            <xsl:value-of select="$realm_doc//codelist[@id=$codelist]/item[1]/@code"/>
          </xsl:attribute>
          <xsl:attribute name="codeSystem">
            <xsl:value-of select="$realm_doc//codelist[@id=$codelist]/item[1]/@codeSystem"/>
          </xsl:attribute>
          <xsl:attribute name="displayName">
            <xsl:value-of select="$realm_doc//codelist[@id=$codelist]/item/property[@language=$lang]"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:if>
    </value>
  </xsl:template>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
