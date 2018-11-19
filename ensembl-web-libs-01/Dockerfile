From centos:centos7

RUN echo 'Hello World'

LABEL maintainer="sboddu@ebi.ac.uk"


RUN yum update -y \
  && yum install -y bzip2 curl file gcc gcc-c++ git make ruby patch sudo which wget openssh \
  && yum groupinstall 'Development Tools' -y \
  && yum clean all

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
	&& useradd -m -s /bin/bash www \
	&& echo 'www ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers


ARG PROJECT_ROOT=/ebi/

# Unlike other locations, ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION should be set to "/home/linuxbrew". This is a requirement for brew to install packages from bottles rather than falling back to installing from source for a few packages.
# For more info, see: https://github.com/Linuxbrew/brew/wiki/FAQ

# IS_A_DOCKER_INSTALL is to disable user input prompts while installing the libraries

ENV ENSEMBL_WEBCODE_LOCATION=${PROJECT_ROOT}/ensweb/ \
    ENSEMBL_TMP_DIR_LOCATION=${PROJECT_ROOT}/nobackup/ \
    ENSEMBL_USERDATA_LOCATION=${PROJECT_ROOT}/incoming/ \
    ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION=/home/linuxbrew \
    HOMEBREW_NO_ANALYTICS=1 \
    HOMEBREW_NO_AUTO_UPDATE=1 \
    IS_A_DOCKER_INSTALL=1


RUN sudo mkdir -p ${ENSEMBL_WEBCODE_LOCATION} ${ENSEMBL_TMP_DIR_LOCATION} ${ENSEMBL_USERDATA_LOCATION} ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION} \
    && sudo chmod 777 ${ENSEMBL_WEBCODE_LOCATION}  ${ENSEMBL_TMP_DIR_LOCATION} ${ENSEMBL_USERDATA_LOCATION} ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION}


USER www

WORKDIR ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION}


#######################

#RUN wget https://github.com/Ensembl/linuxbrew-automation/archive/1.0.0.tar.gz \
#    && tar -xvzf 1.0.0.tar.gz

#WORKDIR ${WEB_SOFTWARE_DEPENDENCIES_LOCATION}/linuxbrew-automation-1.0.0

RUN git clone https://github.com/Ensembl/linuxbrew-automation.git
WORKDIR ${ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION}/linuxbrew-automation
RUN git checkout docker \ 
    && /bin/bash -c "time source 01-base-libraries.sh $ENSEMBL_SOFTWARE_DEPENDENCIES_LOCATION" \
    && rm -r ${HOME}/.cache/Homebrew/downloads/* 
#######################


CMD ["/bin/bash"] 
