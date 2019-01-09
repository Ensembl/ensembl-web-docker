FROM ensemblorg/ensembl-web-libs-01:experiemntal_release_95.1

#WORKDIR ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION}/linuxbrew-automation

USER www

RUN source ${HOME}/.bashrc \ 
    && /bin/bash -c "time source 02-additional-libraries.sh" \
    && rm -r ${HOME}/.cache/Homebrew/downloads/* 
