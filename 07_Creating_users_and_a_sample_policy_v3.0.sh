#!/usr/bin/env bash

# Replace localhost with a real hostname.

# https://docs.wso2.com/display/IoTS310/Configuring+WSO2+IoT+Server+with+the+IP
# https://docs.wso2.com/display/IoTS310/Working+with+Databases
# http://xmlstar.sourceforge.net/doc/UG/xmlstarlet--updateg.html

clear

iot_hostname="${1}"
dir_wso2iot=$(dirname $PWD/wso2iot*/conf)

if [ "${iot_hostname}" == "" ]; then
    iot_hostname='163.172.90.197'
fi

echo ""
echo "----------------------------------------------"
echo "-    Creating users and a sample policy      -"
echo "-               WSO2 IOT 3.1.x               -"
echo "----------------------------------------------"
echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo "Actuellement, votre répertoire d'installation est : ${dir_wso2iot} "
echo ""

echo "Adress IP serveur WSO2 IOT : '${iot_hostname}'"

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

echo ""
echo ""

echo " INSTALL Samples"
echo "Starting wso2iots-3.0.0 QSG setup ..."
cd ${dir_wso2iot}/samples/mobile-qsg
java -jar "mobile-qsg.jar"
echo "Completed!!"
echo ""


echo ""
echo "----------------------------------------"
echo "     OPERATION TERMINE AVEC SUCCES"
echo "----------------------------------------"
echo ""
echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"

