FROM ensemblorg/ensembl-web-libs-03:experiemntal_release_95.1

USER www


# These arguments are set in docker-compose file. Also can be passed as command line arguments during image build.
ARG ENSEMBL_DIVISION
ARG ENSEMBL_RELEASE
ARG ENSEMBL_GENOMES_RELEASE


# ENSEMBL_WEBCODE_LOCATION env variable is set in base images
WORKDIR $ENSEMBL_WEBCODE_LOCATION


# Add customisation examples to webcode location if user decides to use them
ADD --chown=www custom-plugin-examples $ENSEMBL_WEBCODE_LOCATION/custom-plugin-example


ADD --chown=www create-ensembl-site.sh $ENSEMBL_WEBCODE_LOCATION

RUN source ${HOME}/.bashrc \
    && /bin/bash -c "time source create-ensembl-site.sh" 


CMD source ${HOME}/.bashrc \
    && ./ensembl-webcode/ctrl_scripts/start_server -D FOREGROUND 

EXPOSE 8080
