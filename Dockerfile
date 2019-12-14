FROM ruby:2.6.3

ENV NODE_VERSION 10

RUN apt-get update -qq
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN apt-get install -y --no-install-recommends nodejs vim

RUN mkdir -p /dog-api

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle install
RUN gem install bundler-audit

WORKDIR /dog-api
ADD . /dog-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Brazil/East /etc/localtime
