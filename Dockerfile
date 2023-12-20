# Image de base Node.js
FROM node:alpine as base

# Installation des dépendances
COPY package.json  /app/
WORKDIR /app
RUN npm install
EXPOSE 80

# Ajout des fichiers du projet
ADD . /app
RUN npm run build

FROM nginx:alpine

COPY --from=base /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]