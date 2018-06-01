<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:include href="include/anamnese.sch"/>
    <sch:include href="include/anamneseAlgemeen.sch"/>
    <sch:include href="include/baring.sch"/>
    <sch:include href="include/bevindingen.sch"/>
    <sch:include href="include/client.sch"/>
    <sch:include href="include/consult.sch"/>
    <sch:include href="include/counseling.sch"/>
    <sch:include href="include/diagnose.sch"/>
    <sch:include href="include/document.sch"/>
    <sch:include href="include/echo.sch"/>
    <sch:include href="include/intake.sch"/>
    <sch:include href="include/kind.sch"/>
    <sch:include href="include/kraambed.sch"/>
    <sch:include href="include/onderzoek.sch"/>
    <sch:include href="include/verwijzing.sch"/>
    <sch:include href="include/zorgverlener.sch"/>
    <sch:include href="include/zwangerschap.sch"/>

    <sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="repeatables">
        <sch:let name="kindconcepten"
            value="('peri22-dataelement-40003', 'peri22-dataelement-40005', 'peri22-dataelement-82116', 'peri22-dataelement-82117', 'peri22-dataelement-40010', 'peri22-dataelement-40011', 
            'peri22-dataelement-40015', 'peri22-dataelement-82353', 'peri22-dataelement-82354', 'peri22-dataelement-82052', 'peri22-dataelement-82054', 'peri22-dataelement-82055', 
            'peri22-dataelement-82366', 'peri22-dataelement-82367', 'peri22-dataelement-82133', 'peri22-dataelement-82134', 'peri22-dataelement-82135', 'peri22-dataelement-82136', 
            'peri22-dataelement-82137', 'peri22-dataelement-82138', 'peri22-dataelement-82139', 'peri22-dataelement-82141', 'peri22-dataelement-82142', 'peri22-dataelement-40034', 
            'peri22-dataelement-40040', 'peri22-dataelement-40041', 'peri22-dataelement-40050', 'peri22-dataelement-80629', 'peri22-dataelement-80630', 'peri22-dataelement-80631', 
            'peri22-dataelement-80632', 'peri22-dataelement-40023', 'peri22-dataelement-82087', 'peri22-dataelement-40025', 'peri22-dataelement-40280', 'peri22-dataelement-40290', 
            'peri22-dataelement-40300', 'peri22-dataelement-40027', 'peri22-dataelement-40028', 'peri22-dataelement-20580', 'peri22-dataelement-20585', 'peri22-dataelement-80619', 
            'peri22-dataelement-20610', 'peri22-dataelement-30030', 'peri22-dataelement-30040', 'peri22-dataelement-30050', 'peri22-dataelement-80794', 'peri22-dataelement-30055', 
            'peri22-dataelement-82089', 'peri22-dataelement-82090', 'peri22-dataelement-82394', 'peri22-dataelement-82092', 'peri22-dataelement-82095', 'peri22-dataelement-82096', 
            'peri22-dataelement-82097', 'peri22-dataelement-82098', 'peri22-dataelement-30060', 'peri22-dataelement-80827', 'peri22-dataelement-82395', 'peri22-dataelement-82100', 
            'peri22-dataelement-82101', 'peri22-dataelement-80626', 'peri22-dataelement-82397', 'peri22-dataelement-20062', 'peri22-dataelement-40020', 'peri22-dataelement-40070', 
            'peri22-dataelement-40071', 'peri22-dataelement-80757', 'peri22-dataelement-40140', 'peri22-dataelement-82058', 'peri22-dataelement-40150', 'peri22-dataelement-40160', 
            'peri22-dataelement-82059', 'peri22-dataelement-40170', 'peri22-dataelement-40180', 'peri22-dataelement-40190', 'peri22-dataelement-40200', 'peri22-dataelement-40210', 
            'peri22-dataelement-40220', 'peri22-dataelement-40225', 'peri22-dataelement-40230', 'peri22-dataelement-40240', 'peri22-dataelement-82206', 'peri22-dataelement-82169', 
            'peri22-dataelement-82170', 'peri22-dataelement-82171', 'peri22-dataelement-82173', 'peri22-dataelement-80769', 'peri22-dataelement-80768', 'peri22-dataelement-80771', 
            'peri22-dataelement-80772', 'peri22-dataelement-80773', 'peri22-dataelement-80774', 'peri22-dataelement-80775', 'peri22-dataelement-80776', 'peri22-dataelement-80777', 
            'peri22-dataelement-80784', 'peri22-dataelement-82177', 'peri22-dataelement-82178', 'peri22-dataelement-82179', 'peri22-dataelement-80786', 'peri22-dataelement-82180', 
            'peri22-dataelement-82181', 'peri22-dataelement-82182', 'peri22-dataelement-82183', 'peri22-dataelement-82184', 'peri22-dataelement-82225', 'peri22-dataelement-82185', 
            'peri22-dataelement-82186', 'peri22-dataelement-82187', 'peri22-dataelement-82188', 'peri22-dataelement-82189', 'peri22-dataelement-82190', 'peri22-dataelement-82191', 
            'peri22-dataelement-82192', 'peri22-dataelement-82226', 'peri22-dataelement-82193', 'peri22-dataelement-82194', 'peri22-dataelement-82195', 'peri22-dataelement-82196', 
            'peri22-dataelement-82198', 'peri22-dataelement-82199', 'peri22-dataelement-82200', 'peri22-dataelement-82202', 'peri22-dataelement-82203', 'peri22-dataelement-82204', 
            'peri22-dataelement-40060', 'peri22-dataelement-80670', 'peri22-dataelement-80759', 'peri22-dataelement-80787', 'peri22-dataelement-80760', 'peri22-dataelement-82205', 
            'peri22-dataelement-80762', 'peri22-dataelement-82386', 'peri22-dataelement-82387', 'peri22-dataelement-80788', 'peri22-dataelement-40080', 'peri22-dataelement-40090', 
            'peri22-dataelement-40100', 'peri22-dataelement-40110', 'peri22-dataelement-40120', 'peri22-dataelement-40130', 'peri22-dataelement-82334', 'peri22-dataelement-80789', 
            'peri22-dataelement-80793', 'peri22-dataelement-80761', 'peri22-dataelement-82368', 'peri22-dataelement-82370', 'peri22-dataelement-82119', 'peri22-dataelement-82122', 
            'peri22-dataelement-82123', 'peri22-dataelement-82121', 'peri22-dataelement-82335', 'peri22-dataelement-80790', 'peri22-dataelement-80980', 'peri22-dataelement-23010', 
            'peri22-dataelement-23020', 'peri22-dataelement-23030', 'peri22-dataelement-23040', 'peri22-dataelement-23050', 'peri22-dataelement-23070', 'peri22-dataelement-70011', 
            'peri22-dataelement-70030', 'peri22-dataelement-82118', 'peri22-dataelement-40250', 'peri22-dataelement-40260', 'peri22-dataelement-40261', 'peri22-dataelement-80765',
            'peri22-dataelement-80710', 'peri22-dataelement-82113', 'peri22-dataelement-82043', 'peri22-dataelement-82044', 'peri22-dataelement-82128', 'peri22-dataelement-82355', 
            'peri22-dataelement-82352', 'peri22-dataelement-82358', 'peri22-dataelement-82129', 'peri22-dataelement-80712', 'peri22-dataelement-80702', 'peri22-dataelement-80705', 
            'peri22-dataelement-80706', 'peri22-dataelement-80989', 'peri22-dataelement-80990', 'peri22-dataelement-80624', 'peri22-dataelement-82341', 'peri22-dataelement-10604', 
            'peri22-dataelement-10605', 'peri22-dataelement-10606', 'peri22-dataelement-10607', 'peri22-dataelement-82046', 'peri22-dataelement-82047', 'peri22-dataelement-82215', 
            'peri22-dataelement-80997', 'peri22-dataelement-81000', 'peri22-dataelement-81002', 'peri22-dataelement-81004', 'peri22-dataelement-80717'
            )"/>
        <sch:rule context="section//value[@concept=$kindconcepten]">
            <sch:assert test="@repeat" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) moet repeat (kindnummer) attribute hebben.</sch:assert>
        </sch:rule>
        <sch:rule context="section//value[not(@concept=$kindconcepten)]">
            <sch:assert test="not(@repeat)" role="error">Id <sch:value-of select="@concept"/> (<sch:value-of select="@label/string()"/>) mag geen repeat (kindnummer) attribute hebben.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>