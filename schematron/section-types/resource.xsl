<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


   <!--PROLOG-->
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


   <!--KEYS AND FUNCTIONS-->


   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">anamnese</xsl:attribute>
            <xsl:attribute name="name">anamnese</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M0"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">anamneseAlgemeen</xsl:attribute>
            <xsl:attribute name="name">anamneseAlgemeen</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M1"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">baring</xsl:attribute>
            <xsl:attribute name="name">baring</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M2"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">bevindingen</xsl:attribute>
            <xsl:attribute name="name">bevindingen</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">client</xsl:attribute>
            <xsl:attribute name="name">client</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M4"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">consult</xsl:attribute>
            <xsl:attribute name="name">consult</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">counseling</xsl:attribute>
            <xsl:attribute name="name">counseling</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">diagnose</xsl:attribute>
            <xsl:attribute name="name">diagnose</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">document</xsl:attribute>
            <xsl:attribute name="name">document</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">echo</xsl:attribute>
            <xsl:attribute name="name">echo</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">intake</xsl:attribute>
            <xsl:attribute name="name">intake</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">kind</xsl:attribute>
            <xsl:attribute name="name">kind</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">kraambed</xsl:attribute>
            <xsl:attribute name="name">kraambed</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">onderzoek</xsl:attribute>
            <xsl:attribute name="name">onderzoek</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">verwijzing</xsl:attribute>
            <xsl:attribute name="name">verwijzing</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">zorgverlener</xsl:attribute>
            <xsl:attribute name="name">zorgverlener</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">zwangerschap</xsl:attribute>
            <xsl:attribute name="name">zwangerschap</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


   <!--PATTERN anamnese-->
   <xsl:variable name="anamnese-ids"
                 select="('peri22-dataelement-10590', 'peri22-dataelement-80623', 'peri22-dataelement-82001', 'peri22-dataelement-82002', 'peri22-dataelement-82040', 'peri22-dataelement-82041', 'peri22-dataelement-82214', 'peri22-dataelement-82004', 'peri22-dataelement-82005', 'peri22-dataelement-82337', 'peri22-dataelement-82315', 'peri22-dataelement-82316', 'peri22-dataelement-82317', 'peri22-dataelement-82318', 'peri22-dataelement-82319', 'peri22-dataelement-82320', 'peri22-dataelement-82321', 'peri22-dataelement-82322', 'peri22-dataelement-82323', 'peri22-dataelement-82324', 'peri22-dataelement-82325', 'peri22-dataelement-82326', 'peri22-dataelement-82327', 'peri22-dataelement-82328', 'peri22-dataelement-82329', 'peri22-dataelement-80708', 'peri22-dataelement-80837', 'peri22-dataelement-80838', 'peri22-dataelement-82336', 'peri22-dataelement-10598', 'peri22-dataelement-10601', 'peri22-dataelement-10602', 'peri22-dataelement-80674', 'peri22-dataelement-80710', 'peri22-dataelement-82113', 'peri22-dataelement-82043', 'peri22-dataelement-82044', 'peri22-dataelement-82352', 'peri22-dataelement-82128', 'peri22-dataelement-82129', 'peri22-dataelement-80712', 'peri22-dataelement-80702', 'peri22-dataelement-80705', 'peri22-dataelement-80706', 'peri22-dataelement-80989', 'peri22-dataelement-80990', 'peri22-dataelement-80624', 'peri22-dataelement-82341', 'peri22-dataelement-10604', 'peri22-dataelement-10605', 'peri22-dataelement-10606', 'peri22-dataelement-10607', 'peri22-dataelement-82046', 'peri22-dataelement-82047', 'peri22-dataelement-82215', 'peri22-dataelement-80997', 'peri22-dataelement-81000', 'peri22-dataelement-81002', 'peri22-dataelement-81004', 'peri22-dataelement-80717', 'peri22-dataelement-80678', 'peri22-dataelement-80617', 'peri22-dataelement-40020')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='anamnese']//value" priority="1000" mode="M0">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='anamnese']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$anamnese-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$anamnese-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section anamnese.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M0"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M0"/>
   <xsl:template match="@*|node()" priority="-2" mode="M0">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M0"/>
   </xsl:template>

   <!--PATTERN anamneseAlgemeen-->
   <xsl:variable name="anamneseAlgemeen-ids"
                 select="('peri22-dataelement-82020', 'peri22-dataelement-80905', 'peri22-dataelement-82220', 'peri22-dataelement-82216', 'peri22-dataelement-80906', 'peri22-dataelement-80907', 'peri22-dataelement-82267', 'peri22-dataelement-80908', 'peri22-dataelement-82221', 'peri22-dataelement-82217', 'peri22-dataelement-80909', 'peri22-dataelement-80910', 'peri22-dataelement-82218', 'peri22-dataelement-80912', 'peri22-dataelement-80913', 'peri22-dataelement-82210', 'peri22-dataelement-80914', 'peri22-dataelement-82219', 'peri22-dataelement-80915', 'peri22-dataelement-82222', 'peri22-dataelement-80916', 'peri22-dataelement-82266', 'peri22-dataelement-82211', 'peri22-dataelement-80917', 'peri22-dataelement-82213', 'peri22-dataelement-80918', 'peri22-dataelement-10805', 'peri22-dataelement-82231', 'peri22-dataelement-80939', 'peri22-dataelement-80818', 'peri22-dataelement-80940', 'peri22-dataelement-80817', 'peri22-dataelement-82159', 'peri22-dataelement-82332', 'peri22-dataelement-82212', 'peri22-dataelement-80919', 'peri22-dataelement-82158', 'peri22-dataelement-80681', 'peri22-dataelement-10803', 'peri22-dataelement-80680', 'peri22-dataelement-82333', 'peri22-dataelement-10800', 'peri22-dataelement-10801', 'peri22-dataelement-10802', 'peri22-dataelement-80751', 'peri22-dataelement-80752', 'peri22-dataelement-80750', 'peri22-dataelement-80753', 'peri22-dataelement-80729', 'peri22-dataelement-80730', 'peri22-dataelement-80937', 'peri22-dataelement-80938', 'peri22-dataelement-82339', 'peri22-dataelement-80639', 'peri22-dataelement-80640', 'peri22-dataelement-80641', 'peri22-dataelement-80636')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='anamneseAlgemeen']//value"
                 priority="1000"
                 mode="M1">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='anamneseAlgemeen']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$anamneseAlgemeen-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@concept=$anamneseAlgemeen-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section anamneseAlgemeen.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M1"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M1"/>
   <xsl:template match="@*|node()" priority="-2" mode="M1">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M1"/>
   </xsl:template>

   <!--PATTERN baring-->
   <xsl:variable name="baring-ids"
                 select="('peri22-dataelement-20500', 'peri22-dataelement-82338', 'peri22-dataelement-82290', 'peri22-dataelement-82292', 'peri22-dataelement-82293', 'peri22-dataelement-82294', 'peri22-dataelement-82296', 'peri22-dataelement-82295', 'peri22-dataelement-20505', 'peri22-dataelement-20530', 'peri22-dataelement-20550', 'peri22-dataelement-20560', 'peri22-dataelement-20570', 'peri22-dataelement-20590', 'peri22-dataelement-20616', 'peri22-dataelement-20620', 'peri22-dataelement-20626', 'peri22-dataelement-20630', 'peri22-dataelement-82224', 'peri22-dataelement-20631', 'peri22-dataelement-80791', 'peri22-dataelement-80803', 'peri22-dataelement-80981', 'peri22-dataelement-80792', 'peri22-dataelement-20640', 'peri22-dataelement-80673', 'peri22-dataelement-82125', 'peri22-dataelement-80797', 'peri22-dataelement-82127', 'peri22-dataelement-82126', 'peri22-dataelement-80831', 'peri22-dataelement-80801', 'peri22-dataelement-82130', 'peri22-dataelement-82131', 'peri22-dataelement-20650', 'peri22-dataelement-82132', 'peri22-dataelement-82057', 'peri22-dataelement-20660', 'peri22-dataelement-20600', 'peri22-dataelement-10601', 'peri22-dataelement-80945', 'peri22-dataelement-30060', 'peri22-dataelement-80694', 'peri22-dataelement-40020', 'peri22-dataelement-82153', 'peri22-dataelement-20670')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='baring']//value" priority="1000" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='baring']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$baring-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$baring-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section baring.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M2"/>
   <xsl:template match="@*|node()" priority="-2" mode="M2">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

   <!--PATTERN bevindingen-->
   <xsl:variable name="bevindingen-ids"
                 select="('peri22-dataelement-82242', 'peri22-dataelement-82243', 'peri22-dataelement-82244', 'peri22-dataelement-82245', 'peri22-dataelement-82246', 'peri22-dataelement-82247', 'peri22-dataelement-82248', 'peri22-dataelement-82249', 'peri22-dataelement-82253', 'peri22-dataelement-82254', 'peri22-dataelement-82255', 'peri22-dataelement-82239', 'peri22-dataelement-82258', 'peri22-dataelement-82259', 'peri22-dataelement-82260', 'peri22-dataelement-82261', 'peri22-dataelement-82262', 'peri22-dataelement-82263', 'peri22-dataelement-82264', 'peri22-dataelement-60060', 'peri22-dataelement-60070', 'peri22-dataelement-60080', 'peri22-dataelement-60100', 'peri22-dataelement-60030')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='bevindingen']//value"
                 priority="1000"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='bevindingen']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$bevindingen-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@concept=$bevindingen-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section bevindingen.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

   <!--PATTERN client-->
   <xsl:variable name="client-ids"
                 select="('peri22-dataelement-10030', 'peri22-dataelement-10031', 'peri22-dataelement-82360', 'peri22-dataelement-10042', 'peri22-dataelement-82359', 'peri22-dataelement-82363', 'peri22-dataelement-10043', 'peri22x-vrouw-volledige_achternaam', 'peri22-dataelement-10040', 'peri22x-vrouw-geboorteland', 'peri22x-burgelijke_staat', 'peri22-dataelement-10400', 'peri22-dataelement-10401', 'peri22-dataelement-82371', 'peri22-dataelement-82154', 'peri22-dataelement-82155', 'peri22x-memo-client', 'peri22-dataelement-10301', 'peri22-dataelement-10302', 'peri22-dataelement-10303', 'peri22-dataelement-10304', 'peri22-dataelement-10305', 'peri22-dataelement-10306', 'peri22-dataelement-10307', 'peri22-dataelement-10308', 'peri22-dataelement-80639', 'peri22-dataelement-80640', 'peri22-dataelement-80641', 'peri22-dataelement-80636', 'peri22-dataelement-82027', 'peri22-dataelement-82028', 'peri22-dataelement-82029', 'peri22-dataelement-82030', 'peri22-dataelement-82031', 'peri22-dataelement-82039', 'peri22-dataelement-82032', 'peri22-dataelement-82033', 'peri22-dataelement-82038', 'peri22-dataelement-82036', 'peri22-dataelement-82037')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='client']//value" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='client']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$client-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$client-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section client.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

   <!--PATTERN consult-->
   <xsl:variable name="consult-ids"
                 select="('peri22-dataelement-80737', 'peri22-dataelement-80738', 'peri22-dataelement-80748', 'peri22-dataelement-82067', 'peri22-dataelement-80736', 'peri22-dataelement-80836', 'peri22-dataelement-80833', 'peri22-dataelement-80834', 'peri22-dataelement-20211', 'peri22-dataelement-80746', 'peri22-dataelement-80742', 'peri22-dataelement-80741', 'peri22-dataelement-80945', 'peri22-dataelement-10814', 'peri22-dataelement-80951', 'peri22-dataelement-80836', 'peri22-dataelement-80622', 'peri22-dataelement-80744', 'peri22-dataelement-82106', 'peri22-dataelement-82107', 'peri22-dataelement-80745')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='consult']//value" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='consult']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$consult-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$consult-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section consult.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN counseling-->
   <xsl:variable name="counseling-ids"
                 select="('peri22-dataelement-20120', 'peri22-dataelement-82088', 'peri22-dataelement-20455', 'peri22-dataelement-20480', 'peri22-dataelement-20485', 'peri22-dataelement-82163', 'peri22-dataelement-20490', 'peri22-dataelement-20495')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='counseling']//value"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='counseling']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$counseling-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$counseling-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section counseling.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN diagnose-->
   <xsl:variable name="diagnose-ids"
                 select="('peri22-dataelement-82270', 'peri22-dataelement-82273', 'peri22-dataelement-82274', 'peri22-dataelement-82275', 'peri22-dataelement-82277', 'peri22-dataelement-82289')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='diagnose']//value" priority="1000" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='diagnose']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$diagnose-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$diagnose-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section diagnose.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN document-->
   <xsl:variable name="document-ids"
                 select="('peri22x-document-naam', 'peri22x-document-link')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='document']//value" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='document']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$document-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$document-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section document.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN echo-->
   <xsl:variable name="echo-ids"
                 select="('peri22-dataelement-50010', 'peri22-dataelement-50020', 'peri22-dataelement-80754', 'peri22-dataelement-82068', 'peri22-dataelement-50021', 'peri22-dataelement-50100', 'peri22-dataelement-50110', 'peri22-dataelement-50120', 'peri22-dataelement-50130', 'peri22-dataelement-50140', 'peri22-dataelement-51010', 'peri22-dataelement-82330', 'peri22-dataelement-82331', 'peri22-dataelement-51020', 'peri22-dataelement-20470', 'peri22-dataelement-60005', 'peri22-dataelement-60010', 'peri22-dataelement-60020', 'peri22-dataelement-60030', 'peri22-dataelement-60031', 'peri22-dataelement-60040', 'peri22-dataelement-60060', 'peri22-dataelement-60061', 'peri22-dataelement-60070', 'peri22-dataelement-60080', 'peri22-dataelement-60081', 'peri22-dataelement-60100', 'peri22-dataelement-60101', 'peri22-dataelement-82340', 'peri22-dataelement-60102', 'peri22-dataelement-80943', 'peri22-dataelement-81007', 'peri22-dataelement-81008', 'peri22-dataelement-80944', 'peri22-dataelement-80985', 'peri22-dataelement-80945', 'peri22-dataelement-80946', 'peri22-dataelement-82071', 'peri22-dataelement-82072', 'peri22-dataelement-82287', 'peri22-dataelement-82288', 'peri22-dataelement-82073', 'peri22-dataelement-80947', 'peri22-dataelement-80948', 'peri22-dataelement-60200', 'peri22-dataelement-82237', 'peri22-dataelement-82240', 'peri22-dataelement-82241', 'peri22-dataelement-82242', 'peri22-dataelement-82243', 'peri22-dataelement-82244', 'peri22-dataelement-82245', 'peri22-dataelement-82246', 'peri22-dataelement-82247', 'peri22-dataelement-82248', 'peri22-dataelement-82249', 'peri22-dataelement-82250', 'peri22-dataelement-82251', 'peri22-dataelement-82253', 'peri22-dataelement-82254', 'peri22-dataelement-82255', 'peri22-dataelement-82256', 'peri22-dataelement-82257', 'peri22-dataelement-82239', 'peri22-dataelement-82258', 'peri22-dataelement-82259', 'peri22-dataelement-82260', 'peri22-dataelement-82261', 'peri22-dataelement-82262', 'peri22-dataelement-82263', 'peri22-dataelement-82264', 'peri22-dataelement-61010', 'peri22-dataelement-61040', 'peri22-dataelement-61025', 'peri22-dataelement-61030', 'peri22-dataelement-61050', 'peri22-dataelement-61060', 'peri22-dataelement-61070', 'peri22-dataelement-61080', 'peri22-dataelement-61100', 'peri22-dataelement-61110', 'peri22-dataelement-82300', 'peri22-dataelement-82301', 'peri22-dataelement-82302', 'peri22-dataelement-82303', 'peri22-dataelement-82304', 'peri22-dataelement-82305', 'peri22-dataelement-82306', 'peri22-dataelement-82307', 'peri22-dataelement-61200', 'peri22-dataelement-82308', 'peri22-dataelement-61220', 'peri22-dataelement-61230', 'peri22-dataelement-61240', 'peri22-dataelement-61250', 'peri22-dataelement-61260', 'peri22-dataelement-61270', 'peri22-dataelement-61280', 'peri22-dataelement-82309', 'peri22-dataelement-82310', 'peri22-dataelement-82311', 'peri22-dataelement-82312', 'peri22-dataelement-82227', 'peri22x-echo-conclusie', 'peri22x-echo-diagnose')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='echo']//value" priority="1000" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='echo']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$echo-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$echo-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section echo.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN intake-->
   <xsl:variable name="intake-ids"
                 select="('peri22-dataelement-80627', 'peri22-dataelement-20290', 'peri22-dataelement-20340', 'peri22-dataelement-80664', 'peri22-dataelement-20355', 'peri22-dataelement-20305', 'peri22-dataelement-20010', 'peri22-dataelement-20150', 'peri22-dataelement-20153', 'peri22-dataelement-80617', 'peri22-dataelement-80678', 'peri22-dataelement-10810', 'peri22-dataelement-20030', 'peri22-dataelement-20040', 'peri22-dataelement-20050', 'peri22-dataelement-20055', 'peri22-dataelement-80669', 'peri22-dataelement-82160', 'peri22-dataelement-80819', 'peri22-dataelement-20020', 'peri22-dataelement-20025', 'peri22-dataelement-20130', 'peri22-dataelement-20140', 'peri22-dataelement-20060', 'peri22-dataelement-20070', 'peri22-dataelement-20080', 'peri22-dataelement-20091', 'peri22-dataelement-20095', 'peri22-dataelement-20100', 'peri22-dataelement-20102', 'peri22-dataelement-20103', 'peri22-dataelement-20170', 'peri22-dataelement-20210', 'peri22-dataelement-20220', 'peri22-dataelement-20211', 'peri22-dataelement-20212', 'peri22-dataelement-80686', 'peri22-dataelement-80675', 'peri22-dataelement-80676', 'peri22-dataelement-10808', 'peri22-dataelement-10809', 'peri22-dataelement-10810', 'peri22-dataelement-10811', 'peri22-dataelement-10816', 'peri22-dataelement-80939', 'peri22-dataelement-10803', 'peri22-dataelement-80680', 'peri22-dataelement-80675', 'peri22-dataelement-20305', 'peri22-dataelement-82275', 'peri22-dataelement-82167', 'peri22-dataelement-82152', 'peri22-dataelement-20261', 'peri22-dataelement-82153', 'peri22-dataelement-82011', 'peri22-dataelement-82009', 'peri22-dataelement-82010', 'peri22-dataelement-20270', 'peri22-dataelement-80642', 'peri22-dataelement-80672', 'peri22-dataelement-10800', 'peri22-dataelement-82102', 'peri22-dataelement-20320', 'peri22-dataelement-20331', 'peri22-dataelement-82164', 'peri22-dataelement-10023', 'peri22x-memo-intake', 'peri22x-memo-anamnese', 'peri22x-memo-zwangerschap', 'peri22x-memo-mdo', 'peri22x-memo-atermelijst')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='intake']//value" priority="1000" mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='intake']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$intake-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$intake-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section intake.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN kind-->
   <xsl:variable name="kind-ids"
                 select="('peri22-dataelement-40003', 'peri22-dataelement-40005', 'peri22-dataelement-82116', 'peri22-dataelement-82117', 'peri22-dataelement-80629', 'peri22-dataelement-80630', 'peri22-dataelement-80631', 'peri22-dataelement-80632', 'peri22-dataelement-40010', 'peri22-dataelement-40011', 'peri22-dataelement-40015', 'peri22-dataelement-82052', 'peri22-dataelement-82054', 'peri22-dataelement-82055', 'peri22-dataelement-40034', 'peri22-dataelement-40040', 'peri22-dataelement-40041', 'peri22-dataelement-40050', 'peri22-dataelement-82087', 'peri22-dataelement-40025', 'peri22-dataelement-40280', 'peri22-dataelement-40290', 'peri22-dataelement-40300', 'peri22-dataelement-40027', 'peri22-dataelement-40028', 'peri22-dataelement-20580', 'peri22-dataelement-20585', 'peri22-dataelement-80619', 'peri22-dataelement-20610', 'peri22-dataelement-30030', 'peri22-dataelement-30050', 'peri22-dataelement-80794', 'peri22-dataelement-30055', 'peri22-dataelement-82089', 'peri22-dataelement-82090', 'peri22-dataelement-82092', 'peri22-dataelement-82095', 'peri22-dataelement-82096', 'peri22-dataelement-82097', 'peri22-dataelement-82098', 'peri22-dataelement-80827', 'peri22-dataelement-82100', 'peri22-dataelement-82101', 'peri22-dataelement-80626', 'peri22-dataelement-20062', 'peri22-dataelement-40070', 'peri22-dataelement-40071', 'peri22-dataelement-80757', 'peri22-dataelement-40140', 'peri22-dataelement-82058', 'peri22-dataelement-40150', 'peri22-dataelement-40160', 'peri22-dataelement-82059', 'peri22-dataelement-40170', 'peri22-dataelement-40180', 'peri22-dataelement-40190', 'peri22-dataelement-40200', 'peri22-dataelement-40210', 'peri22-dataelement-40225', 'peri22-dataelement-40230', 'peri22-dataelement-40240', 'peri22-dataelement-82206', 'peri22-dataelement-82169', 'peri22-dataelement-82170', 'peri22-dataelement-82171', 'peri22-dataelement-82173', 'peri22-dataelement-80769', 'peri22-dataelement-80768', 'peri22-dataelement-80771', 'peri22-dataelement-80772', 'peri22-dataelement-80773', 'peri22-dataelement-80774', 'peri22-dataelement-80775', 'peri22-dataelement-80776', 'peri22-dataelement-80777', 'peri22-dataelement-80784', 'peri22-dataelement-82177', 'peri22-dataelement-82178', 'peri22-dataelement-82179', 'peri22-dataelement-80786', 'peri22-dataelement-82180', 'peri22-dataelement-82181', 'peri22-dataelement-82182', 'peri22-dataelement-82183', 'peri22-dataelement-82184', 'peri22-dataelement-82225', 'peri22-dataelement-82185', 'peri22-dataelement-82186', 'peri22-dataelement-82187', 'peri22-dataelement-82188', 'peri22-dataelement-82189', 'peri22-dataelement-82190', 'peri22-dataelement-82191', 'peri22-dataelement-82192', 'peri22-dataelement-82226', 'peri22-dataelement-82193', 'peri22-dataelement-82194', 'peri22-dataelement-82195', 'peri22-dataelement-82196', 'peri22-dataelement-80762', 'peri22-dataelement-82198', 'peri22-dataelement-82199', 'peri22-dataelement-82200', 'peri22-dataelement-82202', 'peri22-dataelement-82203', 'peri22-dataelement-82204', 'peri22-dataelement-40060', 'peri22-dataelement-80670', 'peri22-dataelement-80759', 'peri22-dataelement-80787', 'peri22-dataelement-80760', 'peri22-dataelement-82205', 'peri22-dataelement-80788', 'peri22-dataelement-40080', 'peri22-dataelement-40090', 'peri22-dataelement-40100', 'peri22-dataelement-40110', 'peri22-dataelement-40120', 'peri22-dataelement-40130', 'peri22-dataelement-82334', 'peri22-dataelement-80789', 'peri22-dataelement-80793', 'peri22-dataelement-80761', 'peri22-dataelement-82119', 'peri22-dataelement-82122', 'peri22-dataelement-82123', 'peri22-dataelement-82121', 'peri22-dataelement-82335', 'peri22-dataelement-80790', 'peri22-dataelement-80980', 'peri22-dataelement-23010', 'peri22-dataelement-23020', 'peri22-dataelement-23030', 'peri22-dataelement-23040', 'peri22-dataelement-23050', 'peri22-dataelement-23070', 'peri22-dataelement-82133', 'peri22-dataelement-82134', 'peri22-dataelement-82135', 'peri22-dataelement-82136', 'peri22-dataelement-82137', 'peri22-dataelement-82138', 'peri22-dataelement-82139', 'peri22-dataelement-82141', 'peri22-dataelement-82142')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='kind']//value" priority="1000" mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='kind']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$kind-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$kind-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section kind.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN kraambed-->
   <xsl:variable name="kraambed-ids"
                 select="('peri22-dataelement-82298', 'peri22-dataelement-82208', 'peri22-dataelement-82209', 'peri22-dataelement-80843', 'peri22-dataelement-82084', 'peri22-dataelement-82085', 'peri22-dataelement-82124', 'peri22-dataelement-80982', 'peri22-dataelement-70011', 'peri22-dataelement-70030', 'peri22-dataelement-82118', 'peri22-dataelement-40250', 'peri22-dataelement-40260', 'peri22-dataelement-40261', 'peri22-dataelement-80765', 'peri22-dataelement-80983', 'peri22-dataelement-80642')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='kraambed']//value" priority="1000" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='kraambed']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$kraambed-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$kraambed-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section kraambed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

   <!--PATTERN onderzoek-->
   <xsl:variable name="onderzoek-ids"
                 select="('peri22-dataelement-50010', 'peri22-dataelement-50020', 'peri22-dataelement-80754', 'peri22-dataelement-82068', 'peri22-dataelement-50021', 'peri22-dataelement-82228', 'peri22-dataelement-82229', 'peri22-dataelement-10814', 'peri22-dataelement-20242', 'peri22-dataelement-80978', 'peri22-dataelement-80952', 'peri22-dataelement-80953', 'peri22-dataelement-80954', 'peri22-dataelement-80955', 'peri22-dataelement-80956', 'peri22-dataelement-80957', 'peri22-dataelement-10812', 'peri22-dataelement-10813', 'peri22-dataelement-80951', 'peri22-dataelement-80992', 'peri22-dataelement-80993', 'peri22-dataelement-80994', 'peri22-dataelement-80995', 'peri22-dataelement-80996', 'peri22-dataelement-82074', 'peri22-dataelement-80961', 'peri22-dataelement-82075', 'peri22-dataelement-80962', 'peri22-dataelement-80964', 'peri22-dataelement-80965', 'peri22-dataelement-80967', 'peri22-dataelement-80968', 'peri22-dataelement-80969', 'peri22-dataelement-80970', 'peri22-dataelement-80971', 'peri22-dataelement-80972', 'peri22-dataelement-80973', 'peri22-dataelement-80974', 'peri22-dataelement-80975', 'peri22-dataelement-80976', 'peri22-dataelement-40051', 'peri22-dataelement-82077', 'peri22-dataelement-82080', 'peri22-dataelement-82082', 'peri22-dataelement-20243', 'peri22-dataelement-80977', 'peri22-dataelement-20612', 'peri22-dataelement-20613', 'peri22-dataelement-20614', 'peri22-dataelement-20615', 'peri22-dataelement-80616', 'peri22-dataelement-80618')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='onderzoek']//value"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='onderzoek']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$onderzoek-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$onderzoek-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section onderzoek.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN verwijzing-->
   <xsl:variable name="verwijzing-ids"
                 select="('peri22-dataelement-82013', 'peri22-dataelement-82017', 'peri22-dataelement-82018', 'peri22-dataelement-82015', 'peri22-dataelement-82016', 'peri22-dataelement-20312', 'peri22-dataelement-20314', 'peri22-dataelement-20311', 'peri22-dataelement-20320', 'peri22-dataelement-82164', 'peri22-dataelement-20331', 'peri22-dataelement-20360', 'peri22-dataelement-20362', 'peri22-dataelement-20366', 'peri22-dataelement-20369', 'peri22-dataelement-20368', 'peri22-dataelement-20367', 'peri22-dataelement-20633', 'peri22-dataelement-80614', 'peri22-dataelement-80615', 'peri22-dataelement-20371', 'peri22-dataelement-20372', 'peri22-dataelement-20373', 'peri22-dataelement-20390', 'peri22-dataelement-10801', 'peri22-dataelement-10808', 'peri22-dataelement-10809', 'peri22-dataelement-20070')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='verwijzing']//value"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='verwijzing']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$verwijzing-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@concept=$verwijzing-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section verwijzing.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN zorgverlener-->
   <xsl:variable name="zorgverlener-ids" select="('peri22-dataelement-10003')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='zorgverlener']//value"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='zorgverlener']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$zorgverlener-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@concept=$zorgverlener-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section zorgverlener.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN zwangerschap-->
   <xsl:variable name="zwangerschap-ids"
                 select="('peri22-dataelement-80983', 'peri22-dataelement-80642', 'peri22-dataelement-70030', 'peri22-dataelement-82208', 'peri22-dataelement-82209', 'peri22-dataelement-20091', 'peri22-dataelement-20095', 'peri22-dataelement-20080', 'peri22-dataelement-82160', 'peri22-dataelement-20220', 'peri22-dataelement-82230', 'peri22-dataelement-80625')"/>

	  <!--RULE -->
   <xsl:template match="section[@type='zwangerschap']//value"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="section[@type='zwangerschap']//value"/>

		    <!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@concept=$zwangerschap-ids"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@concept=$zwangerschap-ids">
               <xsl:attribute name="role">error</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Id <xsl:text/>
                  <xsl:value-of select="@concept"/>
                  <xsl:text/> (<xsl:text/>
                  <xsl:value-of select="@label/string()"/>
                  <xsl:text/>) is niet toegestaan in section zwangerschap.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
</xsl:stylesheet>
