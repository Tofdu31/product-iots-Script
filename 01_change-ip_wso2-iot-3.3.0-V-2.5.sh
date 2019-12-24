#!/bin/bash


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

rm -rf $PWD/tmp_certificats
iot_hostname="${1}"
folder_certificats="${2}"
dir_wso2iot=$(dirname $PWD/wso2iot*/conf)

if [ "${iot_hostname}" == "" ]; then
    iot_hostname='163.172.90.197'
fi

echo ""
echo "---------------------------------------------------"
echo -e "-${cyanclair}   WSO2 IoT Server IP configuration Tool${neutre}         -"
echo "-                                                 -"
echo -e "-${cyanclair}  Replace localhost entires with ${iot_hostname}  ${neutre}-"
echo "---------------------------------------------------"
echo ""
echo "Le nom du répertoire d'installation de WSO2IOT doit étre : wso2iot-3.2.0 ou wso2iot-3.3.x"
echo -e "Actuellement, votre répertoire d'installation est :${orange} ${dir_wso2iot} ${neutre}"
echo ""
echo -e "Adresse IP actuelle : ${orange}${iot_hostname}${neutre} "
echo ""
echo ""
echo -e "Ce script est la propriété intellectuelle de la société NBILITY"
echo "Contact Mail : contact@nbility.fr "

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
echo "----------------------------------------"
echo "WSO2 IoT Server IP configuration tool"
echo "----------------------------------------"


##################################### IP configs related to core ####################################

echo ""
echo ">>> Step 1: Change current IP address of the IoT server"

echo ""
echo "Please enter the IoT Core IP that you need to replace (if you are trying out IoT server for the first time this will be localhost)"
read val1;

while [[ -z $val1 ]]; do #if $val1 is a zero length String
    echo "Please enter the IoT Core IP that you need to replace (if you are trying out IoT server for the first time this will be localhost)"
    read val1;
done

echo ""
echo "Please enter your current IP"
read val2;

while [[ -z $val2 ]]; do #if $val2 is a zero length String
    echo "Please enter your current IP"
    read val2;
done


echo "--------------------------------------"
echo "All your " + $val1 + " IP's are replaced with " +$val2 ;
echo "--------------------------------------"

replaceText='s/localhost/'$val1'/g'

echo "Changing <IoT_HOME>/conf/carbon.xml"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'carbon.xml')
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/conf/app-manager.xml"
sed -i -e "s|<IdentityProviderUrl>https:\/\/localhost:\${mgt.transport.https.port}\/samlsso<\/IdentityProviderUrl>|<IdentityProviderUrl>https:\/\/$val2:\${mgt.transport.https.port}\/samlsso<\/IdentityProviderUrl>|g" ${dir_wso2iot}/conf/app-manager.xml
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/conf/identity/sso-idp-config.xml"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'sso-idp-config.xml')
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/conf/wso2server.sh"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'wso2server.sh')
echo "Completed!!"



#--------------------
echo "Changing  <IoT_HOME>/bin/iot-server.sh"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'iot-server.sh')
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/repository/deployment/server/jaggeryapps/devicemgt/app/conf/app-conf.json"
sed -i -e 's/"identityProvider.*/\"identityProviderUrl\"\ :\ "https\:\/\/'$val2':9443\/samlsso\"\,/' ${dir_wso2iot}/repository/deployment/server/jaggeryapps/devicemgt/app/conf/app-conf.json
sed -i -e 's/"acs.*/\"acs\"\ :\ "https\:\/\/'$val2':9443\/devicemgt\/uuf\/sso\/acs\"\,/' ${dir_wso2iot}/repository/deployment/server/jaggeryapps/devicemgt/app/conf/app-conf.json
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/repository/deployment/server/jaggeryapps/devicemgt/app/conf/config.json"
sed -i -e 's/"androidAgentDownloadURL.*/\"androidAgentDownloadURL\":\ "https\:\/\/\%iot.manager.host\%\:\%iot.manager.https.port\%\/devicemgt\/public\/cdmf.unit.device.type.android.type-view\/assets\/android-agent.apk\",/' ${dir_wso2iot}/repository/deployment/server/jaggeryapps/devicemgt/app/conf/config.json
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/repository/deployment/server/jaggeryapps/api-store/site/conf/site.json"
sed -i -e 's/"identityProvider.*/\"identityProviderURL\"\ :\ "https\:\/\/'$val2':9443\/samlsso\"\,/' ${dir_wso2iot}/repository/deployment/server/jaggeryapps/api-store/site/conf/site.json
echo "Completed!!"

