# Dockerfile development version
FROM ruby:3.1.2 AS hello-development

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Default directory
ENV INSTALL_PATH="/opt/app"
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY hello/ .

# Install gems, etc
RUN rm -rf node_modules vendor
RUN gem install rails:7.2.2 bundler:2.6.8
RUN bundle install
RUN yarn install

# Start server
CMD bundle exec unicorn -c config/unicorn.rb