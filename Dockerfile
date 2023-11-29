FROM owncloud/server:10.13.3

WORKDIR /tmp

RUN mkdir -p /etc/sudoers.d/

RUN echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/www-data

USER www-data

CMD ["apache2-foreground"]