#--------------------
echo "Changing <IoT_HOME>/repository/deployment/server/jaggeryapps/portal/configs/designer.json"
sed -i -e 's/"acs.*/\"acs\"\ :\ "https\:\/\/'$val2':9443\/portal\/acs\"\,/' ${dir_wso2iot}/repository/deployment/server/jaggeryapps/portal/configs/designer.json
echo "Completed!!"

#--------------------
echo "Changing  <IoT_HOME>/conf/api-manager.xml"
if grep -q '<!-- Server URL of the API key manager -->' ${dir_wso2iot}/conf/api-manager.xml;
then
echo "found"
sed -i -e 's|<!-- Server URL of the API key manager -->||' ${dir_wso2iot}/conf/api-manager.xml
fi

if grep -q '<ServerURL>https:\/\/\${carbon.local.ip}:\${mgt.transport.https.port}\${carbon.context}services\/<\/ServerURL>' ${dir_wso2iot}/conf/api-manager.xml;
then
echo "found"
sed -i -e 's/<ServerURL>https:\/\/\${carbon.local.ip}:\${mgt.transport.https.port}\${carbon.context}services\/<\/ServerURL>//' ${dir_wso2iot}/conf/api-manager.xml
fi

if grep -q '<ServerURL>https:\/\/'$val1':\${mgt.transport.https.port}\${carbon.context}services\/<\/ServerURL>' ${dir_wso2iot}/conf/api-manager.xml;
then
echo "found"
sed -i -e 's/<ServerURL>https:\/\/'$val2':\${mgt.transport.https.port}\${carbon.context}services\/<\/ServerURL>//' ${dir_wso2iot}/conf/api-manager.xml
fi
echo "configuration APIKeyValidator"
sed -i -e 's/<APIKeyValidator>/<APIKeyValidator><!-- Server URL of the API key manager --><ServerURL>https:\/\/'$val2'\:\$\{mgt\.transport\.https\.port\}\$\{carbon\.context\}services\/<\/ServerURL>/g' ${dir_wso2iot}/conf/api-manager.xml

echo "Completed !!"

#--------------------
if grep -q '<RevokeAPIURL>https:\/\/localhost:\${https.nio.port}\/revoke<\/RevokeAPIURL>' ${dir_wso2iot}/conf/api-manager.xml;
then
sed -i -e 's|<RevokeAPIURL>https:\/\/localhost:\${https.nio.port}\/revoke<\/RevokeAPIURL>|<RevokeAPIURL>https:\/\/'$val2':\${https.nio.port}\/revoke<\/RevokeAPIURL>|' ${dir_wso2iot}/conf/api-manager.xml
fi

if grep -q '<RevokeAPIURL>https:\/\/'$val1':\${https.nio.port}\/revoke<\/RevokeAPIURL>' ${dir_wso2iot}/conf/api-manager.xml;
then
sed -i -e 's|<RevokeAPIURL>https:\/\/'$val1':\${https.nio.port}\/revoke<\/RevokeAPIURL>|<RevokeAPIURL>https:\/\/'$val2':\${https.nio.port}\/revoke<\/RevokeAPIURL>|' ${dir_wso2iot}/conf/api-manager.xml
fi

#--------------------
echo "Changing <IoT_HOME>/conf/etc/webapp-publisher-config.xml"
perl -pi -e "s/<EnabledUpdateApi>false<\/EnabledUpdateApi>/<EnabledUpdateApi>true<\/EnabledUpdateApi>/g" $(find . -name 'webapp-publisher-config.xml')
echo "Completed!!"



#----------------------
echo ""
echo "Changing hostURL of <IoT_HOME>/wso2/broker/conf/broker.xml"
if grep -q '<property name="hostURL">https://'$val1':9443/services/OAuth2TokenValidationService</property>' ${dir_wso2iot}/wso2/broker/conf/broker.xml;
then
echo "found"
sed -i -e 's|<property name="hostURL">https:\/\/'$val1':9443\/services\/OAuth2TokenValidationService</\property>|<property name="hostURL">https:\/\/'$val2':9443\/services\/OAuth2TokenValidationService</\property>|' ${dir_wso2iot}/wso2/broker/conf/broker.xml
echo "Completed!!"
fi

