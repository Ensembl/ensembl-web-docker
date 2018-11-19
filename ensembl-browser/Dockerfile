FROM sanjayboddu/ensembl-web-03:v2

USER www

ARG ENSEMBL_SERVERNAME=www.ensembl.org 

ENV ENSEMBL_SERVERNAME=$ENSEMBL_SERVERNAME 

WORKDIR $ENSEMBL_WEBCODE_LOCATION

# checkout code
RUN source ${HOME}/.bashrc \
    && git-ensembl --clone --checkout --branch release/94 public-web \
    && git-ensembl --checkout --branch experimental/docker2 public-plugins \
    && cp public-plugins/docker/conf/Plugins.pm-dist ensembl-webcode/conf/Plugins.pm

RUN mkdir -p ${ENSEMBL_TMP_DIR_LOCATION}/server/conf/packed 
#ADD --chown=www  *.packed ${ENSEMBL_TMP_DIR_LOCATION}/server/conf/packed/

# init and start the server
RUN source ${HOME}/.bashrc \
    && ./ensembl-webcode/ctrl_scripts/init \ 
    && ./ensembl-webcode/ctrl_scripts/build_packed ALL


CMD source ${HOME}/.bashrc \
    && ./ensembl-webcode/ctrl_scripts/start_server -D FOREGROUND 

EXPOSE 8080
