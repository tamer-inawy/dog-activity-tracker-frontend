FROM node:22.18.0 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build:prod

FROM node:22.18.0

WORKDIR /app

RUN npm install -g http-server

COPY --from=builder /app/dist/dog-activity-tracker ./dist

EXPOSE 4200

CMD ["http-server", "dist", "-p", "4200", "-c-1", "-o"]
