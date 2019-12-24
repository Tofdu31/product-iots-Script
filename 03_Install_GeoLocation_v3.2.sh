#!/usr/bin/env bash

# https://docs.wso2.com/display/IOTS330/Applying+Policies+on+Devices+Based+on+Geofencing

clear

# variables couleurs
noir='\e[0;30m'
gris='\e[1;30m'
rougefonce='\e[0;31m'
rose='\e[1;31m'
vertfonce='\e[0;32m'
vertclair='\e[1;32m'
orange='\e[0;33m'
jaune='\e[1;33m'
bleufonce='\e[0;34m'
bleuclair='\e[1;34m'
violetfonce='\e[0;35m'
violetclair='\e[1;35m'
cyanfonce='\e[0;36m'
cyanclair='\e[1;36m'
grisclair='\e[0;37m'
blanc='\e[1;37m'

neutre='\e[0;m'
# -------------------

iot_hostname="${1}"
dir_wso2iot=$(dirname $PWD/wso2iot*/conf)

if [ "${iot_hostname}" == "" ]; then
    iot_hostname='163.172.90.197'
fi

echo ""
echo "----------------------------------------------"
echo -e "-   ${cyanclair}INSTALL GEO LOCALISATION WSO2 IOT 3.1.x  ${neutre}-"
echo "----------------------------------------------"
echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""
echo "Documentation ici : https://docs.wso2.com/display/IOTS330/Applying+Policies+on+Devices+Based+on+Geofencing"

PS3='> '   # le prompt
echo ""
echo ""
echo "La configuration est correcte ?"
LISTE=("[y] yes" "[n]  no")  # liste de choix disponibles
select CHOIX in "${LISTE[@]}" ; do
    case $REPLY in
        1|y)
        echo ""
        echo "ok"
        break
        ;;
        2|n)
        echo ""
        echo "Effectuer vos parametrages et relancer le script !"
        exit
        ;;
    esac
done

##################################### MODIFICATION FICHIER DE CONFIGURATION ####################################
echo ""
echo ""
echo "MODIFICATION FICHIER DE CONFIGURATION"
echo ""
echo ""
echo "Activation GeoLocationConfiguration"
sed -i -e "/<GeoLocationConfiguration>/,/<\/GeoLocationConfiguration>/ s/<Enabled>false<\/Enabled>/<Enabled>true<\/Enabled>/g;" ${dir_wso2iot}/conf/cdm-config.xml
echo "Completed!!"
echo ""
echo "Activation PublishLocationResponse"
sed -i -e "s|<PublishLocationResponse>false<\/PublishLocationResponse>|<PublishLocationResponse>true<\/PublishLocationResponse>|g" ${dir_wso2iot}/conf/cdm-config.xml
echo "Completed!!"
echo ""
echo "Activation PublishOperationResponse"
sed -i -e "/<PublishOperationResponse>/,/<\/PublishOperationResponse>/ s/<Enabled>false<\/Enabled>/<Enabled>true<\/Enabled>/g;" ${dir_wso2iot}/conf/cdm-config.xml
echo "Completed!!"
echo ""
echo "Activation PublishDeviceInfoResponse"
sed -i -e "s|<PublishDeviceInfoResponse>false<\/PublishDeviceInfoResponse>|<PublishDeviceInfoResponse>true<\/PublishDeviceInfoResponse>|g" ${dir_wso2iot}/conf/cdm-config.xml
echo "Completed!!"
echo ""
echo "Activation PublishOperationResponse"
sed -i -e "/<PublishOperationResponse>/,/<\/PublishOperationResponse>/ s/<Enabled>false<\/Enabled>/<Enabled>true<\/Enabled>/g;" ${dir_wso2iot}/conf/cdm-config.xml
echo "Completed!!"
echo ""
echo "Fichier de configuration OK"
echo ""
##################################### TELERCHARGEMENT Artifacts ####################################
echo ""
echo " INSTALL Deploy Geo Analytics Artifacts"
mvn clean install -f ${dir_wso2iot}/wso2/analytics/scripts/siddhi-geo-extention-deployer.xml
echo "Completed!!"
echo ""
echo ""
echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"

