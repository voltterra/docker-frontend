# build stage
FROM node:alpine as builder
WORKDIR '/app'
RUN chown -R node:node /app
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

# run stage
FROM nginx
EXPOSE 80
COPY --from=builder --chown=nginx:nginx /app/build /usr/share/nginx/html