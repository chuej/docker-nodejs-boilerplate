FROM chuej/mini-nodejs

ENV APP_DIR=/opt/app

ADD package.json /tmp/package.json
RUN cd /tmp && npm install && \
  mkdir -p ${APP_DIR} && \
  ln -s /tmp/node_modules ${APP_DIR}/

ADD . ${APP_DIR}
WORKDIR ${APP_DIR}


EXPOSE 5000
ENV PORT 5000

CMD ["sh", "bin/www"]
