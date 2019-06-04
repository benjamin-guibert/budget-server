FROM ruby:latest

RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
  gem update --system && \
  gem update bundler --user-install && \
  bundle install
COPY . .

COPY scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

EXPOSE 3000

CMD ["rails", "server", "-e", "production", "-p", "3000", "-b", "0.0.0.0"]
