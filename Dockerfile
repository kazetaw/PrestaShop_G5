FROM ttsuxz/prestashop-cp:latest

WORKDIR /var/www/html
COPY . ./img
COPY . ./themes

EXPOSE 80