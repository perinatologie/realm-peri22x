<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="counseling">
   <sch:let name="counseling-ids"
            value="('peri22-dataelement-20120', 'peri22-dataelement-82088', 'peri22-dataelement-20455', 'peri22-dataelement-20480', 'peri22-dataelement-20485', 'peri22-dataelement-82163', 'peri22-dataelement-20490', 'peri22-dataelement-20495')"/>
   <sch:rule context="section[@type='counseling']//value">
      <sch:assert test="@concept=$counseling-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section counseling.</sch:assert>
   </sch:rule>
</sch:pattern>
