<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="consult">
   <sch:let name="consult-ids"
            value="('peri22-dataelement-80737', 'peri22-dataelement-80738', 'peri22-dataelement-80748', 'peri22-dataelement-82067', 'peri22-dataelement-80736', 'peri22-dataelement-80836', 'peri22-dataelement-80833', 'peri22-dataelement-80834', 'peri22-dataelement-20211', 'peri22-dataelement-80746', 'peri22-dataelement-80742', 'peri22-dataelement-80741', 'peri22-dataelement-80945', 'peri22-dataelement-10814', 'peri22-dataelement-80951', 'peri22-dataelement-80836', 'peri22-dataelement-80622', 'peri22-dataelement-80744', 'peri22-dataelement-82106', 'peri22-dataelement-82107', 'peri22-dataelement-80745')"/>
   <sch:rule context="section[@type='consult']//value">
      <sch:assert test="@concept=$consult-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section consult.</sch:assert>
   </sch:rule>
</sch:pattern>
