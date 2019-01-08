#Most of these variables need to be defined externally (in Jenkins)
#  These include 
#  CLEAR_DB - (1/0) 
#  MYSQLDB - Host name for MySQL
#  MYSQLQATRUNKDB - Password for this database

BUILD_ID=bin/startup.sh
CATALINA_BASE=/var/trunk-mysql
DBSCRIPT="${WORKSPACE}/master-mysql.sql"
DBNAME=nightly_trunk

cp master.properties ${CATALINA_BASE}/sakai/sakai.properties
cd ${CATALINA_BASE}
bin/catalina.sh stop -force || true
sleep 30

#Only run this between 0 and 4AM
typeset -i chour=10#`/bin/date +"%H"`
typeset -i cday=10#`/bin/date +"%u"`

typeset -i shour=0
typeset -i ehour=4
typeset -i cleardb=${CLEAR_DB:-0}

echo "Current hour is ${chour}. Current day is ${cday}"

if (( (${chour} >= ${shour}) && (${chour} <= ${ehour}) )); then
	cleardb=1
fi

if (( ${cleardb} == 1 )); then
    echo "Clearing database and assets"
    #Remove Assets
	rm -rf /var/sakai-assets/trunk-mysql/*
    rm -rf sakai/elasticsearch/*

	mysql -h ${MYSQLDB}  -u ${DBNAME} -p${MYSQLQATRUNKDB} -e "drop database ${DBNAME}"
	sleep 10
	mysql -h ${MYSQLDB}  -u ${DBNAME} -p${MYSQLQATRUNKDB} -e "create database ${DBNAME} character set utf8"    
fi

rm -rf work/Catalina logs/* webapps components shared/lib/ lib temp/* sakai/archive-unzip/*
tar xzf /tmp/trunkbuild.tar.gz
nohup bin/startup.sh

if (( ${cleardb} == 1 )); then
    if [ -f "${DBSCRIPT}" ]; then
        sleep 15m 
        mysql -f -h ${MYSQLDB} -u ${DBNAME} -p${MYSQLQATRUNKDB} ${DBNAME} -e "source ${DBSCRIPT}"
    fi
fi
