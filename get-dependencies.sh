#!/bin/bash
if [ -f realm.xml ]
  then
    echo "Downloading dependencies"
  else
    echo "realm.xml file not found. Are you running this script from the root of the project?"
    exit 1
fi

mkdir -p dependencies/
wget -O "dependencies/peri22.decor.xml" "http://decor.nictiz.nl/decor/services/RetrieveTransaction?language=nl-NL&version=2016-02-16T11:05:01&hidecolumns=45ghi&id=2.16.840.1.113883.2.4.3.11.60.90.77.1.5&2013-09-10T00:00:00&format=xml"
