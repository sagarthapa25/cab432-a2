# Setup and build the client

FROM node:12 as client

WORKDIR /usr/src/app/client/
COPY client/package*.json ./
RUN yarn install 
COPY client/ ./
RUN yarn run build


# Setup the server

FROM node:12

WORKDIR /usr/src/app/
COPY --from=client /usr/src/app/client/build/ ./client/build/

WORKDIR /usr/src/app/server/
COPY server/package*.json ./
RUN yarn install
COPY server/ ./

ENV PORT 8000

EXPOSE 8000

CMD ["yarn", "start"]