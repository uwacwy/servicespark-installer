#!/bin/bash

$WHOAMI=`whoami`

wget https://github.com/cakephp/cakephp/archive/master.zip
unzip master.zip
mv cakephp-master servicespark
mv servicespark/app/Config ./
rm -R servicespark/app
git clone https://github.com/uwacwy/servicespark.git servicespark/app
mv ./Config servicespark/app/
./servicespark/app/Console/cake bake db_config

DATABASE=`php get_variable.php database`
DB_USER=`php get_variable.php login`
DB_PASS=`php get_variable.php password`


echo "Setting up mysql database schema."
echo "DROP DATABASE IF EXISTS $DATABASE" | mysql -u $DB_USER -p$DB_PASS
echo "CREATE DATABASE $DATABASE" | mysql -u $DB_USER -p -p$DB_PASS
mysql -u $DB_USER -p$DB_PASS $DATABASE < install.sql
echo .

sed -n '/Security.salt/d' servicespark/app/Config/core.php
sed -n '/Security.cipherSeed/d' servicespark/app/Config/core.php

php crypto_init.php >> servicespark/app/Config/core.php

echo "Writing configuration files..."
cat bootstrap.php.txt >> servicespark/app/Config/bootstrap.php
cat core.php.txt >> servicespark/app/Config/core.php
echo .

WWW_USER=`ps axo user,group,comm | egrep '(apache|httpd)' | grep -v ^root | uniq | cut -d\  -f 1`

mkdir servicespark/app/tmp
chown -R $WWW_USER:$WWW_USER servicespark/app/tmp/
chmod -R 755 servicespark/app/tmp/