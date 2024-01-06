FROM node:alpine AS build
WORKDIR /app
COPY package.json package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM httpd
COPY --from=build /app/dist/angular-with-ssl-container/ /usr/local/apache2/htdocs/
COPY container.crt container.key /usr/local/apache2/conf/
COPY httpd.conf /usr/local/apache2/conf/
COPY httpd-ssl.conf /usr/local/apache2/conf/extra/
EXPOSE 80
EXPOSE 443