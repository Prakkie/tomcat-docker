#! /bin/bash

#setting tomcat admin password. Refer to $CATALINA_HOME/bin/setenv.sh for the password
if [[ ! -f $CATALINA_HOME/bin/setenv.sh || $(grep -EL "ADM_PWD=.*" $CATALINA_HOME/bin/setenv.sh) ]]; then
    echo "ADM_PWD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w16 | head -n1)" > $CATALINA_HOME/bin/setenv.sh
    echo "JAVA_OPTS=-Dadminpwd=\${ADM_PWD}" >> $CATALINA_HOME/bin/setenv.sh
    sed -i.orig '/^<\/tomcat-users>/i <user name="admin" password="${adminpwd}" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status"\/>' $CATALINA_HOME/conf/tomcat-users.xml
    chmod 755 $CATALINA_HOME/bin/setenv.sh
fi

#setting XMX and permsize for tomcat app
if [[ $(grep -FL "JAVA_OPTS=\"\$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx$TOMCAT_XMX -XX:MaxPermSize=$TOMCAT_PERM -XX:+UseConcMarkSweepGC\"" $CATALINA_HOME/bin/setenv.sh) ]]; then
    echo "JAVA_OPTS=\"\$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx$TOMCAT_XMX -XX:MaxPermSize=$TOMCAT_PERM -XX:+UseConcMarkSweepGC\"" >> $CATALINA_HOME/bin/setenv.sh
fi

#setting Tomcat Timezone
if [[ $(grep -FL "CATALINA_OPTS=\"-Duser.timezone=$TZ\"" $CATALINA_HOME/bin/setenv.sh) ]]; then
    echo "CATALINA_OPTS=\"-Duser.timezone=$TZ\"" >> $CATALINA_HOME/bin/setenv.sh
fi

#starting supercronic
supercronic $CATALINA_HOME/logrotate/crontab > /dev/null 2>&1 &

#Starting tomcat
catalina.sh run
