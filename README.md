# docker_moodle

== Explanation ==

This directory contains the Docker setup to run an instance of Moodle. A number of containers are created as follows:

* PHP to run the web instance of Moodle - this default install uses PHP 8.0
* PHP (second instance) to run cron - this default install uses PHP 8.0
* nginx as the web server
* redis for cache
* mariadb for database - this uses the latest version

The main configuration is setup in the file docker-compose.yml. Each service is a container and the compose file gives the 
various configuration details for that service. The volumes directives map paths inside the containers to local paths. Note that
local paths are relative to the directory with the compose file. There are no absolute paths.

PHP is slightly more complicated. The default PHP image doesn't have all the extensions we need. We therefore have a
PHP.Dockerfile referenced by the compose file. This tells docker to build a new image using these instructions. As PHP 
sits on a very limited Debian Linux instance most of this file should be fairly obvious. Note that the confiuration files (e.g php.ini)
are in the local folder and copied there on the build. 

The Moodle program and data files are mapped to local directories under this folder so you can access them as normal
without worrying about the containers. 

Network host names are the same as the service names (e.g. just 'redis')

== To set up ==

* Install Docker daemon and get running
* Stop any local instances of web server and mysql
* Make sure you have the docker-compose command installed
* Clone this repo somewhere suitable (everything else is relative to this folder)
* Creat subdirectories app/moodledata app/public. 
* Clone/copy Moodle into app/public (not as a subdir, public itself)
* Copy config.php from here to that directory - modify as required
* app/moodledata should be chmod 0777
* docker-compose up --build -d
* If I haven't missed anything, you should be able to access/install Moodle at localhost
* MySQL should be accessible by your favourite client also at localhost

== NOTES ==

* STACK breaks PHPUnit testing - see, https://github.com/maths/moodle-qtype_stack/issues/729 (a define line is needed).
* This repo can and should be branched and updated to match the version of Moodle you wish to run.
* The version of PHP, Nginx, Redis and MariaDB used will need to be suitable for the environment also.
