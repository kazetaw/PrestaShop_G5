FROM ttsuxz/prestashop-cp:latest

WORKDIR /var/www/html

COPY ./themes ./themes

COPY ./img ./img

COPY ./classes ./classes

COPY ./controllers ./controllers

COPY ./modules ./modules

COPY ./pdf ./pdf


EXPOSE 80