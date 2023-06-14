FROM node:14

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install express dockerode
RUN npm ci --production

COPY index.js ./

EXPOSE 80

CMD ["node", "index.js"]
