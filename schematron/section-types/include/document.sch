<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="document">
   <sch:let name="document-ids"
            value="('peri22x-document-naam', 'peri22x-document-link')"/>
   <sch:rule context="section[@type='document']//value">
      <sch:assert test="@concept=$document-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section document.</sch:assert>
   </sch:rule>
</sch:pattern>
