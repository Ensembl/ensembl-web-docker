FROM andrewyatz/webdocker-perllibs

# --build-args
# some info must be supplied at build time and is then saved to ENV
# this is not a secure solution but should do to get us started

# server hostname args
ARG ENSEMBL_SERVERNAME=www.ensembl.org
ENV ENSEMBL_SERVERNAME=$ENSEMBL_SERVERNAME

# session db args
ARG SESSION_HOST=your.session.db.host
ARG SESSION_PORT=3306
ARG SESSION_USER=ensrw
ARG SESSION_PASS=ensrw

ENV SESSION_HOST=$SESSION_HOST
ENV SESSION_PORT=$SESSION_PORT
ENV SESSION_USER=$SESSION_USER
ENV SESSION_PASS=$SESSION_PASS

# make sure we've got java
RUN sudo apt-get update && sudo apt-get install default-jre -y

# add missing symlinks (these should really be created by the parent image)
RUN mkdir paths/apache
RUN ln -s /home/linuxbrew/.linuxbrew/opt/httpd22/bin/httpd paths/apache/httpd
RUN ln -s /home/linuxbrew/.linuxbrew/opt/httpd22/libexec paths/apache/modules
RUN ln -s /home/linuxbrew/.linuxbrew/opt/bioperl-169/libexec paths/bioperl

# create a workdir
RUN mkdir website
WORKDIR website

# checkout code
RUN git-ensembl --clone ensembl ensembl-compara ensembl-funcgen ensembl-io ensembl-orm ensembl-tools ensembl-variation ensembl-webcode public-plugins
RUN git-ensembl --checkout --branch experimental/docker public-plugins

# copy the Plugins config
RUN cp public-plugins/docker-demo-add-species/conf/Plugins.pm-dist ensembl-webcode/conf/Plugins.pm
RUN cp public-plugins/docker-demo/conf/httpd.conf ensembl-webcode/conf/

# build C deps
#RUN ensembl-webcode/ctrl_scripts/build_api_c     ## not working - probably not required
RUN ensembl-webcode/ctrl_scripts/build_inline_c

# init and start the server
RUN mkdir tmp
RUN ./ensembl-webcode/ctrl_scripts/init
RUN ./ensembl-webcode/ctrl_scripts/start_server

CMD ./ensembl-webcode/ctrl_scripts/start_server -D FOREGROUND

EXPOSE 8080
