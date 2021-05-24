#!/bin/bash
set -e
AGE=48

while getopts H:u:p:d:a: flag
do
    case "${flag}" in
        H) DBHOST=${OPTARG};;
        u) DBUSER=${OPTARG};;
        p) DBPASS=${OPTARG};;
        d) DBNAME=${OPTARG};;
        a) AGE=${OPTARG};;
    esac
done

if [ $# -lt 8 ]
  then
    echo "No enough arguments supplied!!!"
    echo "To use it do: check_rundeck.sh -H DB_HOST_AP -u DB_USER -p DB_Password -d DB_Name"
    echo "(optional default=48) -a Not_Older_Than_Hours"
exit
fi

data=$(echo "select rundeck.base_report.report_id,rundeck.base_report.date_started,rundeck.base_report.status from rundeck.base_report WHERE rundeck.base_report.status NOT LIKE 'succeed' AND rundeck.base_report.date_started > DATE_SUB(NOW(), INTERVAL ${AGE} HOUR)"\
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
