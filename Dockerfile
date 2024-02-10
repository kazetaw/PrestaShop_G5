FROM ttsuxz/prestashop-cp:latest

WORKDIR /var/www/html

COPY ./themes ./themes

COPY ./img ./img

COPY ./template ./template

EXPOSE 80