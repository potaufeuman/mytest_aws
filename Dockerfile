FROM ruby:2.5.8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /mytest_aws
COPY Gemfile /mytest_aws/Gemfile
COPY Gemfile.lock /mytest_aws/Gemfile.lock
RUN gem install bundler && bundle install
COPY . /mytest_aws

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
EXPOSE 80

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]