#------------------------
echo ""
echo "Changing tokenEndpoint of <IoT_HOME>/wso2/broker/conf/broker.xml"
if grep -q '<property name="tokenEndpoint">https:\/\/'$val1':8243</\property>' ${dir_wso2iot}/wso2/broker/conf/broker.xml;
then
echo "found"
sed -i -e 's|<property name="tokenEndpoint">https:\/\/'$val1':8243</\property>|<property name="tokenEndpoint">https:\/\/'$val2':8243</\property>|' ${dir_wso2iot}/wso2/broker/conf/broker.xml
echo "Completed!!"
fi

#--------------------------
echo ""
echo "Changing deviceMgtServerUrl of <IoT_HOME>/wso2/broker/conf/broker.xml"
if grep -q '<property name="deviceMgtServerUrl">https:\/\/'$val1':8243</\property>' ${dir_wso2iot}/wso2/broker/conf/broker.xml;
then
echo "found"
sed -i -e 's|<property name="deviceMgtServerUrl">https:\/\/'$val1':8243</\property>|<property name="deviceMgtServerUrl">https:\/\/'$val2':8243</\property>|' ${dir_wso2iot}/wso2/broker/conf/broker.xml
echo "Completed!!"
fi

#--------------------
echo "Changing  <IoT_HOME>/wso2/analytics/bin/wso2server.sh"
sed -i -e 's/-Diot.keymanager.host.*/-Diot.keymanager.host="'$val2'" \\/' ${dir_wso2iot}/wso2/analytics/bin/wso2server.sh
sed -i -e 's/-Diot.gateway.host.*/-Diot.gateway.host="'$val2'" \\/' ${dir_wso2iot}/wso2/analytics/bin/wso2server.sh
echo "Completed!!"

#--------------------
echo "Changing  <IoT_HOME>/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json"
sed -i -e 's/"identityProviderURL.*/\"identityProviderURL\"\:\"https\:\/\/'$val2':9443\/samlsso\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
sed -i -e 's/"dynamicClientAppRegistrationServiceURL.*/\"dynamicClientAppRegistrationServiceURL\"\:\"https\:\/\/'$val2':9443\/dynamic-client-web\/register\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
sed -i -e 's/"apiManagerClientAppRegistrationServiceURL.*/\"apiManagerClientAppRegistrationServiceURL\"\:\"https\:\/\/'$val2':9443\/api-application-registration\/register\/tenants\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
sed -i -e 's/"tokenServiceURL.*/\"tokenServiceURL\"\: \"https\:\/\/'$val2':9443\/oauth2\/token\"/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
sed -i -e 's/"hostname.*/\"hostname\"\: \"'$val2'\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
echo "Completed!!"

##################################### Modification selon ducomentation #####################################
echo ""
echo "Modification selon documentation pour Inscription automatique d'un périphérique Android via SSL MUTUEL"
echo "https://docs.wso2.com/display/IOTS330/Configuring+the+IP+or+Hostname#ConfiguringtheIPorHostname-ConfiguringtheIPorhostnamemanually"
echo "https://docs.wso2.com/display/IOTS330/Auto+Enrolling+an+Android+Device"
echo ""
#--------------------
echo "Changing <IOTS_HOME>/repository/deployment/server/synapse-configs/default/api/admin--Android-Mutual-SSL-Event-Receiver.xml"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'admin--Android-Mutual-SSL-Event-Receiver.xml')
echo "Completed!!"


#--------------------
echo "Changing <IOTS_HOME>/repository/deployment/server/synapse-configs/default/api/admin--Android-Mutual-SSL-Device-Management.xml"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'admin--Android-Mutual-SSL-Device-Management.xml')
echo "Completed!!"

#--------------------
echo "Changing <IOTS_HOME>/repository/deployment/server/synapse-configs/default/api/admin--Android-Mutual-SSL-Configuration-Management.xml"
perl -pi -e "s/$val1/$val2/g" $(find . -name 'admin--Android-Mutual-SSL-Configuration-Management.xml')
echo "Completed!!"

