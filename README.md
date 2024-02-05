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
w ##class(shvarov.csvgenpy.csv).Generate(source, dest_table_name, [schema_name], [server=embedded_python_by_default], [append=0])
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

## Run tests

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
