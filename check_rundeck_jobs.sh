#!/bin/bash
############################
DBUSER=""            # DB USERNAME
DBPASS=""            # DB PASSWORD
DBHOST=""            # RUNDECK DB Server HOSTNAME
DBNAME=""            # DB Name
############################

data=$(echo "select rundeck.base_report.report_id,rundeck.base_report.date_started,rundeck.base_report.status from rundeck.base_report WHERE rundeck.base_report.status NOT LIKE 'succeed'"\
| mysql -D${DBNAME} -u${DBUSER} -h${DBHOST} -p${DBPASS} -N)

data1=$(echo $data | awk 'NF>1{print $NF}')


if [ "${data1}" = '' ]; then
                echo "OK - All succeed "
                exit 0

         elif [ "${data1}" = 'fail' ]; then
                echo "CRITICAL - one or more jobs fail, please check...\n $data"
                exit 2
        else
                echo "UNKNOWN - $data"
                exit 3
fi
