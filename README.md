# product-iots-Script
Script for customise change localhost with your IP + Certificate + Password admin

## XMLSTARLET
This script run with xmlstarlet. Install on your server XMLSTARLET : apt-get install xmlstarlet

## JAVA Environnement
Install on your server jre-8u202-linux-x64.tar.gz
And after check with: java -version

## JAVA_HOME & KEYTOOL
On your console, type cd $HOME
After type : nano .bashrc

Add this 
Be careful : Change
```sh
VERSION NUMBER
```
WITH YOUR NUMBER VERSION OF JAVA
NUMBER VERSION : java -version

```sh
# Variable Environnement pour  JAVA NUMBER VERSION
export JAVA_HOME=/opt/java/jdkNUMBER VERSION
export JRE_HOME=/opt/java/jdkNUMBER VERSION/jre
export PATH=$PATH:/opt/java/jdkNUMBER VERSION/bin:/opt/java/jdkNUMBER VERSION/jre/bin

# Variable Environnement pour Keytool JAVA 8
export KEYTOOL=/opt/java/jdkNUMBER VERSION/jre
export PATH=$PATH:$KEYTOOL/bin
```
For update , execute the command
```sh
source ~/.bashrc
```

## INSTALL MAVEN
VERY IMPORTANT, for installation MAVEN, don't use the command : apt-get install maven  It's forbitten if you want to use WSO2IOT

Download maven here : https://maven.apache.org/download.cgi?Preferred=http%3A%2F%2Fapache.crihan.fr%2Fdist%2F
The command for MAVEN 3.6.3: 
```sh
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
```
Unzip the archive in /opt

On ROOT :
```sh
cd $HOME
```
And
```sh
cd nano .bashrc
```
ADD :
```sh
# Variable Environnement MAVEN
export MAVEN_HOME=/opt/apache-maven-3.6.3
export M2_HOME=/opt/apache-maven-3.6.3
export PATH=${M2_HOME}/bin:${PATH}
export PATH=/opt/apache-maven-3.6.3/bin:$PATH
MAVEN_OPTS=" -Xms512m -Xmx1024m -XX:MaxPermSize=1024m"
export MAVEN_OPTS
```
For update , execute the command
```sh
source ~/.bashrc
```
For check your install :
```sh
mvn -version
```

## INSTALL Change_Password_Super_Administrator
For this script be careful. It's ok with version of 3.3.0.

But with the version 3.3.1, in my script 08_Change_Password_Super_Administrator_v3.3.sh change the variable
find :
```sh
${password}
```
Replace
```sh
{NEW_ADMIN_PASSWORD}
```
### Procedure for changing a password
First :
Connect to wso2IOT and change your password
After shutdown the server
Second:
Change the variable in 08_Change_Password_Super_Administrator_v3.3.sh if you use 3.3.1
And then, Execute the Procedure for changing a password 08_Change_Password_Super_Administrator_v3.3.sh


# INFORMATION
All of these scripts work for me.
They are provided to you only for a test basis.
It modifies the Wso2 broker - Wso2 Carbon and Wso2 IOT

I cannot be responsible for the use of these scripts and what you do with them!
