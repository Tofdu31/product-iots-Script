#!/usr/bin/env bash

# https://cwiki.apache.org/confluence/display/STRATOS/4.1.x+Changing+User+Passwords+in+the+Database
# https://docs.wso2.com/display/IoTS310/Changing+the+Password
# https://docs.wso2.com/display/IoTS310/Changing+the+Password#34d4b8ffd1d24d258133a7c536b6b9dc
# https://docs.wso2.com/display/IoTS310/Working+with+Databases

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


# variables Parametrages script
password="${1}"
iot_hostname="${2}"
db_username="${3}"
db_password="${4}"
dir_wso2iot=$(dirname $PWD/wso2iot*/conf)

# Passworf of super administrator
if [ "${password}" == "" ]; then
    password='UkjkGiqX5g351s'
fi
# -------------------------------

if [ "${iot_hostname}" == "" ]; then
    iot_hostname='163.172.90.197'
fi

if [ "${db_username}" == "" ]; then
    db_username='wso2iot'
fi

if [ "${db_password}" == "" ]; then
    db_password='admin'
fi
# Fin variables Parametrages script



echo ""
echo " --------------------------------------------------------"
echo -e " - ${cyanclair} WSO2 IoT Server Change PASSWORD SUPER ADMINISTRATOR${neutre} -"
echo -e " - ${cyanclair} Ecrit par : Christophe Laborde  ${neutre}                    -"
echo -e " - ${cyanclair} Contact : christophe.laborde@nbility.fr  ${neutre}           -"
echo " --------------------------------------------------------"
echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.1.x ou wso2iot-3.3.0"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""
echo ""
echo -e "IP ADDRESS DATABASE : ${orange} $iot_hostname ${neutre}"
echo -e "User Database : ${orange} $db_username ${neutre}"
echo -e "Password Database actuel ${jaune} $db_password ${neutre}"
echo ""
echo -e "Le password sera remplacé par ${bleuclair} ${password} ${neutre}"
echo ""
echo ""
echo " -----------------------------------------------"
echo -e " - ${grisclair}              PROCEDURE${neutre}                     -"
echo -e " - ${violetclair} 1. SOUS WSO2IOT DEVICE MANAGER${neutre}             -"
echo -e " - ${violetclair} 2. REMPLACER LE MOT DE PASSE ADMIN  ${neutre}       -"
echo -e " - ${violetclair} 3. Arreter ensuite l'ensemble des services${neutre} -"
echo -e " - ${violetclair} 4. Puis executer ce script   ${neutre}              -"
echo " -----------------------------------------------"
echo ""
PS3='> '   # le prompt
echo ""
echo ""
echo "Les parametrages sont ils correct ?"
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
        echo "Editer le script afin de parametrer les valeurs correctement"
        echo "Mettre le nouveau mot de passe en ligne 40 du script"
        echo ""
        exit
        ;;
    esac
done


echo ""
echo ""
echo "Change Password... Please wait"
echo ""


perl -pi -e "s/<AdminPassword>admin<\/AdminPassword>/<AdminPassword>$password<\/AdminPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 01/37 Completed !!!"

perl -pi -e "s/<Password>admin<\/Password>/<Password>$password<\/Password>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 02/37 Completed !!!"

perl -pi -e "s/<password>admin<\/password>/<password>$password<\/password>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 03/37 Completed !!!"

perl -pi -e "s/<DASPassword>admin<\/DASPassword>/<DASPassword>$password<\/DASPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 04/37 Completed !!!"

perl -pi -e "s/<DASPassword>admin<\/DASPassword>/<DASPassword>$password<\/DASPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 05/37 Completed !!!"

perl -pi -e "s/<property name="Password">admin<\/property>/<property name="Password">$password<\/property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 06/37 Completed !!!"

perl -pi -e "s/<property name="password">admin<\/property>/<property name="password">$password<\/property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 07/37 Completed !!!"

perl -pi -e "s/<Property name="AuthPass">admin<\/Property>/<Property name="AuthPass">$password<\/Property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 08/37 Completed !!!"

perl -pi -e "s/<Property name="authPass">admin<\/Property>/<Property name="AuthPass">$password<\/Property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 09/37 Completed !!!"

perl -pi -e "s/<remoteServerPassword>admin<\/remoteServerPassword>/<remoteServerPassword>$password<\/remoteServerPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 10/37 Completed !!!"

perl -pi -e "s/\"password\": \"admin\"/\"password\": \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 11/37 Completed !!!"

perl -pi -e "s/\"Password\">admin<\/Parameter>/\"Password\">$password<\/Parameter>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 12/37 Completed !!!"

perl -pi -e "s/\"password\":\"admin\"/\"password\":\"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 13/37 Completed !!!"

perl -pi -e "s/password=admin/password=$password/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 14/37 Completed !!!"

perl -pi -e "s/<property key=\"password\">admin<\/property>/<property key=\"password\">$password<\/property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 15/37 Completed !!!"

