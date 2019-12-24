#!/usr/bin/env bash

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

echo " --------------------------------------------------- -------------"
echo -e " -        ${cyanclair}PARAMETRAGE SERVEUR MESSAGERIE POUR WSO2IOT 3.3.0${neutre}      -"
echo " --------------------------------------------------- -------------"

dir_wso2iot=$(dirname $PWD/wso2iot*/conf)
mail_smtp_host="${1}"
mail_smtp_port="${2}"
mail_smtp_auth="${3}"
mail_smtp_user="${4}"
mail_smtp_password="${5}"
mail_smtp_from="${6}"

dir_wso2iot=$(dirname $PWD/wso2iot*/conf)


echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""

#--------------------
# Please, configure your serveur mail

# Parametrage mail.smtp.host
if [ "${mail_smtp_host}" == "" ]; then
    mail_smtp_host='SSL0.OVH.NET'
fi

#--------------------
# Parametrage mail.smtp.port
if [ "${mail_smtp_port}" == "" ]; then
    mail_smtp_port='587'
fi

#--------------------
# Parametrage mail.smtp.auth
if [ "${mail_smtp_auth}" == "" ]; then
    mail_smtp_auth='true'
fi


#--------------------
# Parametrage mail.smtp.user
if [ "${mail_smtp_user}" == "" ]; then
    mail_smtp_user='contact@nbility.fr'
fi


#--------------------
# Parametrage mail.smtp.password
if [ "${mail_smtp_password}" == "" ]; then
    mail_smtp_password='maldives31'
fi


#--------------------
# Parametrage mail.smtp.from
if [ "${mail_smtp_from}" == "" ]; then
    mail_smtp_from='contact@nbility.fr'
fi


echo ""
echo -e "Nom de votre serveur : "${orange}${mail_smtp_host}${neutre}

echo ""
echo -e "Port de votre serveur : "${orange}${mail_smtp_port}${neutre}

echo ""
echo -e "Parametrage authentification à : "${orange}${mail_smtp_auth}${neutre}

echo ""
echo -e "Login authentification serveur messagerie : "${orange}${mail_smtp_user}${neutre}

echo ""
echo -e "Password authentification serveur messagerie : "${orange}${mail_smtp_password}${neutre}

echo ""
echo -e "Les mails seront envoyé par : "${orange}${mail_smtp_from}${neutre}


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
        echo "Configurer le script pour mettre vos parametrages !"
        exit
        ;;
    esac
done

echo ""
echo ""
echo " ----------------------------------------------------------------- "
echo " -        CONFIGURATION FICHIER <Iot_Home>/conf/axis2/axis2.xml  - "
echo " ----------------------------------------------------------------- "
echo ""

