# servicespark-installer


This script will install ServiceSpark to a directory.

# Before you begin
1. You will need to know your database server information
2. Your database user must be able to create databases. Otherwise, you will need to create the database beforehand.

# Step 1
Run this command in an empty directory
`git clone https://github.com/uwacwy/servicespark-installer.git; cd servicespark-installer; ./install.sh `

# Step 2
Replace your http root directory with the contents of `servicespark`

# Step 3 (optional)
If you get file permission errors when you try to load your site, run the following commands.  (you will need super powers)
```bash
sudo chown www-data:www-data servicespark/app/tmp/
sudo chmod -R 755 servicespark/app/tmp/
```

By default, ServiceSpark will be in Debug mode.  Change ServiceSpark to production mode by changing the app/Config/core.php file.
