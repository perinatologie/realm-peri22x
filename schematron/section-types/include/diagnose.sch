<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="diagnose">
   <sch:let name="diagnose-ids"
            value="('peri22-dataelement-82270', 'peri22-dataelement-82273', 'peri22-dataelement-82274', 'peri22-dataelement-82275', 'peri22-dataelement-82277', 'peri22-dataelement-82289')"/>
   <sch:rule context="section[@type='diagnose']//value">
      <sch:assert test="@concept=$diagnose-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section diagnose.</sch:assert>
   </sch:rule>
</sch:pattern>