sed -i -e "
   s/check com.sun.mail.smtp package documentation for descriptions of properties/& -->/
   /mail\.smtp\.from./{/mail\.smtp\.from/ s#>[^<]*<#>${mail_smtp_from}<#;n;s/-->//}
   /mail\.smtp\.host/ s#>[^<]*<#>${mail_smtp_host}<#
   /mail\.smtp\.port/ s#>[^<]*<#>${mail_smtp_port}<#
   /mail\.smtp\.auth/ s#>[^<]*<#>${mail_smtp_auth}<#
   /mail\.smtp\.user/ s#>[^<]*<#>${mail_smtp_user}<#
   /mail\.smtp\.password/ s#>[^<]*<#>${mail_smtp_password}<#
" ${dir_wso2iot}/conf/axis2/axis2.xml
echo "Completed!!"


echo ""
echo ""
echo " ------------------------------------------------------------------------ "
echo " -     CONFIGURATION FICHIER <Iot_Home>/conf/output-event-adapters.xml  - "
echo " ------------------------------------------------------------------------ "
echo ""

sed -i -e "
    /mail\.smtp\.host/ s#>[^<]*<#>${mail_smtp_host}<#
    /mail\.smtp\.port/ s#>[^<]*<#>${mail_smtp_port}<#
    /mail\.smtp\.auth/ s#>[^<]*<#>${mail_smtp_auth}<#
    /mail\.smtp\.user/ s#>[^<]*<#>${mail_smtp_user}<#
    /mail\.smtp\.from/ s#>[^<]*<#>${mail_smtp_from}<#
    /mail\.smtp\.password/ s#>[^<]*<#>${mail_smtp_password}<#
 " ${dir_wso2iot}/conf/output-event-adapters.xml
echo "Completed!!"




# echo ""
# echo ""
# echo " --------------------------------------------------------------------------- "
# echo " -    CONFIGURATION FICHIER <Iot_Home>/wso2/analytics/conf/axis2/axis2.xml - "
# echo " --------------------------------------------------------------------------- "
# echo ""
# sed -i -e "
#    s/<!--<transportSender name=\"mailto\"/<transportSender name=\"mailto\"/
#    /mail\.smtp\.auth./{/mail\.smtp\.auth/ s#>[^<]*<#>${mail_smtp_auth}<#;n;s/-->//}
#    /mail\.smtp\.host/ s#>[^<]*<#>${mail_smtp_host}<#
#    /mail\.smtp\.port/ s#>[^<]*<#>${mail_smtp_port}<#
#    /mail\.smtp\.user/ s#>[^<]*<#>${mail_smtp_user}<#
#    /mail\.smtp\.from/ s#>[^<]*<#>${mail_smtp_from}<#
#    /mail\.smtp\.password/ s#>[^<]*<#>${mail_smtp_password}<#
# " ${dir_wso2iot}/wso2/analytics/conf/axis2/axis2.xml
# echo "Completed!!"

echo ""
echo ""
echo " ---------------------------------------------------------------------------------- "
echo " - CONFIGURATION FICHIER <Iot_Home>/wso2/analytics/conf/output-event-adapters.xml - "
echo " ---------------------------------------------------------------------------------- "
echo ""
sed -i -e "
   /mail\.smtp\.host/ s#>[^<]*<#>${mail_smtp_host}<#
   /mail\.smtp\.port/ s#>[^<]*<#>${mail_smtp_port}<#
   /mail\.smtp\.auth/ s#>[^<]*<#>${mail_smtp_auth}<#
   /mail\.smtp\.user/ s#>[^<]*<#>${mail_smtp_user}<#
   /mail\.smtp\.from/ s#>[^<]*<#>${mail_smtp_from}<#
   /mail\.smtp\.password/ s#>[^<]*<#>${mail_smtp_password}<#
" ${dir_wso2iot}/wso2/analytics/conf/output-event-adapters.xml
echo "Completed!!"
 
# echo ""
# echo ""
# echo " --------------------------------------------------------------------- "
# echo " - CONFIGURATION FICHIER <Iot_Home>/wso2/broker/conf/axis2/axis2.xml - "
# echo " --------------------------------------------------------------------- "
# echo ""

# sed -i -e "
#    s/<!--<transportSender name=\"mailto\"/<transportSender name=\"mailto\"/
#    /mail\.smtp\.auth./{/mail\.smtp\.auth/ s#>[^<]*<#>${mail_smtp_auth}<#;n;s/-->//}
#    /mail\.smtp\.host/ s#>[^<]*<#>${mail_smtp_host}<#
#    /mail\.smtp\.port/ s#>[^<]*<#>${mail_smtp_port}<#
#    /mail\.smtp\.user/ s#>[^<]*<#>${mail_smtp_user}<#
#    /mail\.smtp\.from/ s#>[^<]*<#>${mail_smtp_from}<#
#    /mail\.smtp\.password/ s#>[^<]*<#>${mail_smtp_password}<#
# " ${dir_wso2iot}/wso2/broker/conf/axis2/axis2.xml

# echo "Completed!!"

echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"
