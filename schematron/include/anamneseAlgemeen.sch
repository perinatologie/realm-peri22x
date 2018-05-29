<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="anamneseAlgemeen">
   <sch:let name="anamneseAlgemeen-ids"
            value="('peri22-dataelement-82020', 'peri22-dataelement-80905', 'peri22-dataelement-82220', 'peri22-dataelement-82216', 'peri22-dataelement-80906', 'peri22-dataelement-80907', 'peri22-dataelement-82267', 'peri22-dataelement-80908', 'peri22-dataelement-82221', 'peri22-dataelement-82217', 'peri22-dataelement-80909', 'peri22-dataelement-80910', 'peri22-dataelement-82218', 'peri22-dataelement-80912', 'peri22-dataelement-80913', 'peri22-dataelement-82210', 'peri22-dataelement-80914', 'peri22-dataelement-82219', 'peri22-dataelement-80915', 'peri22-dataelement-82222', 'peri22-dataelement-80916', 'peri22-dataelement-82266', 'peri22-dataelement-82211', 'peri22-dataelement-80917', 'peri22-dataelement-82213', 'peri22-dataelement-80918', 'peri22-dataelement-10805', 'peri22-dataelement-82231', 'peri22-dataelement-80939', 'peri22-dataelement-80818', 'peri22-dataelement-80940', 'peri22-dataelement-80817', 'peri22-dataelement-82159', 'peri22-dataelement-82332', 'peri22-dataelement-82212', 'peri22-dataelement-80919', 'peri22-dataelement-82158', 'peri22-dataelement-80681', 'peri22-dataelement-10803', 'peri22-dataelement-80680', 'peri22-dataelement-82333', 'peri22-dataelement-10800', 'peri22-dataelement-10801', 'peri22-dataelement-10802', 'peri22-dataelement-80751', 'peri22-dataelement-80752', 'peri22-dataelement-80750', 'peri22-dataelement-80753', 'peri22-dataelement-80729', 'peri22-dataelement-80730', 'peri22-dataelement-80937', 'peri22-dataelement-80938', 'peri22-dataelement-82339', 'peri22-dataelement-80639', 'peri22-dataelement-80640', 'peri22-dataelement-80641', 'peri22-dataelement-80636')"/>
   <sch:rule context="section[@type='anamneseAlgemeen']//value">
      <sch:assert test="@concept=$anamneseAlgemeen-ids" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) is niet toegestaan in section anamneseAlgemeen.</sch:assert>
   </sch:rule>
</sch:pattern>