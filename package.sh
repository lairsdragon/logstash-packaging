#!/bin/bash

VERSION=1.1.10
RELEASE=2


#git clone git://github.com/Yuav/logstash-packaging.git --depth=1
# wget http://logstash.objects.dreamhost.com/release/logstash-${VERSION}-monolithic.jar -O logstash-packaging/usr/share/logstash/logstash.jar

if [ ! -f usr/share/logstash/logstash.jar ] ; then 
    wget https://logstash.objects.dreamhost.com/release/logstash-${VERSION}-flatjar.jar 
         -O usr/share/logstash/logstash.jar
fi

fpm -n logstash \
    -v "$VERSION-$RELEASE" \
    -a all \
    -m "Steve Weinreich <steve@weinreich.org>" \
    --pre-install logstash.preinstall \
    --description "Logstash Open Source Log Management" \
    --url 'http://www.logstash.net/' \
    -t deb \
    --deb-user root \
    --deb-group root \
    --config-files etc/logstash/syslog.conf \
    --config-files etc/default/logstash \
    --exclude usr/share/logstash/.gitignore \
    --exclude var/log/README \
    -s dir etc usr var