##################################### IP configs related to broker ####################################
echo ""
echo ""
echo ">>> Step 2: Change current IP address of the IoT Broker"
echo "-------------------------------------------------------"

#--------------------
echo "Changing  <IoT_HOME>/wso2/analytics/bin/wso2server.sh"
sed -i -e 's/-Dmqtt.broker.host.*/-Dmqtt.broker.host="'$val2'" \\/' ${dir_wso2iot}/wso2/analytics/bin/wso2server.sh
echo "Completed!!"

#--------------------
echo "Changing  <IoT_HOME>/bin/iot-server.sh"
sed -i -e 's/-Dmqtt.broker.host.*/-Dmqtt.broker.host="'$val2'" \\/' ${dir_wso2iot}/bin/iot-server.sh
echo "Completed!!"

echo "Changing <IoT_HOME>/wso2/broker/conf/carbon.xml"
sed -i -e "s|<\!--HostName>www.wso2.org</HostName-->|<HostName>$val2</HostName>|g" ${dir_wso2iot}/wso2/broker/conf/carbon.xml
sed -i -e "s|<\!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>$val2</MgtHostName>|g" ${dir_wso2iot}/wso2/broker/conf/carbon.xml
echo "Completed!!"




##################################### IP configs related to analytics ####################################

echo ""
echo ""
echo ">>> Step 3: Change current IP address of the IoT Analytics"
echo "-------------------------------------------------------"



#--------------------
# echo "Changing  <IoT_HOME>/bin/iot-server.sh"
# sed -i -e 's/-Diot.analytics.host.*/-Diot.analytics.host="'$val2'" \\/' ${dir_wso2iot}/bin/iot-server.sh
# echo "Completed!!"

echo "Changing  <IoT_HOME>/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json"
sed -i -e 's/"acs.*/\"acs\"\:\"https\:\/\/'$val2':9445\/portal\/acs\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
sed -i -e 's/"callbackUrl.*/\"callbackUrl\"\:\"https\:\/\/'$val2':9445\/portal\"\,/' ${dir_wso2iot}/wso2/analytics/repository/deployment/server/jaggeryapps/portal/configs/designer.json
echo "Completed!!"

echo "Changing <IoT_HOME>/wso2/analytics/conf/carbon.xml"
sed -i -e "s|<\!--HostName>www.wso2.org</HostName-->|<HostName>$val2</HostName>|g" ${dir_wso2iot}/wso2/analytics/conf/carbon.xml
sed -i -e "s|<\!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>$val2</MgtHostName>|g" ${dir_wso2iot}/wso2/analytics/conf/carbon.xml
echo "Completed!!"

echo ""
echo "Changing  <IoT_HOME>/wso2/analytics/bin/load-spark-env-vars.sh"
echo "See documentation : https://docs.wso2.com/display/DAS310/Exposing+WSO2+DAS+with+Host+Names"
echo " Ajout variable : export SPARK_LOCAL_IP=\"${iot_hostname}\" "
echo ""
perl -i -lne'print ; print "export SPARK_LOCAL_IP=\"'${iot_hostname}'\"" if /Loading spark environment variables/' $(find . -name 'load-spark-env-vars.sh')



##################################### Generating SSL certificates for the IoT Server ####################################

echo ""
echo "-----------------------------------------------"
echo "Generating SSL certificates for the IoT Server"
echo "-----------------------------------------------"
echo ""

mkdir $PWD/tmp_certificats

