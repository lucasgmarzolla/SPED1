#!/bin/sh -e

RUN=/usr/local/tomcat/bin/catalina.sh

case "$1" in
    start)
    	$RUN start
    ;;

    stop)
    	$RUN stop
    ;;

    restart)
        $0 stop
        $0 start
    ;;
    
    *)
	echo "Usage: /etc/init.d/tomcat {start|stop|restart}"
	exit 1
    ;;
esac

exit 0
