# Description

Building web libs is divided into three stages due to build time restriction on Docker Hub.

You could imagine each stage as a layer in a stack with each building on top of another.

**ensembl-web-libs-01** Dockerfile is used to build an image which creates environment for installation and installs Ensembl's base libraries and other additional libraries needed for cpanm. This dockerfile uses centos7 as its base image.

**ensembl-web-libs-02** Dockerfile is used to build an image with libraries needed for GUI, Bioinformatics libraries and a few internal libraries needed for webteam. This image builds on top of ensembl-web-libs-01.

**ensembl-web-libs-03** Dockerfile is used to build an image with all the Perl modules and Python packages required to run Ensembl site. It also installs fonts and does a bit of cleanup.  This image uses ensembl-web-libs-02 image as its base.

In the instances where you are creating your own browser site, Ensembl recommends users to use ensembl-web-libs-03 image from DockerHub as your base image rather than building all the above three images from scratch.

But if you have a use case to build them from scratch, we would be interested to hear about it. 

We use ensembl-web-libs-03 as our base image in the next step to build image for ensembl browser site.

## Build image

Change to to directory where Dockerfile sits and do:
```
docker build . -t <image_name>:<tag_name> --no-cache
```

You could also provide location of Dockerfile using ```-f``` or ```--file``` flag instead of changing the directory to where Dockerfile sits.

To build ensembl-web-libs-03 image,


```
cd ensembl-web-libs-03/
docker build . -t ensembl-web-libs-03:release95 --no-cache
```
