# csvgen in embedded python
import csv in Intersystems IRIS using embedded python

## Installation ZPM

```
USER>zpm "install csvgenpy"
```

## Installation docker

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

## How to work with it


### import csv
```
w ##class(shvarov.csvgenpy.generate).Generate(filename,tablename,[schemaname],[server=embedded_python_by_default],[append=0])
```
Example:
USER>w ##class(shvarov.csvgenpy.generate).Generate("/home/irisowner/dev/data/countries.csv","countries")

### Run tests

USER>zpm "test csvgenpy"
