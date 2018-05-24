<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="client">
   <sch:let name="client-ids"
            value="('peri22-dataelement-10030', 'peri22-dataelement-10031', 'peri22-dataelement-82360', 'peri22-dataelement-10042', 'peri22-dataelement-82359', 'peri22-dataelement-82363', 'peri22-dataelement-10043', 'peri22x-vrouw-volledige_achternaam', 'peri22-dataelement-10040', 'peri22x-vrouw-geboorteland', 'peri22x-burgelijke_staat', 'peri22-dataelement-10400', 'peri22-dataelement-10401', 'peri22-dataelement-82371', 'peri22-dataelement-82154', 'peri22-dataelement-82155', 'peri22x-memo-client', 'peri22-dataelement-10301', 'peri22-dataelement-10302', 'peri22-dataelement-10303', 'peri22-dataelement-10304', 'peri22-dataelement-10305', 'peri22-dataelement-10306', 'peri22-dataelement-10307', 'peri22-dataelement-10308', 'peri22-dataelement-80639', 'peri22-dataelement-80640', 'peri22-dataelement-80641', 'peri22-dataelement-80636', 'peri22-dataelement-82027', 'peri22-dataelement-82028', 'peri22-dataelement-82029', 'peri22-dataelement-82030', 'peri22-dataelement-82031', 'peri22-dataelement-82039', 'peri22-dataelement-82032', 'peri22-dataelement-82033', 'peri22-dataelement-82038', 'peri22-dataelement-82036', 'peri22-dataelement-82037')"/>
   <sch:rule context="section[@type='client']//value">
      <sch:assert test="@concept=$client-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section client.</sch:assert>
   </sch:rule>
</sch:pattern>
