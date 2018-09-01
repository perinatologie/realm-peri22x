<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="kraambed">
   <sch:let name="kraambed-ids"
            value="('peri22-dataelement-82298', 'peri22-dataelement-82208', 'peri22-dataelement-82209', 'peri22-dataelement-80843', 'peri22-dataelement-82084', 'peri22-dataelement-82085', 'peri22-dataelement-82124', 'peri22-dataelement-80982', 'peri22-dataelement-70011', 'peri22-dataelement-70030', 'peri22-dataelement-82118', 'peri22-dataelement-40250', 'peri22-dataelement-40260', 'peri22-dataelement-40261', 'peri22-dataelement-80765', 'peri22-dataelement-80983', 'peri22-dataelement-80642')"/>
   <sch:rule context="section[@type='kraambed']//value">
      <sch:assert test="@concept=$kraambed-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section kraambed.</sch:assert>
   </sch:rule>
</sch:pattern>