if [ "${folder_certificats}" == "" ]; then
    folder_certificats=$(dirname $PWD/tmp_certificats/*)
fi

echo ""
echo "Create folder custom_certificates in '${dir_wso2iot}' "
mkdir ${dir_wso2iot}/custom_certificates
echo "Completed!!"
echo ""

SSL_PASS='wso2carbon'

echo ""
echo ""
echo "Create selfsigned.jks"
keytool -genkey -alias ${SSL_PASS} -keyalg RSA -keysize 4096 \
    -keypass wso2carbon -keystore ${folder_certificats}/selfsigned.jks -storepass wso2carbon \
    -dname "cn=${iot_hostname}, ou=Service Informatique, o=NBILITY, l=TOULOUSE, st=HT, c=FR" \
    -ext SAN=DNS:localhost,IP:127.0.0.1,IP:${iot_hostname}
echo "Completed!!"
echo ""

echo ""
echo ""
echo "Create public.cert"
keytool -export -alias ${SSL_PASS} -keystore ${folder_certificats}/selfsigned.jks \
    -rfc -storepass wso2carbon -file ${folder_certificats}/public.cert
echo "Completed!!"
echo ""

echo ""
echo ""
echo "Grab the existing keystores"
# Grab the existing keystores to be fixed (it is assumed that they're all the same)
# cp --verbose $(find wso2iot* -name 'client-truststore.jks' | head -1) .
# cp --verbose $(find wso2iot* -name 'wso2carbon.jks' | head -1) .
# cp --verbose $(find wso2iot* -name 'wso2certs.jks' | head -1) .

cp --verbose $(find wso2iot* -name 'client-truststore.jks' | head -1) ${folder_certificats}
cp --verbose $(find wso2iot* -name 'wso2carbon.jks' | head -1) ${folder_certificats}
cp --verbose $(find wso2iot* -name 'wso2certs.jks' | head -1) ${folder_certificats}

# find wso2iot* -name 'client-truststore.jks' -exec sh -c cp --verbose ${folder_certificats} sh {} +
# find wso2iot* -name 'wso2carbon.jks' -exec sh -c cp --verbose ${folder_certificats} sh {} +
# find wso2iot* -name 'wso2certs.jks' -exec sh -c cp --verbose ${folder_certificats} sh {} +

echo "Completed!!"
echo ""


# Clear out the existing entry for this alias
keytool -delete -alias ${SSL_PASS} -keystore ${folder_certificats}/client-truststore.jks \
    -storepass wso2carbon

# Re-add the new entry for this alias
keytool -import -noprompt -trustcacerts -alias ${SSL_PASS} -file ${folder_certificats}/public.cert \
    -keystore ${folder_certificats}/client-truststore.jks -storepass wso2carbon

# Clear out the existing entry for this alias
keytool -delete -alias ${SSL_PASS} \
    -keystore ${folder_certificats}/wso2carbon.jks -storepass wso2carbon

keytool -import -noprompt -trustcacerts -alias ${SSL_PASS} -file ${folder_certificats}/public.cert \
    -keystore ${folder_certificats}/wso2carbon.jks -storepass wso2carbon

keytool -importkeystore -srckeystore ${folder_certificats}/selfsigned.jks -destkeystore ${folder_certificats}/keystore.p12 \
    -deststoretype PKCS12 -deststorepass wso2carbon -srcstorepass wso2carbon
keytool -importkeystore -noprompt \
    -srckeystore ${folder_certificats}/keystore.p12 -srcstoretype PKCS12 -srcstorepass wso2carbon \
    -destkeystore ${folder_certificats}/wso2carbon.jks -deststorepass wso2carbon

# Fix the certificate ${folder_certificats}/wso2certs.jks :
# in <IOTS_HOME>/conf/certificate-config.xml
# Alias wso2carbon default is :
# Owner: EMAILADDRESS=dilshan@wso2.com, CN=10.10.10.97, OU=Mobile, O=WSO2, L=Colombo, ST=Western, C=LK
# Issuer: EMAILADDRESS=root@wso2.com, CN=WSO2 Root CA, OU=Test org unit, O=Test Org, L=Test, ST=Test, C=US
# This information has been changed with your IP address
# Is very important If you want to communicate the WSO2 agent with the WSO2 IOT server in HTTPS
# Look here : https://docs.wso2.com/display/EMM200/Generating+a+BKS+File+for+Android

# Clear out the existing entry for this alias
keytool -delete -alias ${SSL_PASS} -keystore ${folder_certificats}/wso2certs.jks -storepass wso2carbon

# Re-add the new entry for this alias
keytool -import -noprompt -trustcacerts -alias ${SSL_PASS} -file ${folder_certificats}/public.cert \
    -keystore ${folder_certificats}/wso2certs.jks -storepass wso2carbon


# Make sure you paste the contents of ugh.txt into iot_default.xml
# XXX FIXME XXX Make the script do this automagically
cat ${folder_certificats}/public.cert | sed '1d;$d' | tr -d '\r\n' > ${folder_certificats}/ugh.txt

# Put the keystores in the desired locations
for target in $(find wso2iot* -name 'wso2carbon.jks'); do
    cp --verbose ${folder_certificats}/wso2carbon.jks ${target}
done

for target in $(find wso2iot* -name 'client-truststore.jks'); do
    cp --verbose ${folder_certificats}/client-truststore.jks ${target}
done

for target in $(find wso2iot* -name 'wso2certs.jks'); do
    cp --verbose ${folder_certificats}/wso2certs.jks ${target}
done

# Fix the certificate payload in iot_default.xml
cat ${folder_certificats}/public.cert | sed '1d;$d' | tr -d '\r\n' > ${folder_certificats}/ugh.txt
for target in $(find . -name 'iot_default.xml'); do
    xmlstarlet ed --omit-decl --pf \
        --update '//IdentityProvider/Certificate' \
        --value $(cat ${folder_certificats}/ugh.txt) \
        ${target} > ${target}.new
    mv ${target}.new ${target}
done



# Fix the certificate for Configuring Keystores in WSO2 DAS

# echo ""
# echo "-------------------------------------"
# echo "-  Configuration keystore for DAS   -"
# echo "-------------------------------------"
# echo ""



#--------------------
# echo ""
# echo "Changing configuration <IoT_HOME>/conf/etc/jwt.properties"
# sed -i -e 's/#KeyStore=.*/KeyStore=repository\/resources\/security\/${folder_certificats}/wso2carbon.jks /' ${dir_wso2iot}/conf/etc/jwt.properties
# sed -i -e 's/#KeyStorePassword=.*/KeyStorePassword=wso2carbon /' ${dir_wso2iot}/conf/etc/jwt.properties
# sed -i -e 's/#PrivateKeyAlias=.*/PrivateKeyAlias=wso2carbon /' ${dir_wso2iot}/conf/etc/jwt.properties
# sed -i -e 's/#PrivateKeyPassword=.*/PrivateKeyPassword=wso2carbon /' ${dir_wso2iot}/conf/etc/jwt.properties
# sed -i -e 's/#default-jwt-client=.*/default-jwt-client=false /' ${dir_wso2iot}/conf/etc/jwt.properties
# echo "Completed!!"
# echo ""

#--------------------
# echo ""
# echo "Changing  configuration <IoT_HOME>/wso2/analytics/conf/etc/jwt.properties"
# sed -i -e 's/#KeyStore=.*/KeyStore=repository\/resources\/security\/${folder_certificats}/wso2carbon.jks /' ${dir_wso2iot}/wso2/analytics/conf/etc/jwt.properties
# sed -i -e 's/#KeyStorePassword=.*/KeyStorePassword=wso2carbon /' ${dir_wso2iot}/wso2/analytics/conf/etc/jwt.properties
# sed -i -e 's/#PrivateKeyAlias=.*/PrivateKeyAlias=wso2carbon /' ${dir_wso2iot}/wso2/analytics/conf/etc/jwt.properties
# sed -i -e 's/#PrivateKeyPassword=.*/PrivateKeyPassword=wso2carbon /' ${dir_wso2iot}/wso2/analytics/conf/etc/jwt.properties
# sed -i -e 's/#default-jwt-client=.*/default-jwt-client=false /' ${dir_wso2iot}/wso2/analytics/conf/etc/jwt.properties
# echo "Completed!!"
# echo ""

#--------------------
echo ""
echo "-------------------------------------------------"
echo "Create certificate.pem for IOT DEVICE MANAGEMENT"
echo "-------------------------------------------------"
keytool -exportcert -keystore ${folder_certificats}/wso2carbon.jks -alias wso2carbon -file ${folder_certificats}/exportcert.pem -storepass wso2carbon
openssl x509 -inform der -in ${folder_certificats}/exportcert.pem -out ${dir_wso2iot}/custom_certificates/certificate.pem 
echo "Completed!!"
echo "Certificate in '${dir_wso2iot}'/custom_certificates/ "

echo ""
echo -e ${cyanclair}" OPERATION TERMINE AVEC SUCCES${neutre}"
echo ""
read -p "Configuration effectué ! Presser une touche pour continuer"

