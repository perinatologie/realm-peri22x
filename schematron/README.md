# Schematron

De stylesheet ../xsl/sectionTypes2schematron genereert een .sch voor iedere sectionType in 
../schematron/include. In de schematron folder staat resources.sch, deze bevat de sectionTypes 
(aanpassen als er sectionTypes bijkomen of weggaan). Vervolgens kan een peri22x file met de
schematron in resources.sch gevalideerd worden. Controles zijn nu alleen op concept id's die niet
in een bepaalde section voor zouden moeten komen.