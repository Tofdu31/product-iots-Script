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

Add this (Be careful :Change VERSION NUMBER WITH YOUR NUMBER VERSION OF JAVA) 
NUMBER VERSION : java -version

```sh
# Variable Environnement pour  JAVA 1.8.0.131
export JAVA_HOME=/opt/java/jdk1.8.0_131
export JRE_HOME=/opt/java/jdk1.8.0_131/jre
export PATH=$PATH:/opt/java/jdk1.8.0_131/bin:/opt/java/jdk1.8.0_131/jre/bin

# Variable Environnement pour Keytool JAVA 8
export KEYTOOL=/opt/java/jdk1.8.0_131/jre
export PATH=$PATH:$KEYTOOL/bin
```
