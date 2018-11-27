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
        printf "Please set ENSEMBL_DIVISION to www for Ensembl site or [metazoa|bacteria|plants|fungi|protists] for divisional sites"
        return
fi


if [[ -z "${ENSEMBL_RELEASE}" && -z "${ENSEMBL_GENOMES_RELEASE}" ]]; then
	printf "Please set either ENSEMBL_RELEASE for Ensembl site or ENSEMBL_GENOMES_RELEASE for divisional sites"
	return
fi


if [[ "${ENSEMBL_DIVISION}" == "www" &&  -z "${ENSEMBL_RELEASE}" ]]; then
	printf "ENSEMBL_RELEASE must be supplied when creating site for Ensembl"
	return
fi


if [[ "${ENSEMBL_DIVISION}" != "www" &&  -z "${ENSEMBL_GENOMES_RELEASE}" ]]; then
        printf "ENSEMBL_GENOMES_RELEASE must be supplied when creating Ensembl divisional site"
        return
fi



echo ENSEMBL_DIVISION  = "${ENSEMBL_DIVISION}"
echo ENSEMBL_RELEASE    = "${ENSEMBL_RELEASE}"
echo ENSEMBL_GENOMES_RELEASE    = "${ENSEMBL_GENOMES_RELEASE}"
echo ENSEMBL_WEBCODE_LOCATION     = "${ENSEMBL_WEBCODE_LOCATION}"
echo ENSEMBL_TMP_DIR_LOCATION         = "${ENSEMBL_TMP_DIR_LOCATION}"







cd ${ENSEMBL_WEBCODE_LOCATION}

git-ensembl --clone --checkout --branch release/${ENSEMBL_RELEASE} public-web 

# Clone e!g repos if ENSEMBL_DIVISION is not www. We could improvise it by check if ENSEMBL_DIVISION is a valid division name
if [ "${ENSEMBL_DIVISION}" != "www" ]; then
	git ensembl --clone --branch release/eg/${ENSEMBL_GENOMES_RELEASE} eg-${ENSEMBL_DIVISION}
fi


git-ensembl --checkout --branch experimental/docker2 public-plugins 



if [[ "${ENSEMBL_DIVISION}" == "www" ]]; then
	cp public-plugins/docker/conf/Plugins.pm-dist-www ensembl-webcode/conf/Plugins.pm
else
	cp public-plugins/docker/conf/Plugins.pm-dist-div ensembl-webcode/conf/Plugins.pm
        sed -i -e "s/division/${ENSEMBL_DIVISION}/g" -e "s/Division/${ENSEMBL_DIVISION^}/g" ensembl-webcode/conf/Plugins.pm 
fi





mkdir -p ${ENSEMBL_TMP_DIR_LOCATION}/server/conf/packed


ensembl-webcode/ctrl_scripts/init 
ensembl-webcode/ctrl_scripts/build_packed ALL

