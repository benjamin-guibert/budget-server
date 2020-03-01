FROM ruby:latest

ARG BIN_PATH=/usr/bin
ARG APP_PATH=/usr/src/app

ENV PORT=3000
ENV ENVIRONMENT=development

RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client

WORKDIR ${APP_PATH}

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
  gem update --system && \
  gem update bundler --user-install && \
  bundle install

COPY . .

COPY ./config/database.docker.yml ./config/database.yml

COPY scripts/entrypoint.sh ${BIN_PATH}/
RUN chmod +x ${BIN_PATH}/entrypoint.sh

EXPOSE ${PORT}

ENTRYPOINT [ "entrypoint.sh" ]

CMD ["sh", "-c", "rails server -e ${ENVIRONMENT} -p ${PORT} -b 0.0.0.0"]
