FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /mytest_heroku
COPY Gemfile /mytest_heroku/Gemfile
COPY Gemfile.lock /mytest_heroku/Gemfile.lock
RUN gem install bundler && bundle install
COPY . /mytest_heroku

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]