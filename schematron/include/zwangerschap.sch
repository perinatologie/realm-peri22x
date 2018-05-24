<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="zwangerschap">
   <sch:let name="zwangerschap-ids"
            value="('peri22-dataelement-80983', 'peri22-dataelement-80642', 'peri22-dataelement-70030', 'peri22-dataelement-82208', 'peri22-dataelement-82209', 'peri22-dataelement-20091', 'peri22-dataelement-20095', 'peri22-dataelement-20080', 'peri22-dataelement-82160', 'peri22-dataelement-20220', 'peri22-dataelement-82230', 'peri22-dataelement-80625')"/>
   <sch:rule context="section[@type='zwangerschap']//value">
      <sch:assert test="@concept=$zwangerschap-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section zwangerschap.</sch:assert>
   </sch:rule>
</sch:pattern>
