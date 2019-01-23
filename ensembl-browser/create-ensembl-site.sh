#!/bin/bash




#################################################################################################
#
#IMPORTANT - THIS SCRIPT IS DESIGNED TO RUN BY DOCKERFILE. IT IS NOT DESIGNED TO RUN MANUALLY.
#
#################################################################################################




#POSITIONAL=()
#while [[ $# -gt 0 ]]
#do
#key="$1"
#
#case $key in
#    --division)
#    DIVISION="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    --ensembl_release)
#    ENSEMBL_RELEASE="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    --ensembl_genomes_release)
#    ENSEMBL_GENOMES_RELEASE="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    *)    # unknown option
#    POSITIONAL+=("$1") # save it in an array for later
#    shift # past argument
#    ;;
#esac
#done
#
#set -- "${POSITIONAL[@]}" # restore positional parameters
#echo ${POSITIONAL[@]}




if [[ -z "${ENSEMBL_DIVISION}" ]]; then
        printf "Please set ENSEMBL_DIVISION to 'ensembl' for Ensembl site or to [metazoa|bacteria|plants|fungi|protists] for divisional sites."
        exit 1
fi


if [[ -z "${ENSEMBL_RELEASE}" ]]; then
	printf "Please set the value of ENSEMBL_RELEASE to the Ensembl release version. For example, to build a site with release 95 code, set 'ENSEMBL_RELEASE: 95' in docker-compose file if you are building using docker-compose or pass it as command line argument"
	exit 1
fi


if [[ "${ENSEMBL_DIVISION}" != "ensembl" &&  -z "${ENSEMBL_GENOMES_RELEASE}" ]]; then
        printf "ENSEMBL_GENOMES_RELEASE must be supplied when creating Ensembl divisional site"
        exit 1
fi



echo ENSEMBL_DIVISION		= "${ENSEMBL_DIVISION}"
echo ENSEMBL_RELEASE		= "${ENSEMBL_RELEASE}"
echo ENSEMBL_GENOMES_RELEASE	= "${ENSEMBL_GENOMES_RELEASE}"
echo ENSEMBL_WEBCODE_LOCATION	= "${ENSEMBL_WEBCODE_LOCATION}"
echo ENSEMBL_TMP_DIR_LOCATION	= "${ENSEMBL_TMP_DIR_LOCATION}"



cd ${ENSEMBL_WEBCODE_LOCATION}

git-ensembl --clone --checkout --branch release/${ENSEMBL_RELEASE} public-web 

# Clone e!g repos if ENSEMBL_DIVISION is not ensembl. We could improvise it by check if ENSEMBL_DIVISION is a valid division name
if [ "${ENSEMBL_DIVISION}" != "ensembl" ]; then
	git ensembl --clone --branch release/eg/${ENSEMBL_GENOMES_RELEASE} eg-${ENSEMBL_DIVISION}

	# Following two lines can be removed when building image for release 96. They are added to 'eg-<division>' groups in ensembl-git-tools and will be picked up the next time we build libs.
	git ensembl --clone --branch release/${ENSEMBL_RELEASE} ensembl-metadata
	git ensembl --clone --branch release/${ENSEMBL_RELEASE} ensembl-taxonomy


	# Add static content(images, taxon tree, species descriptions etc) to the site
	printf "Pulling ${ENSEMBL_DIVISION}'s static content for release ${ENSEMBL_GENOMES_RELEASE} \n"
	curl -O ftp://ftp.ensemblgenomes.org/pub/release-${ENSEMBL_GENOMES_RELEASE}/${ENSEMBL_DIVISION}/web_assets.tar.gz; 
	tar -zx --directory eg-web-${ENSEMBL_DIVISION} --file web_assets.tar.gz
fi



if [[ "${ENSEMBL_DIVISION}" == "ensembl" ]]; then
	cp public-plugins/docker/conf/Plugins.pm-dist-ensembl ensembl-webcode/conf/Plugins.pm
else
	cp public-plugins/docker/conf/Plugins.pm-dist-div ensembl-webcode/conf/Plugins.pm
        sed -i -e "s/division/${ENSEMBL_DIVISION}/g" -e "s/Division/${ENSEMBL_DIVISION^}/g" ensembl-webcode/conf/Plugins.pm 
fi





mkdir -p ${ENSEMBL_TMP_DIR_LOCATION}/server/conf/packed


ensembl-webcode/ctrl_scripts/init 
ensembl-webcode/ctrl_scripts/build_packed ALL

