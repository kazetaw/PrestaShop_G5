FROM ttsuxz/prestashop-cp:latest

WORKDIR /var/www/html

COPY ./themes ./themes
COPY ./img ./img

COPY ./web/img-cp/logo.png ./img/logo.png

COPY ./template ./template

EXPOSE 80