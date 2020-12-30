FROM node:14

RUN curl https://dist.ipfs.io/go-ipfs/v0.6.0/go-ipfs_v0.6.0_linux-amd64.tar.gz | tar -xz \
 && go-ipfs/install.sh && rm -r go-ipfs

WORKDIR /orbit-db

COPY package.json ./
COPY src/ ./src
COPY conf/ ./conf
COPY scripts/ipfs.sh /scripts/ipfs.sh

RUN chown -R node:node package.json examples src conf
USER node

RUN npm install babel-cli webpack \
 && npm install \
 && npm build:dist

CMD ["/scripts/ipfs.sh"]