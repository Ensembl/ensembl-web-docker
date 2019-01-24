# ensembl-web-docker

This repo hosts Dockerfiles to build images for Ensembl browser and its dependencies. All the images built from these Dockerfiles are hosted on [Docker Hub](https://hub.docker.com/u/ensemblorg)

You could either build your own images(if you need customisation) or just pull and run prebuilt images for default Ensembl site from Docker Hub.

Ensembl builds these images every release and host it on [Docker Hub](https://hub.docker.com/u/ensemblorg)


# Simple commads to get your local default Ensembl site running

## Manual commands
    
Create a custom bridge network

```
docker network create my-custom-network
```
    
Pull and run Ensembl sessions database image from Docker Hub and name the resulting container as 'ensembl_docker_database'. Add then container to the custom network you created in the above step.

```
docker run -d --network=my-custom-network --name ensembl_docker_database ensemblorg/ensembl-browser-db:experiemntal_release_95.1
```

Pull and run Ensembl browser image from Docker Hub and name the resulting container as 'browser'. 
Add the container to the custom network so that this container can talk to the sessions database.
Browser web application in the container runs on port 8080. Therefore, bind resulting container's 8080 port to TCP port 8000 on 127.0.0.1 of the host machine. 
You should now be able to browser the site at http://localhost:8000/

```
docker run -d --network=my-custom-network -p 127.0.0.1:8000:8080/tcp  --name browser ensemblorg/ensembl-browser-vertebrates:experiemntal_release_95.1
```

Ensembl browser container takes at least 2 mins to startup after running the image. Determinig the readiness of a container could be tricky when you start it in detached mode using ```-d```. 
Other option is to run the container in foreground using ```-it``` instead of ```-d``` in the above command.

## Or just use docker compose instead

Docker compose simplifies building and/or running multi container Docker application.

All the above three steps will be taken care by docker-compose.yml file in ensembl-browser directory. 

Run docker compose using following command:

```
docker-compose -f ensembl-browser/docker-compose.yml up
```

## Other Ensembl divisional sites

There are images for other Ensembl divisional sites (Metazoa, Bacteria, Plants, Fungi and Protists) on the Docker Hub which you could pull and start. Just update the value of ‘image’ in the docker-compose.yml file to the location of your Ensembl divisional site image and you should be ready to go with
```
docker-compose -f ensembl-browser/docker-compose.yml up
```


# Components

This project has got 3 components

1) Building web libs

Building web libs is done in 3 stages using Dockerfiles in [ensembl-web-libs-01](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-web-libs-01), [ensembl-web-libs-02](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-web-libs-02) and [ensembl-web-libs-03](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-web-libs-03). 

They are divided into three different Dockerfiles due to build time restriction on Docker Hub.

You could imagine each stage as a layer in a stack with each building on top of another.

2) Building ensembl browser site

Building browser also involves 3 stages. But unlike web libs, all these three stages are done by single Dockerfile in [ensembl-browser](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-browser) 

3) Building sessions database

Due to obvious security issues, we couldn't host writable sessions database on Ensembl's public MySQL server. The Dockerfile in [ensembl-browser-db](https://github.com/Ensembl/ensembl-web-docker/tree/master/ensembl-browser-db) takes care of building image with Ensembl sessions database server using mysql:5.6 as its base image. 
