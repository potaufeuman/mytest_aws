FROM ruby:2.5.8
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    apt-get install -y nginx

# Nginx
ADD nginx.conf /etc/nginx/sites-available/app.conf
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf

# Rails App
WORKDIR /mytest_aws
ENV RAILS_ENV="production"
COPY Gemfile /mytest_aws/Gemfile
COPY Gemfile.lock /mytest_aws/Gemfile.lock
RUN gem install bundler && bundle install
COPY . /mytest_aws
RUN mkdir /mytest_aws/tmp/sockets

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
EXPOSE 80

# Start the main process.
# CMD bundle exec puma -d && \
#     /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"] && \
    /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf