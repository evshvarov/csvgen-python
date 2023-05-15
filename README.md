# csvgen in embedded python
import csv in Intersystems IRIS using embedded python
The analog of [csvgen](https://openexchange.intersystems.com/package/csvgen) but written in embedded python.

It uses [Community IRIS SQLAlchemy](https://openexchange.intersystems.com/package/sqlalchemy-iris) to make everything work.

## Installation ZPM

```
USER>zpm "install csvgenpy"
```


## How to work with it
### import csv
```
w ##class(shvarov.csvgenpy.csv).Generate(filename,tablename,[schemaname],[server=embedded_python_by_default],[append=0])
```

Example:
USER>w ##class(shvarov.csvgenpy.csv).Generate("/home/irisowner/dev/data/countries.csv","countries")

Also can be called directly from python:
$ irispython /home/irisowner/dev/app/csvgen.py

or
```
import csvgen

generate('file.csv','table_name','schema_name')

```

## Run tests

USER>zpm "test csvgenpy"


## Collaboration

The repository is ready for collaboration using Docker

### Installation docker

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
