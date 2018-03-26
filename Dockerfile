FROM ubuntu:16.04
MAINTAINER Incode Software, incode.org
ARG RACKTABLES_VERSION=0.21.1
ARG RACKTABLES_HOME=/rt
COPY RackTables-${RACKTABLES_VERSION}.tar.gz ./
RUN apt-get update && \
    apt-get install -y apache2-bin libapache2-mod-php7.0 php7.0-gd php7.0-mysql php7.0-mbstring php7.0-bcmath php7.0-json php7.0-snmp php7.0-ldap && \
    rm -rf /var/www/* && \
    mkdir -p ${RACKTABLES_HOME} && \
    tar xzf RackTables-${RACKTABLES_VERSION}.tar.gz --strip-components=1 -C ${RACKTABLES_HOME} && \
    mv ${RACKTABLES_HOME}/wwwroot/* /var/www/ && \
    sed -i -e "s@DocumentRoot /var/www/html@DocumentRoot /var/www/@g" /etc/apache2/sites-available/000-default.conf && \
    touch '/var/www/inc/secret.php' && \
    chmod a=rw '/var/www/inc/secret.php'
EXPOSE 80
CMD apachectl -D FOREGROUND
