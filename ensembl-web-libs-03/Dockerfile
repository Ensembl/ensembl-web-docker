FROM sanjayboddu/ensembl-web-libs-2:v1

WORKDIR ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION}/linuxbrew-automation
RUN git pull
USER www

RUN source ${HOME}/.bashrc \ 
    && /bin/bash -c "time source 03-perl-and-python-dependencies.sh" \
    && /bin/bash -c "time source 04-misc.sh" \
    && rm -r ${HOME}/.cpanm/work/* 
