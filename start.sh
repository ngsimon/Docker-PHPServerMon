#!/bin/sh

cat <<EOF > /app/config.php
<?php
define('PSM_DB_PREFIX', $PSM_DB_PREFIX);
define('PSM_DB_USER', $PSM_DB_USER);
define('PSM_DB_PASS', $PSM_DB_PASS);
define('PSM_DB_NAME', $PSM_DB_NAME);
define('PSM_DB_HOST', $PSM_DB_HOST);
define('PSM_DB_PORT', $PSM_DB_PORT);
define('PSM_BASE_URL', $PSM_BASE_URL);
EOF
chown www-data:www-data /app/config.php
UPDATE_INTERVAL=$UPDATE_INTERVAL /usr/bin/supervisord
