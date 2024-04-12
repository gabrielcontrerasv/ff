# Etapa de construcción
FROM node:20-alpine AS build
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

# Etapa de producción
FROM node:20-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/build ./build
EXPOSE 80
CMD ["npx", "serve", "-s", "build", "-l", "80"]
