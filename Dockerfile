FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /schedule_api_docker
WORKDIR /schedule_api
COPY Gemfile /schedule_api/Gemfile
COPY Gemfile /schedule_api/Gemfile.lock
ENV BUNDLER_VERSION 2.0.1
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . /schedule_api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]