# STAGE 1 : CREE L"IMAGE DE L'APPLICATION NODEJS
# Mon conteneur va etre cree a partir de quel image ?
# From an nodejs image
FROM node:15.4 as build
# ICI JE PRECISE LE FICHIER QUI VA ETRE EXECUTE
WORKDIR /app
# ICI JE COPIE LE PACKAGE.JSON DANS LE CONTAINER DANS LE FICHIER /app
# L'ETOILE DIT COPY TOUT CE QUI EST DANS LE REPERTOIRE AVEC LE MOT CLE PACKAGE.<NOM DU PACKAGE>.JSON
COPY package*.json ./app
# LANCE LA COMMANDE npm INSTALL, NPM SERA DURECTEMENT INSTALLER DANS LE CONTAINER VU QUE C'EST UNE IMAGE NODEJS
RUN npm install
# COPIE TOUT LES FICHIER DE NODE_MODULES DANS LE CONTAINER DANS LE REPERTOIRE /app
COPY . /app
# LANCE LA COMMANDE npm RUN BUILD , VA CREER LE FICHIER DE BUILD DE L'APPLICATION
RUN npm run build

# CREE UN AUTRE CONTAINER POUR L'APPLICATION A PARTIR DE L'IMAGE NGINX
FROM nginx
# COPY NGINX.CONF DANS LE CONTAINER
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# COPY LE FICHIER DE BUILD DANS LE CONTAINER , DANS LE WORKING DIRECTORY
COPY --from=build /app/dist /usr/share/nginx/html 