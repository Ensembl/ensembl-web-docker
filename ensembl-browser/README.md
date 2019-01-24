# Description

Building browser involves 3 stages. 
1) Clone all the required repos depending on which Ensembl site(Ensembl, Metazoa, Bacteria, Plants, Fungi, Protists) you are building.
2) Do the required configuration
3) Build all the packed(they are kind of cached files) file

This image is created using ensembl-web-libs-03 image as its base.

By default, Ensembl browser site is configured to build against Ensembl's public MySQL server. You could overwrite it using custom plugins(see [custom-plugin-examples](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-browser/custom-plugin-examples)) if you want to connect to your own databases or use your own species.

Any user who wishes to create a custom Ensembl browser site with their own species or their own databases are advised to use ensembl-web-libs-03 as their base image rather than building all the libs from scratch.

But if you have a use case to build them from scratch, we would be interested to hear about it. 


## Build image

Change to to directory where Dockerfile sits and do:
```
docker build . -t <image_name>:<tag_name> --no-cache
```

You could also provide location of Dockerfile using ```-f``` or ```--file``` flag instead of changing the directory to where Dockerfile sits.


To build default Ensembl site,

```
cd ensembl-browser/
docker build . \
-t my-ensembl-browser:release95 \
--build-arg ENSEMBL_DIVISION=ensembl \
--build-arg ENSEMBL_RELEASE=95 \
--build-arg ENSEMBL_GENOMES_RELEASE=42  \
--no-cache
```

Dockerfile for ensembl-browser needs following three build arguments:

```ENSEMBL_DIVISION``` -> Set ENSEMBL_DIVISION to 'ensembl' for Ensembl(vertebrates) site or to [metazoa|bacteria|plants|fungi|protists] for divisional sites.

```ENSEMBL_RELEASE``` -> Set ENSEMBL_RELEASE to the Ensembl release version. For example, to build a site with release 95 code, set ```ENSEMBL_RELEASE=95```.

```ENSEMBL_GENOMES_RELEASE``` -> Set ENSEMBL_GENOMES_RELEASE to Ensembl Genomes release version. It is needed only if you are building divisional(metazoa|bacteria|plants|fungi|protists) site and is not a mandatory build argument to build Ensembl(vertebrates) site.
