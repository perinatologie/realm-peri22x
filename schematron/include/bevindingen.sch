<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="bevindingen">
   <sch:let name="bevindingen-ids"
            value="('peri22-dataelement-82242', 'peri22-dataelement-82243', 'peri22-dataelement-82244', 'peri22-dataelement-82245', 'peri22-dataelement-82246', 'peri22-dataelement-82247', 'peri22-dataelement-82248', 'peri22-dataelement-82249', 'peri22-dataelement-82253', 'peri22-dataelement-82254', 'peri22-dataelement-82255', 'peri22-dataelement-82239', 'peri22-dataelement-82258', 'peri22-dataelement-82259', 'peri22-dataelement-82260', 'peri22-dataelement-82261', 'peri22-dataelement-82262', 'peri22-dataelement-82263', 'peri22-dataelement-82264', 'peri22-dataelement-60060', 'peri22-dataelement-60070', 'peri22-dataelement-60080', 'peri22-dataelement-60100', 'peri22-dataelement-60030')"/>
   <sch:rule context="section[@type='bevindingen']//value">
      <sch:assert test="@concept=$bevindingen-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section bevindingen.</sch:assert>
   </sch:rule>
</sch:pattern>
