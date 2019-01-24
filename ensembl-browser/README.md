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
