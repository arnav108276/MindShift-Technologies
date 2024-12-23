FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV NODE_ENV=production
EXPOSE 8081
RUN npm run build
CMD ["npm","start"]
