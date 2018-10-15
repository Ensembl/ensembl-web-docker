From centos:centos7

RUN echo 'Hello World'

LABEL maintainer="sboddu@ebi.ac.uk"


RUN yum install -y curl make ruby sudo which git wget \
  && yum clean all

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
	&& useradd -m -s /bin/bash ens_adm \
	&& echo 'ens_adm ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers


USER ens_adm


ARG PROJECT_ROOT=/home/ens_adm


WORKDIR ${PROJECT_ROOT}

ENV WEBCODE_LOCATION=${PROJECT_ROOT}/ensweb/ \
    WEB_SOFTWARE_DEPENDENCIES_LOCATION=${PROJECT_ROOT}/ensweb-software/ \
    WEB_TMP_DIR=${PROJECT_ROOT}/ensweb-tmp/

RUN mkdir -p ${WEBCODE_LOCATION} ${WEB_SOFTWARE_DEPENDENCIES_LOCATION} ${WEB_TMP_DIR}

WORKDIR ${WEBCODE_LOCATION}

CMD ["/bin/bash"] 
