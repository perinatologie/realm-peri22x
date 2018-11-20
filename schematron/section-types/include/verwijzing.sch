<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="verwijzing">
   <sch:let name="verwijzing-ids"
            value="('peri22-dataelement-82013', 'peri22-dataelement-82017', 'peri22-dataelement-82018', 'peri22-dataelement-82015', 'peri22-dataelement-82016', 'peri22-dataelement-20312', 'peri22-dataelement-20314', 'peri22-dataelement-20311', 'peri22-dataelement-20320', 'peri22-dataelement-82164', 'peri22-dataelement-20331', 'peri22-dataelement-20360', 'peri22-dataelement-20362', 'peri22-dataelement-20366', 'peri22-dataelement-20369', 'peri22-dataelement-20368', 'peri22-dataelement-20367', 'peri22-dataelement-20633', 'peri22-dataelement-80614', 'peri22-dataelement-80615', 'peri22-dataelement-20371', 'peri22-dataelement-20372', 'peri22-dataelement-20373', 'peri22-dataelement-20390', 'peri22-dataelement-10801', 'peri22-dataelement-10808', 'peri22-dataelement-10809', 'peri22-dataelement-20070')"/>
   <sch:rule context="section[@type='verwijzing']//value">
      <sch:assert test="@concept=$verwijzing-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section verwijzing.</sch:assert>
   </sch:rule>
</sch:pattern>
