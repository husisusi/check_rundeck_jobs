# check_rundeck_jobs for Nagios
Check if all Rundeck jobs succeed and list any failed jobs.
## Works with MYSQL and MariaDB Database.

1. To use it, you have to create readonly DB user on your MYSQL\MariaDB Rundeck DB Server.<br>
2. On Nagios Server you need to install mysql-client.
3. To use it: check_rundeck.sh -H db_host_ip -u db_user -p db_password -d db_name | (optional default=48) -a not_older_than_hours
