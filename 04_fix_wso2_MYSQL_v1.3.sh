#!/usr/bin/env bash

# Work with MYSQL


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

dir_wso2iot=$(dirname $PWD/wso2iot*/conf)

db_hostname="${1}"
db_username="${2}"
db_password="${3}"
iot_hostname="${4}"

if [ "${db_hostname}" == "" ]; then
    db_hostname='127.0.0.1'
fi

if [ "${db_username}" == "" ]; then
    db_username='wso2iot'
fi

if [ "${db_password}" == "" ]; then
    db_password='73KfUP83MUTmqx4n'
fi

if [ "${iot_hostname}" == "" ]; then
    iot_hostname='163.172.90.197'
fi


echo "------------------------------------"
echo -e "-${cyanclair}          WSO2 IOT 3.1.x       ${neutre}   -"
echo -e "-${cyanclair}        Working with MYSQL.    ${neutre}   -"
echo "------------------------------------"
echo ""
echo ""

echo -e "Point at database server ${orange}${db_hostname}${neutre} as user ${orange}${db_username}${neutre} with password ${orange}${db_password}${neutre}"

echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""


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
        echo ""
        echo ""
        exit
        ;;
    esac
done

echo ""
echo ""

# Fix all driver, username and password values
for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource/definition/configuration/driverClassName' \
        --value 'com.mysql.jdbc.Driver' \
        ${file} > ${file}.new
    mv ${file}.new ${file}
    xmlstarlet ed --omit-decl --pf \
        --update '//username' \
        --value "${db_username}" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
    xmlstarlet ed --omit-decl --pf \
        --update '//password' \
        --value "${db_password}" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

# https://stackoverflow.com/questions/11133759/0000-00-00-000000-can-not-be-represented-as-java-sql-timestamp-error

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2AM_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_AM_DB?zeroDateTimeBehavior=convertToNull" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_CARBON_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_CARBON_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2APPM_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_APPM_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_MB_STORE_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_MB_STORE_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="JAGH2"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/ES_STORAGE" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_SOCIAL_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_SOCIAL_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_REGISTRY_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_CARBON_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_METRICS_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_METRICS_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="Android_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_ANDROID_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="DM_DS"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_DM_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_ANALYTICS_EVENT_STORE_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/ANALYTICS_EVENT_STORE" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/ANALYTICS_PROCESSED_DATA_STORE" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="Windows_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_WINDOWS_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done

for file in $(find . -name '*-datasources.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//datasource[name="WSO2_GEO_DB"]/definition/configuration/url' \
        --value "jdbc:mysql://${db_hostname}:3306/WSO2_GEO_DB" \
        ${file} > ${file}.new
    mv ${file}.new ${file}
done


echo ""
echo ""
echo "----------------------------------------------"
echo "CONFIGURATION BASE DE DONNEE MYSQL EFFECTUE"
echo "----------------------------------------------"
echo ""
echo ""

echo "Copie de MySQL Java connector 5.1.43 pour la liaison serveur -> base de donnée sql"
rm -rf $PWD/mysql-connector-java*
echo "Download mysql-connector"
echo ""
echo ""
wget https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz
tar xzf mysql-connector-java-5.1.43.tar.gz
echo "Completed !!!"
echo ""

echo "Copy mysql-connector-java"
cp -a $PWD/mysql-connector-java-5.1.43/* ${dir_wso2iot}/lib
cp -a $PWD/mysql-connector-java-5.1.43/* ${dir_wso2iot}/wso2/lib
echo "Completed !!!"
echo ""

echo ""
echo ""
echo "-----------------------------------"
echo "WSO2 IOT WITH MYSQL COMPLETED !!! -"
echo "-----------------------------------"
echo ""
echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"
