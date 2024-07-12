FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /social_media_app

COPY Gemfile /social_media_app/Gemfile
COPY Gemfile.lock /social_media_app/Gemfile.lock

RUN bundle install

COPY . /social_media_app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
