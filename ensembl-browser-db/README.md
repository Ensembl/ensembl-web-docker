# Description

Due to obvious security issues, we couldn't host writable sessions database on Ensembl's public MySQL server. 

Therefore, we need to create a separate image for writable databases. But if you would like to use your own sessions databases, you could overwrite it using custom plugins(see [custom-plugin-examples](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-browser/custom-plugin-examples)).

This image uses mysql:5.6 as its base image.

## Build image

Change to to directory where Dockerfile sits and do:
```
docker build . -t <image_name>:<tag_name> --no-cache
```

You could also provide location of Dockerfile using ```-f``` or ```--file``` flag instead of changing the directory to where Dockerfile sits.

To build database image,

```
cd ensembl-browser-db/
docker build . -t ensembl-browser-db:release95 --no-cache
```




