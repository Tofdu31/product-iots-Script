#!/usr/bin/env bash

# Replace localhost with a real hostname.

# https://docs.wso2.com/display/IOTS330/Arduino
# https://docs.wso2.com/display/IOTS330/Raspberry+Pi

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
echo -e "-              ${cyanclair}Install Samples${neutre}               -"
echo -e "-     ${cyanclair}Raspberry - Arduino WSO2 IOT 3.1.x${neutre}     -"
echo "----------------------------------------------"
echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""

echo -e "Adress IP Serveur IOT : ${orange}${iot_hostname}${neutre}"

PS3='> '   # le prompt
echo ""
echo ""
echo "La configuration est-elle correcte ?"
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

echo ""
echo ""
echo " INSTALL Samples"
mvn clean install -f ${dir_wso2iot}/samples/device-plugins-deployer.xml
echo ""
echo ""
echo "Completed!!"
echo "Ne pas hesiter à consulter la documentation : https://docs.wso2.com/display/IOTS330/Enrolling+Devices"


echo ""
echo "----------------------------------------"
echo "     OPERATION TERMINE AVEC SUCCES"
echo "----------------------------------------"
echo ""
echo ""
echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"
