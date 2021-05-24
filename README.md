# check_rundeck_jobs for Nagios
Check if all Rundeck jobs succeed and list any failed jobs.
## Works with MYSQL and MariaDB Database.

1. To use it, you have to create readonly DB user on your MYSQL\MariaDB Rundeck DB Server.<br>
2. On Nagios Server you need to install mysql-client.
3. To use it: check_rundeck.sh -H DB_HOST_AP -u DB_USER -p DB_Password -d DB_Name | (optional default=48) -a Not_Older_Than_Hours
