# farport/node-builder

Simple docker image to help with building node based project for docker.  2 version:

* `alpine`
* `debian` -> name by it's release name, e.g.: `buster`

#### Version Naming

The version naming uses tha major and minor version of the underlying node version.  The build
number is used to increment any changes implemented in the `node-builder` docker image.

* `node major`.`node minor`.`node-builder version`

#### Build and Push

There is not integration with docker hub at the moment.  As result, do the following to push:

```
make build
make push
```

#### Run Docker Image

To check the content of an existing image, do:

```
docker run --rm -it node:14.15.4-alpine3.12 sh
```