perl -pi -e "s/<Property name=\"ConnectionPassword\">admin<\/Property>/<Property name=\"ConnectionPassword\">$password<\/Property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 16/37 Completed !!!"

perl -pi -e "s/log4j.appender.LOGEVENT.password=admin/log4j.appender.LOGEVENT.password=$password/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 17/37 Completed !!!"

perl -pi -e "s/<Property name=\"Password\">admin<\/Property>/<Property name=\"Password\">$password<\/Property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 18/37 Completed !!!"

perl -pi -e "s/<property name=\"password\" value=\"admin\"\/>/<property name=\"password\" value=\"$password\"\/>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 19/37 Completed !!!"

perl -pi -e "s/<property name=\"archivedPassword\" value=\"admin\"\/>/<property name=\"archivedPassword\" value=\"$password\"\/>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 20/37 Completed !!!"

perl -pi -e "s/<Parameter Name=\"Password\">admin<\/Parameter>/<Parameter Name=\"Password\">$password<\/Parameter>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 21/37 Completed !!!"

perl -pi -e "s/UserManager.AdminUser.Password=\[admin\]/UserManager.AdminUser.Password=\[$password\]/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 22/37 Completed !!!"

perl -pi -e "s/<user username=\"admin\" password=\"admin\"/<user username=\"admin\" password=\"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 23/37 Completed !!!"

perl -pi -e "s/\"adminPassword\": \"admin\"/\"adminPassword\": \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 24/37 Completed !!!"

perl -pi -e "s/\"registryPassword\" : \"admin\"/\"registryPassword\" : \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo "Search N° 25/37 Completed !!!"

perl -pi -e "s/<property name=\"password\">admin<\/property>/<property name=\"password\">$password<\/property>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e "Search N° 26/37 Completed !!!"

perl -pi -e "s/<adminPassword>admin<\/adminPassword>/<adminPassword>$password<\/adminPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e "Search N° 27/37 Completed !!!${neutre}"

perl -pi -e "s/<DASPassword>admin<\/DASPassword>/<DASPassword>$password<\/DASPassword>/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 28/37 Completed !!!"

perl -pi -e "s/password = \"admin\"/password = \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 29/37 Completed !!!"

perl -pi -e "s/password: \'admin\'/password: \'$password\'/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 30/37 Completed !!!"

perl -pi -e "s/\"password\", \"admin\"/\"password\", \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 31/37 Completed !!!"

perl -pi -e "s/\"password\", \"admin\"/\"password\", \"$password\"/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 32/37 Completed !!!"

perl -pi -e "s/Password=\[admin\]/Password=\[$password\]/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 33/37 Completed !!!"

perl -pi -e "s/password=\[admin\]/password=\[$password\]/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 34/37 Completed !!!"

perl -pi -e "s/\"Password\">admin/\"Password\">$password/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 35/37 Completed !!!"

perl -pi -e "s/\"password\">admin/\"password\">$password/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 36/37 Completed !!!"

perl -pi -e "s/password=\'admin\'/password=\'$password\'/g" $(find -type f -regex ".*/.*\.\(xml\|json\|properties\|js\|jag\)")
echo -e ${cyanclair}"Search N° 37/37 Completed !!!"


echo ""
echo ""




# https://cwiki.apache.org/confluence/display/STRATOS/4.1.x+Changing+User+Passwords+in+the+Database
# Note - Please shut down the WSo2 IOT server before execute the chpasswd.sh and if you got error "Database driver not found in classpath" please add the DB driver to the <WSO2_IOT>/lib folder and execute the command.
# http://malantech.blogspot.fr/2016/06/how-to-change-wso2-carbon-product.html
# Download drivers here : https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz

# echo " Changing User Passwords in the Carbon Database H2"
# ${dir_wso2iot}/bin/chpasswd.sh --db-url "jdbc:h2:${dir_wso2iot}/repository/database/WSO2CARBON_DB"
# echo "Completed !!!"
echo ""

#echo " Changing User Passwords in the Carbon Database MYSQL"
# ${dir_wso2iot}/bin/chpasswd.sh --db-driver com.mysql.jdbc.Driver --db-username $db_username --db-password $db_password --username admin --new-password $password --db-url jdbc:mysql://$iot_hostname:3306/WSO2_CARBON_DB
# ${dir_wso2iot}/bin/chpasswd.sh --db-driver "com.mysql.jdbc.Driver" --db-url "jdbc:mysql://127.0.0.1:3306/WSO2_CARBON_DB"  --db-username "wso2iot" --db-password "73KfUP83MUTmqx4n" --username "admin" --new-password "123456"
# echo "Completed !!!"
echo ""
echo ""
echo -e "Password Super administrator changed !!! The news password is : ${bleuclair} ${password} ${neutre}"
echo ""
echo ""
echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Presser une touche pour continuer pour quitter..."
