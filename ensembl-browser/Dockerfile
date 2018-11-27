FROM sanjayboddu/ensembl-web-libs-03:experiemntal_release_94.1

USER www

ARG ENSEMBL_DIVISION
ARG ENSEMBL_RELEASE
ARG ENSEMBL_GENOMES_RELEASE


WORKDIR $ENSEMBL_WEBCODE_LOCATION

ADD clone-git-repos.sh $ENSEMBL_WEBCODE_LOCATION

RUN source ${HOME}/.bashrc \
    && /bin/bash -c "time source clone-git-repos.sh" 


CMD source ${HOME}/.bashrc \
    && ./ensembl-webcode/ctrl_scripts/start_server -D FOREGROUND 

EXPOSE 8080
