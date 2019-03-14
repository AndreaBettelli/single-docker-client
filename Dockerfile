# fase 1: in sviluppo costruisco la dir build
FROM node:10.15.3-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# fase 2: costruisco l'ambiente di PROD, prendendo dalla
# fase 1 (builder) solo e soltanto la dir /app/build.
# Tutto il resto viene scartato.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

