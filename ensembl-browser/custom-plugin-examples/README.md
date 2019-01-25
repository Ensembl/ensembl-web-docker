# Description

You can create an Ensembl browser site with your own species and use your own database.

Custom site requires you to build your own browser image using our pre built web libs images as base. 

For custom sites, Ensembl recommends using ensembl-web-libs-03 image from DockerHub as your base image rather than building web libs from scratch.

But if you have a use case to build them from scratch, we would be interested to hear about it. 


## Customisation

You will need to update configuration in custom-database or custom species according to your need.

Also, you will need to modify the existing Dockerfile and create-ensembl-site script with few extra commands to incorporate your custom configurations into web code. All the updates you will need to do are highlighted below. 





## Example commands

# Syntax for building an image
docker build . -t <image_name>:<tag_name> --no-cache
