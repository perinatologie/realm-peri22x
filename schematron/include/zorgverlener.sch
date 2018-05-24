<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="zorgverlener">
   <sch:let name="zorgverlener-ids" value="('peri22-dataelement-10003')"/>
   <sch:rule context="section[@type='zorgverlener']//value">
      <sch:assert test="@concept=$zorgverlener-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section zorgverlener.</sch:assert>
   </sch:rule>
</sch:pattern>
