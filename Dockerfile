# ------------------------------------------------------------------------------
# Based on a work at https://github.com/docker/docker.
# ------------------------------------------------------------------------------
# Pull base image.
FROM mysql:latest

MAINTAINER Kevin Delfour <kevin@delfour.eu>

# ------------------------------------------------------------------------------
# Install extra libraries

# ------------------------------------------------------------------------------
# Install extra scripts
ADD backup.sh /usr/local/bin/backup-db.sh
RUN chmod a+x /usr/local/bin/backup-db.sh
RUN echo "@weekly root /usr/local/bin/backup-db.sh" >> /etc/crontab

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME ["/var/mysql-backup"]