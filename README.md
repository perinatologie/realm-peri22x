peri22x
=======

Deze repository bevat de bron-bestanden van de `peri22x` dataset.

Online viewer: [https://dataset.perinatologie.nl/peri22x](https://dataset.perinatologie.nl/peri22x)
    
`peri22x` is een initiatief van [perinatologie.nl](http://www.perinatologie.nl): Het platform voor samenwerking in de geboortezorg waarin verschillende software leveranciers vertegenwoordigd zijn.

## Wat is peri22x ?

`peri22x` is een dataset welke als basis de originele `peri22` dataset gebruikt van [decor.nictiz.nl/perinatologie/](http://decor.nictiz.nl/perinatologie/) en hier aanvullingen op doet welke nodig en/of gewenst zijn tbv gegevens uitwisseling tussen zorgverleners via de [PeriHub](http://www.perinatologie.nl).

Naast alle in `peri22` gedefinieerde concepten en codelijsten vult `peri22x` deze set aan met:

### 1. Uitbreidingen op peri22

Nieuwe concepten (in map `concepts/` met prefix `peri22x-`) en codelijsten (in map `codelists/`) welke (nog) niet in de officiele peri22 set gedefineerd zijn.

### 2. Mappings

De map `mappings/` bevat gestructureerde mapping bestanden van en naar verschillende datasets.

De voornaamste mapping is die van `keyid` naar `peri22x` concepten. De `keyid` set is een set welke in de begin-fase op de [perihub](http://www.perinatologie.nl) in gebruik was voor uitwisseling van dossiers.

Daarnaast kunnen hier mappings van bepaalde specifieke applicaties naar peri22x gevonden worden.

### 3. SectionTypes

Het bestandsformaat voor uitwisseling bestaat uit een of meerdere `section` elementen. In de map `sectionTypes/` staan de bestanden welke definieren welke typen er bestaan, en welke velden deze kunnen bevatten.

### 4. Voorbeeld resources en forms

Op de hub worden `resources` uitgewisseld. In de map `resources/` staan hiervan enkele voorbeeld bestanden tbv referentie en testen. In de map `forms/` staan enkele voorbeeld bestanden van de voorloper van resources, `forms`. 

### 5. XSD bestanden voor resources

In de map `xsd/` staan XSD bestanden tbv het valideren van resource XML bestanden.

## Online viewer: Realm

Deze bron-bestanden zijn ook via een online viewer te bekijken op de volgende URL:

    https://dataset.perinatologie.nl/peri22x

Dit is een installatie van [Realm](http://github.com/linkorb/realm) waarmee deze dataset gevisualiseerd kan worden.

## XSD

Een resource XML document kan gevalideerd worden mbv de bijgeleverde XSD:

    xmllint --schema xsd/resource.xsd resources/voorbeeld1.xml

## Dependencies

Aangezien `peri22x` een uitbreiding is op `peri22` is de originele dataset nodig
om gebruik te kunnen maken van `peri22x`. Deze set is niet meegeleverd in deze repository.
Maar, deze is eenvoudig te downloaden door het script `get-dependencies.sh` uit te voeren:

    ./get-dependencies.sh

Dit script maakt een nieuwe map `dependencies/` aan,
en plaatst hierin het bestand `peri22.decor.xml`. Dit bestand wordt gedownload vanaf decor.nictiz.nl

## Licentie

`peri22x` bevat de meest vrije licentie, de CC0 1.0 Universal license. Zie de `LICENSE` file voor meer informatie.

## Aanpassingen, toevoegingen en verbeteringen

perinatologie.nl staat voor samenwerking. contributies in de vorm van aanpassingen, toevoegingen en verbetering op deze repository zijn dan ook van harte welkom. Zie voor details het bestand `CONTRIBUTING`
