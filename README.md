# AWS Lambda, Python 3.6, Pipenv, SAM Local

Sample app of AWS Lambda.

* Packaging by Pipenv
  * Install dependencies to `vendor` directory
* Run on SAM Local

## Run

```
$ make build
$ docker-compose up
$ sam local generate-event schedule | sam local invoke "HelloWorldFunction" --docker-network <<network>>
```

## Bundle

```
$ make bundle
```
