#Build stage
From node:18-alpine As build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

#Deploy Stage

FROM node:18-alpine

WORKDIR /app

COPY --from=build /app/dist ./dist

RUN npm install -g http-server

#Expose
EXPOSE 8080

CMD ["http-server", "dist", "-p", "8080", "-c-1"]
