FROM ruby:2.3.1-slim
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_ROOT /var/www/docker
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
ADD Gemfile* $APP_ROOT/
RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT

EXPOSE 80
CMD ["bundle", "exec", "rackup", "config.ru", "-p", "80", "-s", "puma", "--host", "0.0.0.0"]
