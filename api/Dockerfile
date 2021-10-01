FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

RUN mkdir /high10_io
ENV APP_ROOT /high10_io
WORKDIR ${APP_ROOT}
ADD ./Gemfile ${APP_ROOT}/Gemfile
ADD ./Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install --jobs=4
ADD . ${APP_ROOT}

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]