# csvgen in embedded python
import csv in Intersystems IRIS using embedded python
The analog of [csvgen](https://openexchange.intersystems.com/package/csvgen) but written in embedded python.

It uses [Community IRIS SQLAlchemy](https://openexchange.intersystems.com/package/sqlalchemy-iris) to make everything work.

## Installation ZPM

```
USER>zpm "install csvgenpy"
```


## API
```
w ##class(shvarov.csvgenpy.csv).Generate(filename_or_url, dest_table_name, [schema_name], [server=embedded_python_by_default], [append=0])
```
Parameters in brackets are optional.

## Examples

### Import from file
```
USER>do ##class(shvarov.csvgenpy.csv).Generate("/home/irisowner/dev/data/countries.csv","countries")
```

### Import from URL
```
USER>do ##class(shvarov.csvgenpy.csv).Generate("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv","titanic","data")
```

## Call directly from python:
```
$ irispython /home/irisowner/dev/app/csvgen.py
```

or

```
import csvgen
generate('file.csv','dest_table_name','schema_name')

```

## primary key import
If one of the csv cols should be a primary key provide its name as a last parameter, e.g.

```objectscript
do ##class(shvarov.csvgenpy.csv).Generate("/home/irisowner/dev/data/countries_dspl small.csv","countries","data",,,,"name")
```

so instances from data.countries could be open by country names, e.g.:
```objectscript
set country=##class(csvgen.sqltest).%OpenId("Albania")
write country.country
AL
```

## Run tests
Tests can be found in https://github.com/evshvarov/csvgen-python/blob/52a95662dddce63b6c8227e420f3ef2f8850f35f/tests/Test/shvarov/csvgenpy/Testcsv.cls

USER>zpm "test csvgenpy"


## Collaboration

The repository is ready for collaboration using Docker

### Docker installation

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/intersystems-community/iris-embedded-python-template.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```
