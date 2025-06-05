#!/bin/sh
echo "<?php" >> /wp-config.php
echo "define(""'DB_NAME'"", ""'$DATABASE'"");" >>  /wp-config.php
echo "define(""'DB_USER'"", ""'$DB_USER'"");"  >>   /wp-config.php 
echo "define(""'DB_PASSWORD'"", ""'$USER_PASSWORD'"");" >>  /wp-config.php
echo "define(""'DB_HOST'"", ""'$HOST'"");"   >>  /wp-config.php
echo "define(""'DB_CHAERSET'"", ""'utf8'"");" >> /wp-config.php
echo "define(""'DB_COLLATE'"", ""'utf8_unicode_ci'"");" >> /wp-config.php

echo '$table_prefix'" = 'wp_';" >> /wp-config.php
echo "define(""'WP_DEBUG'"", ""'true'"");" >> /wp-config.php

echo "define(""'WP_DEBUG_LOG'"", ""'true'"");" >> /wp-config.php



echo "if ( ! defined( 'ABSPATH' ) ) {" >> /wp-config.php
echo "	define( 'ABSPATH', __DIR__ . '/' );" >> /wp-config.php
echo "}" >> /wp-config.php  

echo "require_once ABSPATH . 'wp-settings.php';" >> /wp-config.php

cp -rf /wp-config.php /var/www/html/.
rm -rf /var/www/html/wp-config-sample.php

chmod -R 755 /var/www/html

chown -R www-data:www-data /var/www/html

php-fpm -F -R

